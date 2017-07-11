using Uno;
using Uno.Compiler.ExportTargetInterop;

namespace OpenGL
{
    public extern(OPENGL) enum GLDebugSource
    {
        API = 0x8246,
        WindowSystem = 0x8247,
        ShaderCompiler = 0x8248,
        ThirdParty = 0x8249,
        SourceApplication = 0x824A,
        Other = 0x824B
    }

    public extern(OPENGL) enum GLDebugType
    {
        Error = 0x824C,
        DeprecatedBehavior = 0x824D,
        UndefinedBehavior = 0x824E,
        Portability = 0x824F,
        Performance = 0x8250,
        Other = 0x8251,
        Marker = 0x8268
    };

    public extern(OPENGL) enum GLDebugSeverity
    {
        High = 0x9146,
        Medium = 0x9147,
        Low = 0x9148,
        Notification = 0x826B
    }

    [extern(CPLUSPLUS) Require("Source.Include", "Uno/Support.h")]
    [extern(CPLUSPLUS) Require("Source.Include", "XliPlatform/GL.h")]
    [extern(CPLUSPLUS) Require("Source.Include", "EGL/egl.h")]
    [extern(CPLUSPLUS) Require("Source.Declaration", "typedef void (GL_APIENTRY  *GLDEBUGPROCKHR)(GLenum source,GLenum type,GLuint id,GLenum severity,GLsizei length,const GLchar *message,const void *userParam);")]
    [extern(CPLUSPLUS) Require("Source.Declaration", "typedef void (GL_APIENTRYP PFNGLDEBUGMESSAGECALLBACKKHRPROC) (GLDEBUGPROCKHR callback, const void *userParam);")]
    [extern(CPLUSPLUS) Require("Source.Declaration", "typedef void (GL_APIENTRYP PFNGLDEBUGMESSAGEINSERTKHRPROC) (GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar *buf);")]
    [extern(CPLUSPLUS) Require("Source.Declaration", "#define GL_DEBUG_OUTPUT_KHR 0x92E0")]
    [extern(CPLUSPLUS) Require("Source.Declaration", "#define GL_DEBUG_OUTPUT_SYNCHRONOUS 0x8242")]
    extern(OPENGL) public static class GLDebug
    {
        public delegate void DebugProc(GLDebugSource source, GLDebugType type, uint id, GLDebugSeverity severity, string message);

        public static void DebugMessageCallback(DebugProc callback)
        {
            if defined(CPLUSPLUS)
            @{
                static PFNGLDEBUGMESSAGECALLBACKKHRPROC glDebugMessageCallbackKHR = (PFNGLDEBUGMESSAGECALLBACKKHRPROC)eglGetProcAddress("glDebugMessageCallbackKHR");

                if (callback == NULL)
                {
                    glDebugMessageCallbackKHR(NULL, NULL);
                    glDisable(GL_DEBUG_OUTPUT_KHR);
                }
                else
                {
                    uRetain(callback); // HACK: leaking
                    glDebugMessageCallbackKHR(uGLDebugProcWrapper, callback);
                    glEnable(GL_DEBUG_OUTPUT_KHR);
                    glEnable(GL_DEBUG_OUTPUT_SYNCHRONOUS);
                }
            @}
        }

        public static void DebugMessageInsert(GLDebugSource source, GLDebugType type, uint id, GLDebugSeverity severity, string message)
        {
            if defined(CPLUSPLUS)
            @{
                static PFNGLDEBUGMESSAGEINSERTKHRPROC glDebugMessageInsertKHR = (PFNGLDEBUGMESSAGEINSERTKHRPROC)eglGetProcAddress("glDebugMessageInsertKHR");

                const char* buf = uAllocCStr(message);
                glDebugMessageInsertKHR(source, type, id, severity, strlen(buf), buf);
                uFreeCStr(buf);
            @}
        }
    }
}
