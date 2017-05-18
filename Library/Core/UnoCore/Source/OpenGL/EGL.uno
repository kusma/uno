using Uno.Compiler.ExportTargetInterop;
using Uno;

namespace OpenGL
{
    /**
        Uno wrappers for the EGL 1.1 API

        This class expose most of the API methods from EGL 1.1

        The only EGL 1.1 API call that is missing, is eglGetProcAddress. This
        is because uno has no idea how to call a generic function-pointer.
    */
    [extern(CPLUSPLUS) Require("Source.Include", "EGL/EGL.h")]
    extern(CPLUSPLUS && EGL) public static class EGL
    {
        public static EGLError GetError()
        @{
            return eglGetError();
        @}

        public static EGLDisplayHandle GetDisplay(EGLNativeDisplayHandle display_id)
        @{
            return eglGetDisplay(display_id);
        @}

        public static bool Initialize(EGLDisplayHandle display, out int major, out int minor)
        @{
            return eglInitialize(display, major, minor) != EGL_FALSE;
        @}

        public static bool Terminate(EGLDisplayHandle dpy)
        @{
            return eglTerminate(dpy) != EGL_FALSE;
        @}

        public static string QueryString(EGLDisplayHandle dpy, EGLQueryString name)
        @{
            return uString::Utf8(eglQueryString(dpy, name));
        @}

        public static bool GetConfigs(EGLDisplayHandle dpy, EGLConfigHandle[] configs, out int numConfig)
        @{
            if (configs == NULL)
                return eglGetConfigs(dpy, NULL, 0, numConfig) != EGL_FALSE;
            else
                return eglGetConfigs(dpy, (EGLConfig *)configs->Ptr(), configs->Length(), numConfig) != EGL_FALSE;
        @}

        public static bool ChooseConfig(EGLDisplayHandle dpy, int[] attribList, EGLConfigHandle[] configs, out int numConfig)
        @{
            EGLint *attrib_list = attribList != NULL ? (EGLint *)attribList->Ptr() : NULL;
            if (configs == NULL)
                return eglChooseConfig(dpy, attrib_list, NULL, 0, numConfig) != EGL_FALSE;
            else
                return eglChooseConfig(dpy, attrib_list, (EGLConfig *)configs->Ptr(), configs->Length(), numConfig) != EGL_FALSE;
        @}

        public static bool GetConfigAttrib(EGLDisplayHandle dpy, EGLConfigHandle config, EGLConfigAttrib attribute, out int value)
        @{
            return eglGetConfigAttrib(dpy, config, attribute, value) != EGL_FALSE;
        @}

        public static EGLSurfaceHandle CreateWindowSurface(EGLDisplayHandle dpy, EGLConfigHandle config, EGLNativeWindowHandle win, int[] attribList)
        @{
            return eglCreateWindowSurface(dpy, config, win, attribList != NULL ? (EGLint *)attribList->Ptr() : NULL);
        @}

        public static EGLSurfaceHandle CreatePbufferSurface(EGLDisplayHandle dpy, EGLConfigHandle config, int[] attribList)
        @{
            return eglCreatePbufferSurface(dpy, config, attribList != NULL ? (EGLint *)attribList->Ptr() : NULL);
        @}

        public static EGLSurfaceHandle CreatePixmapSurface(EGLDisplayHandle dpy, EGLConfigHandle config, EGLNativePixmapHandle pixmap, int[] attribList)
        @{
            return eglCreatePixmapSurface(dpy, config, pixmap, attribList != NULL ? (EGLint *)attribList->Ptr() : NULL);
        @}

        public static bool DestroySurface(EGLDisplayHandle dpy, EGLSurfaceHandle surface)
        @{
            return eglDestroySurface(dpy, surface);
        @}

        public static bool QuerySurface(EGLDisplayHandle dpy, EGLSurfaceHandle surface, EGLSurfaceAttrib attribute, out int value)
        @{
            return eglQuerySurface(dpy, surface, attribute, value) != EGL_FALSE;
        @}

        public static EGLContextHandle CreateContext(EGLDisplayHandle dpy, EGLConfigHandle config, EGLContextHandle shareContext, int[] attribList)
        @{
            return eglCreateContext(dpy, config, shareContext, attribList != NULL ? (EGLint *)attribList->Ptr() : NULL);
        @}

        public static bool DestroyContext(EGLDisplayHandle dpy, EGLContextHandle ctx)
        @{
            return eglDestroyContext(dpy, ctx) != EGL_FALSE;
        @}

        public static bool MakeCurrent(EGLDisplayHandle dpy, EGLSurfaceHandle draw, EGLSurfaceHandle read, EGLContextHandle ctx)
        @{
            return eglMakeCurrent(dpy, draw, read, ctx) != EGL_FALSE;
        @}

        public static EGLContextHandle GetCurrentContext()
        @{
            return eglGetCurrentContext();
        @}

        public static EGLSurfaceHandle GetCurrentSurface(EGLReadDraw readdraw)
        @{
            return eglGetCurrentSurface(readdraw);
        @}

        public static EGLDisplayHandle GetCurrentDisplay()
        @{
            return eglGetCurrentDisplay();
        @}

        public static bool QueryContext(EGLDisplayHandle dpy, EGLContextHandle ctx, int attribute, out int value)
        @{
            return eglQueryContext(dpy, ctx, attribute, value) != EGL_FALSE;
        @}

        public static bool WaitGL()
        @{
            return eglWaitGL() != EGL_FALSE;
        @}

        public static bool WaitNative(EGLWaitEngine engine)
        @{
            return eglWaitNative(engine) != EGL_FALSE;
        @}

        public static bool SwapBuffers(EGLDisplayHandle dpy, EGLSurfaceHandle surface)
        @{
            return eglSwapBuffers(dpy, surface) != EGL_FALSE;
        @}

        public static bool CopyBuffers(EGLDisplayHandle dpy, EGLSurfaceHandle surface, EGLNativePixmapHandle target)
        @{
            return eglCopyBuffers(dpy, surface, target) != EGL_FALSE;
        @}

/*
        EGLAPI void (* APIENTRY eglGetProcAddress(const char *procname))();
*/

        // EGL 1.1
        public static bool SurfaceAttrib(EGLDisplayHandle dpy, EGLSurfaceHandle surface, EGLSurfaceAttrib attribute, int value)
        @{
            return eglSurfaceAttrib(dpy, surface, attribute, value) != EGL_FALSE;
        @}

        // EGL 1.1
        public static bool BindTexImage(EGLDisplayHandle dpy, EGLSurfaceHandle surface, int buffer)
        @{
            return eglBindTexImage(dpy, surface, buffer) != EGL_FALSE;
        @}

        // EGL 1.1
        public static bool ReleaseTexImage(EGLDisplayHandle dpy, EGLSurfaceHandle surface, int buffer)
        @{
            return eglReleaseTexImage(dpy, surface, buffer) != EGL_FALSE;
        @}

        // EGL 1.1
        public static bool SwapInterval(EGLDisplayHandle dpy, int interval)
        @{
            return eglSwapInterval(dpy, interval) != EGL_FALSE;
        @}
    }
}
