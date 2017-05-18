using Uno.Compiler.ExportTargetInterop;
using Uno;

namespace OpenGL
{
    public extern(CPLUSPLUS && EGL) enum EGLConfigAttrib
    {
        BufferSize             = 0x3020,
        AlphaSize              = 0x3021,
        BlueSize               = 0x3022,
        GreenSize              = 0x3023,
        RedSize                = 0x3024,
        DepthSize              = 0x3025,
        StencilSize            = 0x3026,
        ConfigCaveat           = 0x3027,

        ConfigID               = 0x3028,
        Level                  = 0x3029,
        MaxPbufferHeight       = 0x302A,
        MaxPbufferPixels       = 0x302B,
        MaxPbufferWidth        = 0x302C,
        NativeRenderable       = 0x302D,
        NativeVisualID         = 0x302E,
        NativeVisualType       = 0x302F,
        Samples                = 0x3031,
        SampleBuffers          = 0x3032,
        SurfaceType            = 0x3033,
        TransparentType        = 0x3034,
        TransparentBlueValue   = 0x3035,
        TransparentGreenValue  = 0x3036,
        TransparentRedValue    = 0x3037,
        None                   = 0x3038, // Also a config value
        BindToTextureRGB       = 0x3039, // EGL 1.1
        BindToTextureRGBA      = 0x303A, // "
        MinSwapInterval        = 0x303B, // "
        MaxSwapInterval        = 0x303C  // "
    }

    public extern(CPLUSPLUS && EGL) enum EGLContextAttrib
    {
        ConfigID               = 0x3028  // same value as EGLConfigAttrib.ConfigID
    }

    public extern(CPLUSPLUS && EGL) enum EGLError
    {
        Success           = 0x3000,
        NotInitialized    = 0x3001,
        BadAccess         = 0x3002,
        BadAlloc          = 0x3003,
        BadAttribute      = 0x3004,
        BadConfig         = 0x3005,
        BadContext        = 0x3006,
        BadCurrentSurface = 0x3007,
        BadDisplay        = 0x3008,
        BadMatch          = 0x3009,
        BadNativePixmap   = 0x300A,
        BadNativeWindow   = 0x300B,
        BadParameter      = 0x300C,
        BadSurface        = 0x300D,
        ContextLost       = 0x300E  // EGL 1.1
    }

    public extern(CPLUSPLUS && EGL) enum EGLQueryString
    {
        Vendor     = 0x3053,
        Version    = 0x3054,
        Extensions = 0x3055
    }

    public extern(CPLUSPLUS && EGL) enum EGLReadDraw
    {
        Draw = 0x3059,
        Read = 0x305A
    }

    public extern(CPLUSPLUS && EGL) enum EGLSurfaceAttrib
    {
        None           = 0x3038, // same value as EGLConfigAttrib.None
        Height         = 0x3056,
        Width          = 0x3057,
        LargestPbuffer = 0x3058,
        TextureFormat  = 0x3080,  // EGL 1.1, For pbuffers bound as textures
        TextureTarget  = 0x3081,  // "
        MipmapTexture  = 0x3082,  // "
        MipmapLevel    = 0x3083   // "
    }

    public extern(CPLUSPLUS && EGL) enum EGLWaitEngine
    {
        CoreNativeEngine = 0x305B
    }
}
