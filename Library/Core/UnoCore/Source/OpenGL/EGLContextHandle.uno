using Uno.Compiler.ExportTargetInterop;

namespace OpenGL
{
    [TargetSpecificType]
    [Set("Include", "EGL/EGL.h")]
    [Set("TypeName", "EGLSurface")]
    [Set("DefaultValue", "EGL_NO_SURFACE")]
    public extern(CPLUSPLUS && EGL) struct EGLContextHandle
    {
        public static readonly EGLContextHandle NoContext;

        public static bool operator == (EGLContextHandle left, EGLContextHandle right)
        {
            return extern<bool> "$0 == $1";
        }

        public static bool operator != (EGLContextHandle left, EGLContextHandle right)
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
