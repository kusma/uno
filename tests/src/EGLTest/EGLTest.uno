using Uno;
using Uno.Diagnostics;
using OpenGL;

public class EGLTest : Application
{
    static void TestQueryString(EGLDisplayHandle dpy)
    {
        var vendor = EGL.QueryString(dpy, EGLQueryString.Vendor);
        var version = EGL.QueryString(dpy, EGLQueryString.Version);
        var extensions = EGL.QueryString(dpy, EGLQueryString.Extensions);

        Debug.Log("EGL vendor: " + vendor);
        Debug.Log("EGL version: " + version);
        Debug.Log("EGL extensions: " + extensions);
    }

    static void TestGetConfigs(EGLDisplayHandle dpy)
    {
        int numConfig;
        if (!EGL.GetConfigs(dpy, null, out numConfig))
            throw new Exception("EGL.GetConfigs failed: " + EGL.GetError());

        var configs = new EGLConfigHandle[numConfig];
        if (!EGL.GetConfigs(dpy, configs, out numConfig))
            throw new Exception("EGL.GetConfigs failed: " + EGL.GetError());

        for (int i = 0; i < numConfig; ++i)
        {
            Debug.Log("EGLConfig #" + i);
            int redSize = 0, greenSize = 0, blueSize = 0;
            if (!EGL.GetConfigAttrib(dpy, configs[i], EGLConfigAttrib.RedSize, out redSize) ||
                !EGL.GetConfigAttrib(dpy, configs[i], EGLConfigAttrib.GreenSize, out greenSize) ||
                !EGL.GetConfigAttrib(dpy, configs[i], EGLConfigAttrib.BlueSize, out blueSize))
                throw new Exception("EGL.GetConfigAttrib failed: " + EGL.GetError());

            Debug.Log("RedSize: " + redSize);
            Debug.Log("GreenSize: " + greenSize);
            Debug.Log("BlueSize: " + blueSize);
            Debug.Log("");
        }
    }

    static void TestChooseConfig(EGLDisplayHandle dpy)
    {
        var configAttribs = new int[]
        {
                EGLConfigAttrib.RedSize, 1,
                EGLConfigAttrib.GreenSize, 1,
                EGLConfigAttrib.BlueSize, 1,
                EGLConfigAttrib.None
        };

        var configs = new EGLConfigHandle[1];
        int numConfig;
        if (!EGL.ChooseConfig(dpy, configAttribs, configs, out numConfig))
            throw new Exception("EGL.ChooseConfig failed: " + EGL.GetError());

        int redSize = 0, greenSize = 0, blueSize = 0;
        if (!EGL.GetConfigAttrib(dpy, configs[0], EGLConfigAttrib.RedSize, out redSize) ||
            !EGL.GetConfigAttrib(dpy, configs[0], EGLConfigAttrib.GreenSize, out greenSize) ||
            !EGL.GetConfigAttrib(dpy, configs[0], EGLConfigAttrib.BlueSize, out blueSize))
            throw new Exception("EGL.GetConfigAttrib failed: " + EGL.GetError());

        Debug.Log("RedSize: " + redSize);
        Debug.Log("GreenSize: " + greenSize);
        Debug.Log("BlueSize: " + blueSize);
    }

    static void TestQuerySurface(EGLDisplayHandle dpy, EGLSurfaceHandle surface)
    {
        int width = 0, height = 0;
        if (!EGL.QuerySurface(dpy, surface, EGLSurfaceAttrib.Width, out width) ||
            !EGL.QuerySurface(dpy, surface, EGLSurfaceAttrib.Height, out height))
            throw new Exception("EGL.QuerySurface failed: " + EGL.GetError());

        Debug.Log("Width: " + width);
        Debug.Log("Height: " + height);
    }

    static void TestQueryContext(EGLDisplayHandle dpy, EGLContextHandle ctx)
    {
        int configID;
        if (!EGL.QueryContext(dpy, ctx, EGLContextAttrib.ConfigID, out configID))
            throw new Exception("EGL.QueryContext failed: " + EGL.GetError());

        Debug.Log("ConfigID: " + configID);
    }

    EGLConfigHandle ChooseConfig(EGLDisplayHandle dpy)
    {
        var configAttribs = new int[]
        {
                EGLConfigAttrib.RedSize, 1,
                EGLConfigAttrib.GreenSize, 1,
                EGLConfigAttrib.BlueSize, 1,
                EGLConfigAttrib.None
        };

        var configs = new EGLConfigHandle[1];
        int numConfig;
        if (!EGL.ChooseConfig(dpy, configAttribs, configs, out numConfig))
            throw new Exception("EGL.ChooseConfig failed: " + EGL.GetError());

        if (numConfig != 1)
            throw new Exception("numComfig != 1");

        return configs[0];
    }

    public EGLTest()
    {
        try
        {
            Debug.Log("initial error: " + EGL.GetError());

            var dpy = EGL.GetDisplay(EGLNativeDisplayHandle.DefaultDisplay);
            int major, minor;
            if (!EGL.Initialize(dpy, out major, out minor))
                throw new Exception("EGL.Initialize failed: " + EGL.GetError());
            Debug.Log("EGL version: " + major + "." + minor);

            TestQueryString(dpy);
            TestGetConfigs(dpy);
            TestChooseConfig(dpy);

            // TODO: test CreateWindowSurface

            var config = ChooseConfig(dpy);

            var surfaceAttribs = new int[]
            {
                EGLSurfaceAttrib.Width, 1024,
                EGLSurfaceAttrib.Height, 16,
                EGLSurfaceAttrib.None
            };

            var surface = EGL.CreatePbufferSurface(dpy, config, surfaceAttribs);
            if (surface == EGLSurfaceHandle.NoSurface)
                throw new Exception("EGL.CreatePbufferSurface failed: " + EGL.GetError());

            // TODO: test CreatePixmapSurface

            TestQuerySurface(dpy, surface);

            var ctx = EGL.CreateContext(dpy, config, EGLContextHandle.NoContext, null);
            if (ctx == EGLContextHandle.NoContext)
                throw new Exception("EGL.CreateContext failed: " + EGL.GetError());

            TestQueryContext(dpy, ctx);

            if (!EGL.MakeCurrent(dpy, surface, surface, ctx))
                throw new Exception("EGL.MakeCurrent failed: " + EGL.GetError());

            if (EGL.GetCurrentContext() != ctx)
                throw new Exception("Wrong current context!");

            if (EGL.GetCurrentSurface(EGLReadDraw.Read) != surface)
                throw new Exception("Wrong current read-surface!");

            if (EGL.GetCurrentSurface(EGLReadDraw.Draw) != surface)
                throw new Exception("Wrong current draw-surface!");

            if (EGL.GetCurrentDisplay() != dpy)
                throw new Exception("Wrong current display!");

            if (!EGL.DestroyContext(dpy, ctx))
                throw new Exception("EGL.DestroyContext failed: " + EGL.GetError());

            if (!EGL.DestroySurface(dpy, surface))
                throw new Exception("EGL.DestroySurface failed: " + EGL.GetError());

            if (!EGL.Terminate(dpy))
                throw new Exception("EGL.Terminate failed: " + EGL.GetError());

            Debug.Log("===========COMPLETE==========");
        }
        catch (Exception e)
        {
            Debug.Log("===========FAILED==========");
            Debug.Log(e.ToString());
            Debug.Log("===========================");
        }
    }

    public override void Draw()
    {
    }
}
