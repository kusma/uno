using Uno.Compiler.ExportTargetInterop;

namespace OpenGL
{
    [TargetSpecificType]
    [Set("Include", "EGL/EGL.h")]
    [Set("TypeName", "EGLNativePixmapType")]
    public extern(CPLUSPLUS && EGL) struct EGLNativePixmapHandle
    {
        public static bool operator == (EGLNativePixmapHandle left, EGLNativePixmapHandle right)
        {
            return extern<bool> "$0 == $1";
        }

        public static bool operator != (EGLNativePixmapHandle left, EGLNativePixmapHandle right)
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
