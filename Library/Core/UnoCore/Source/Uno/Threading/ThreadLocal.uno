using Uno.Compiler.ExportTargetInterop;

namespace Uno.Threading
{
    [extern(DOTNET) DotNetType("System.Threading.ThreadLocal`1")]
    [extern(CPLUSPLUS) Require("Source.Include", "uBase/Thread.h")]
    [extern(CPLUSPLUS) Require("Source.Declaration", "static void FreeThreadLocal(void *ptr) { uRelease((uObject *)ptr); } ")]
    public class ThreadLocal<T> : IDisposable
    {
        [TargetSpecificType]
        [Set("TypeName", "uBase::ThreadLocal *")]
        extern(CPLUSPLUS) internal struct Handle
        {
        }

        extern(CPLUSPLUS) Handle _handle;
        extern(JAVASCRIPT) T _value = default(T);

        extern(CPLUSPLUS)public ThreadLocal()
        {
            if defined(CPLUSPLUS)
            @{
                _handle = uBase::CreateThreadLocal(FreeThreadLocal);
            @}
            else if defined(JAVASCRIPT)
                return;
            else
                throw new NotImplementedException();
        }

        public void Dispose()
        {
            if defined(CPLUSPLUS)
            @{
                uBase::DeleteThreadLocal((uBase::ThreadLocal *)_handle);
            @}
            else if defined(JAVASCRIPT)
                return;
            else
                throw new NotImplementedException();
        }

        public T Value
        {
            get
            {
                if defined(CPLUSPLUS)
                {
                    var obj = extern<object>(_handle)"(uObject *)uBase::GetThreadLocal((uBase::ThreadLocal *)$0)";

                    if (obj == null)
                        return default(T);

                    return (T)obj;
                }
                else if defined(JAVASCRIPT)
                    return _value;
                else
                    throw new NotImplementedException();
            }
            set
            {
                if defined(CPLUSPLUS)
                {
                    var obj = (object)value;
                    var oldObj = extern<object>(_handle)"(uObject *)uBase::GetThreadLocal((uBase::ThreadLocal *)$0)";

                    extern(obj) "uRetain($0)";
                    extern(_handle, obj) "uBase::SetThreadLocal((uBase::ThreadLocal *)$0, $1)";
                    extern(oldObj) "uRelease($0)";
                }
                else if defined(JAVASCRIPT)
                {
                    _value = value;
                    return;
                }
                else
                    throw new NotImplementedException();
            }
        }
    }
}
