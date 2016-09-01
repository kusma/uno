using Uno.Compiler.ExportTargetInterop;

namespace OpenGL
{
    [TargetSpecificType]
    [Set("Include", "EGL/EGL.h")]
    [Set("TypeName", "EGLSurface")]
    [Set("DefaultValue", "EGL_NO_SURFACE")]
    public extern(CPLUSPLUS && EGL) struct EGLSurfaceHandle
    {
        public static readonly EGLSurfaceHandle NoSurface;

        public static bool operator == (EGLSurfaceHandle left, EGLSurfaceHandle right)
        {
            return extern<bool> "$0 == $1";
        }

        public static bool operator != (EGLSurfaceHandle left, EGLSurfaceHandle right)
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
