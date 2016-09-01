using Uno.Compiler.ExportTargetInterop;

namespace OpenGL
{
    [TargetSpecificType]
    [Set("Include", "EGL/EGL.h")]
    [Set("TypeName", "EGLConfig")]
    public extern(CPLUSPLUS && EGL) struct EGLConfigHandle
    {
        public static bool operator == (EGLConfigHandle left, EGLConfigHandle right)
        {
            return extern<bool> "$0 == $1";
        }

        public static bool operator != (EGLConfigHandle left, EGLConfigHandle right)
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
