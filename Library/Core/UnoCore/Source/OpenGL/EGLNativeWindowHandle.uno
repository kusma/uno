using Uno.Compiler.ExportTargetInterop;

namespace OpenGL
{
    [TargetSpecificType]
    [Set("Include", "EGL/EGL.h")]
    [Set("TypeName", "EGLNativeWindowType")]
    public extern(CPLUSPLUS && EGL) struct EGLNativeWindowHandle
    {
        public static bool operator == (EGLNativeWindowHandle left, EGLNativeWindowHandle right)
        {
            return extern<bool> "$0 == $1";
        }

        public static bool operator != (EGLNativeWindowHandle left, EGLNativeWindowHandle right)
        {
            return extern<bool> "$0 != $1";
        }

        // Silence warning
        public override int GetHashCode()
        {
            return base.GetHashCode();
        }

        // Silence warning
        public override bool Equals(object obj)
        {
            return base.Equals(obj);
        }
    }
}
