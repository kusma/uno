@{Uno.IntPtr:IncludeDirective}

#ifdef __APPLE__

#include <execinfo.h>
uArray* uGetNativeStackTrace(int skipFrames)
{
    void* callStack[64];
    int callStackDepth = backtrace(callStack, sizeof(callStack) / sizeof(callStack[0]));
    return uArray::New(@{Uno.IntPtr[]:TypeOf}, callStackDepth - skipFrames, callStack + skipFrames);
}

uString* uGetStackFrameSymbol(void *stackFrame)
{
    return NULL;
}

#elif defined(__GNUC__)

#include <unwind.h>

struct uUnwindState
{
    int _skipFrames;
    int _callStackDepth;
    void* _callStack[64];
};

static _Unwind_Reason_Code uUnwindCallback(struct _Unwind_Context* context, void *arg)
{
    uUnwindState* state = (uUnwindState*)arg;

    if (state->_skipFrames > 0)
    {
        state->_skipFrames--;
        return _URC_NO_REASON;
    }

    void* pc = (void*)_Unwind_GetIP(context);
    if (pc)
    {
        if (state->_callStackDepth == sizeof(state->_callStack) / sizeof(state->_callStack[0]))
            return _URC_END_OF_STACK;
        else
            state->_callStack[state->_callStackDepth++] = pc;
    }
    return _URC_NO_REASON;
}

// Use GCC's libunwind

uArray* uGetNativeStackTrace(int skipFrames)
{
    uUnwindState state = {
        skipFrames,
        0,
        { 0 }
    };

    _Unwind_Backtrace(uUnwindCallback, &state);
    return uArray::New(@{Uno.IntPtr[]:TypeOf}, state._callStackDepth, state._callStack);
}

#include <dlfcn.h>

uString* uGetStackFrameSymbol(void *stackFrame)
{
    Dl_info info;
    if (dladdr(stackFrame, &info) && info.dli_sname)
        return uString::Ansi(info.dli_sname, strlen(info.dli_sname));

    return NULL;
}

#elif defined(WIN32)

// Windows provides a simple API for this
#include <windows.h>

uArray* uGetNativeStackTrace(int skipFrames)
{
    void* callStack[64];
    int callStackDepth = CaptureStackBackTrace(skipFrames, sizeof(callStack) / sizeof(callStack[0]), callStack, NULL);
    return uArray::New(@{Uno.IntPtr[]:TypeOf}, callStackDepth, callStack);
}

// there's also some APIs for this:
#include <Dbghelp.h>
#pragma comment(lib, "dbghelp.lib") // YEAH, I'M BEING LAZY AND LAME!

uString* uGetStackFrameSymbol(void *stackFrame)
{
    struct {
        SYMBOL_INFO symbolInfo;
        char buffer[256];
    } symbol;
    symbol.symbolInfo.SizeOfStruct = sizeof(SYMBOL_INFO);
    symbol.symbolInfo.MaxNameLen = sizeof(symbol.buffer);

    if (!SymFromAddr(GetCurrentProcess(), (DWORD64)stackFrame, NULL, &symbol.symbolInfo))
        return NULL;

    return uString::Ansi(symbol.symbolInfo.Name, symbol.symbolInfo.NameLen);
}

#else

// last resort, we don't have any way of getting a native stack-trace, return NULL :(
uArray* uGetNativeStackTrace(int skipFrames)
{
    return NULL;
}

uString* uGetStackFrameSymbol(void *stackFrame)
{
    return NULL;
}

#endif
