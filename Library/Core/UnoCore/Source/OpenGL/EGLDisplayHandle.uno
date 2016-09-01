using Uno.Compiler.ExportTargetInterop;

namespace OpenGL
{
    [TargetSpecificType]
    [Set("Include", "EGL/EGL.h")]
    [Set("TypeName", "EGLDisplay")]
    [Set("DefaultValue", "EGL_NO_DISPLAY")]
    public extern(CPLUSPLUS && EGL) struct EGLDisplayHandle
    {
        public static readonly EGLDisplayHandle NoDisplay;

        public static bool operator == (EGLDisplayHandle left, EGLDisplayHandle right)
        {
            return extern<bool> "$0 == $1";
        }

        public static bool operator != (EGLDisplayHandle left, EGLDisplayHandle right)
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
