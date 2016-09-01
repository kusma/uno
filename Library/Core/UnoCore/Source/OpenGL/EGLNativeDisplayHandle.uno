using Uno.Compiler.ExportTargetInterop;

namespace OpenGL
{
    [TargetSpecificType]
    [Set("Include", "EGL/EGL.h")]
    [Set("TypeName", "EGLNativeDisplayType")]
    [Set("DefaultValue", "EGL_DEFAULT_DISPLAY")]
    public extern(CPLUSPLUS && EGL) struct EGLNativeDisplayHandle
    {
        public static readonly EGLNativeDisplayHandle DefaultDisplay;

        public static bool operator == (EGLNativeDisplayHandle left, EGLNativeDisplayHandle right)
        {
            return extern<bool> "$0 == $1";
        }

        public static bool operator != (EGLNativeDisplayHandle left, EGLNativeDisplayHandle right)
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
