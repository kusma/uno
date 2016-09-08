using Uno;
using Uno.Compiler.ExportTargetInterop;
using Uno.Diagnostics;
using Uno.Runtime.InteropServices;
using HTML5;

namespace OpenGL
{
    [extern(DOTNET) DotNetType]
    [extern(CPLUSPLUS) Require("Source.Include", "Uno/Support.h")]
    [extern(CPLUSPLUS) Require("Source.Include", "XliPlatform/GL.h")]
    extern(OPENGL) public static class GL
    {
        // Setting and getting state [5.14.3]

        public static int GetInteger(GLIntegerName name)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            int result;
            if defined(CPLUSPLUS)
            @{
                glGetIntegerv($@, (GLint*)&result);
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetInteger(name);
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.getParameter($@) | 0;
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static int4 GetInteger(GLInteger4Name name)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            int4 result;
            if defined(CPLUSPLUS)
            @{
                glGetIntegerv($@, (GLint*)&result);
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetInteger(name);
            }
            else if defined(JAVASCRIPT)
            @{
                var p = gl.getParameter($@);
                result = @{int4(int,int,int,int):New(p[0] | 0, p[1] | 0, p[2] | 0, p[3] | 0)};
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        // Special Functions [5.14.3]

        public static void Disable(GLEnableCap cap)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDisable($@);
            @}
            else if defined(DOTNET)
            {
                _gl.Disable(cap);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.disable($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void Enable(GLEnableCap cap)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glEnable($@);
            @}
            else if defined(DOTNET)
            {
                _gl.Enable(cap);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.enable($@);
            @}
            else
                build_error;
        }

        public static void Finish()
        {
            if defined(CPLUSPLUS)
            @{
                glFinish();
            @}
            else if defined(DOTNET)
            {
                _gl.Finish();
            }
            else if defined(JAVASCRIPT)
            @{
                gl.finish();
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }


        public static void Flush()
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glFlush();
            @}
            else if defined(DOTNET)
            {
                _gl.Flush();
            }
            else if defined(JAVASCRIPT)
            @{
                gl.flush();
            @}
            else
                build_error;
        }

        public static GLError GetError()
        {
            GLError result;
            if defined(CPLUSPLUS)
            @{
                result = glGetError();
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetError();
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.getError();
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static string GetString(GLStringName name)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            string result;
            if defined(CPLUSPLUS)
            @{
                const char* str = (const char*)glGetString($@);
                if (!str) str = "";
                result = uString::Utf8(str);
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetString(name);
            }
            else if defined(JAVASCRIPT)
            @{
                result = "" + gl.getParameter($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        // GetParameter
        // Hint
        // IsEnabled
        public static void PixelStore(GLPixelStoreParameter pname, int param)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glPixelStorei($@);
            @}
            else if defined(DOTNET)
            {
                _gl.PixelStore(pname, param);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.pixelStorei($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }


        // Whole framebuffer operations [5.14.3]

        public static void Clear(GLClearBufferMask mask)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glClear($@);
            @}
            else if defined(DOTNET)
            {
                _gl.Clear(mask);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.clear($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void ClearColor(float red, float green, float blue, float alpha)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glClearColor($@);
            @}
            else if defined(DOTNET)
            {
                _gl.ClearColor(red, green, blue, alpha);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.clearColor($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void ClearDepth(float depth)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
#ifdef U_GL_DESKTOP
                glClearDepth((double)$0);
#else
                glClearDepthf($0);
#endif
            @}
            else if defined(DOTNET)
            {
                _gl.ClearDepth(depth);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.clearDepth($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        //public static void ClearStencil(int s);
        public static void ColorMask(bool red, bool green, bool blue, bool alpha)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glColorMask($@);
            @}
            else if defined(DOTNET)
            {
                _gl.ColorMask(red, green, blue, alpha);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.colorMask($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void DepthMask(bool flag)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDepthMask($@);
            @}
            else if defined(DOTNET)
            {
                _gl.DepthMask(flag);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.depthMask($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        //public static void StencilMask(uint mask);
        //public static void StencilMaskSeparate(enum face, uint mask);


        // Per-Fragment Operations [5.14.3]

        //public static void BlendColor(float red, float green, float blue, float alpha);

        public static void BlendEquation(GLBlendEquation mode)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBlendEquation($@);
            @}
            else if defined(DOTNET)
            {
                _gl.BlendEquation(mode);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.blendEquation($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void BlendEquationSeparate(GLBlendEquation modeRgb, GLBlendEquation modeAlpha)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBlendEquationSeparate($@);
            @}
            else if defined(DOTNET)
            {
                _gl.BlendEquationSeparate(modeRgb, modeAlpha);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.blendEquationSeparate($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void BlendFunc(GLBlendingFactor src, GLBlendingFactor dst)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBlendFunc($@);
            @}
            else if defined(DOTNET)
            {
                _gl.BlendFunc(src, dst);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.blendFunc($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void BlendFuncSeparate(GLBlendingFactor srcRGB, GLBlendingFactor dstRGB, GLBlendingFactor srcAlpha, GLBlendingFactor dstAlpha)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBlendFuncSeparate($@);
            @}
            else if defined(DOTNET)
            {
                _gl.BlendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.blendFuncSeparate($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void DepthFunc(GLDepthFunction func)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDepthFunc($@);
            @}
            else if defined(DOTNET)
            {
                _gl.DepthFunc(func);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.depthFunc($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        //public static void SampleCoverage(float value, bool invert);
        //public static void StencilFunc(enum func, int ref, uint mask);
        //public static void StencilFuncSeparate(enum face, enum func, int ref, uint mask);
        //public static void StencilOp(enum fail, enum zfail, enum zpass);
        //public static void StencilOpSeparate(enum face, enum fail, enum zfail, enum zpass);


        // Rasterization [5.14.3]

        public static void CullFace(GLCullFaceMode mode)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glCullFace($@);
            @}
            else if defined(DOTNET)
            {
                _gl.CullFace(mode);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.cullFace($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void FrontFace(GLFrontFaceDirection mode)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glFrontFace($@);
            @}
            else if defined(DOTNET)
            {
                _gl.FrontFace(mode);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.frontFace($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void LineWidth(float width)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glLineWidth($@);
            @}
            else if defined(DOTNET)
            {
                _gl.LineWidth(width);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.lineWidth($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void PolygonOffset(float factor, float units)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glPolygonOffset($@);
            @}
            else if defined(DOTNET)
            {
                _gl.PolygonOffset(factor, units);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.polygonOffset($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }


        // View and Clip [5.14.3 - 5.14.4]

        public static void DepthRange(float zNear, float zFar)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
#ifdef U_GL_DESKTOP
                glDepthRange($@);
#else
                glDepthRangef($@);
#endif
            @}
            else if defined(DOTNET)
            {
                _gl.DepthRange(zNear, zFar);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.depthRange($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void Scissor(int x, int y, int width, int height)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glScissor($@);
            @}
            else if defined(DOTNET)
            {
                _gl.Scissor(x, y, width, height);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.scissor($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void Viewport(int x, int y, int width, int height)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glViewport($@);
            @}
            else if defined(DOTNET)
            {
                _gl.Viewport(x, y, width, height);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.viewport($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }


        // Buffer Objects [5.14.5]

        public static void BindBuffer(GLBufferTarget target, GLBufferHandle buffer)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBindBuffer($@);
            @}
            else if defined(DOTNET)
            {
                _gl.BindBuffer(target, buffer);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.bindBuffer($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("BufferDatai")]
        public static void BufferData(GLBufferTarget target, int sizeInBytes, GLBufferUsage usage)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBufferData($0, $1, NULL, $2);
            @}
            else if defined(DOTNET)
            {
                _gl.BufferData(target, sizeInBytes, IntPtr.Zero, usage);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.bufferData($@);
            @}
            else
                build_error;
        }

        [DotNetOverride]
        public static void BufferData(GLBufferTarget target, byte[] data, GLBufferUsage usage)
        {
            if defined(CPLUSPLUS)
            @{
                glBufferData($0, $1->Length(), $1->Ptr(), $2);
            @}
            else if defined(DOTNET)
            {
                GCHandle pin = GCHandle.Alloc(data, GCHandleType.Pinned);
                _gl.BufferData(target, data.Length, pin.AddrOfPinnedObject(), usage);
                pin.Free();
            }
            else if defined(JAVASCRIPT)
            @{
                gl.bufferData($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [DotNetOverride, Obsolete("Use the byte[] overload instead")]
        public static void BufferData(GLBufferTarget target, Buffer data, GLBufferUsage usage)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBufferData($0, U_BUFFER_SIZE($1), U_BUFFER_PTR($1), $2);
            @}
            else if defined(DOTNET)
            {
                GCHandle pin;
                _gl.BufferData(target, data.SizeInBytes, data.PinPtr(out pin), usage);
                pin.Free();
            }
            else if defined(JAVASCRIPT)
            @{
                gl.bufferData($0, @{Uint8Array.Create(Uno.Buffer):Call($1)}, $2);
            @}
            else
                build_error;
        }

        [DotNetOverride]
        public static void BufferSubData(GLBufferTarget target, int offset, byte[] data)
        {
            if defined(CPLUSPLUS)
            @{
                glBufferSubData($0, $1, $2->Length(), $2->Ptr());
            @}
            else if defined(DOTNET)
            {
                GCHandle pin = GCHandle.Alloc(data, GCHandleType.Pinned);
                _gl.BufferSubData(target, offset, data.Length, pin.AddrOfPinnedObject());
                pin.Free();
            }
            else if defined(JAVASCRIPT)
            @{
                gl.bufferSubData($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [DotNetOverride, Obsolete("Use the byte[] overload instead")]
        public static void BufferSubData(GLBufferTarget target, int offset, Buffer data)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBufferSubData($0, $1, U_BUFFER_SIZE($2), U_BUFFER_PTR($2));
            @}
            else if defined(DOTNET)
            {
                GCHandle pin;
                _gl.BufferSubData(target, offset, data.SizeInBytes, data.PinPtr(out pin));
                pin.Free();
            }
            else if defined(JAVASCRIPT)
            @{
                gl.bufferSubData($0, $1, @{Uint8Array.Create(Uno.Buffer):Call($2)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static GLBufferHandle CreateBuffer()
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            GLBufferHandle result;
            if defined(CPLUSPLUS)
            @{
                glGenBuffers(1, &result);
            @}
            else if defined(DOTNET)
            {
                result =  _gl.CreateBuffer();
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.createBuffer();
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static void DeleteBuffer(GLBufferHandle buffer)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDeleteBuffers(1, &$0);
            @}
            else if defined(DOTNET)
            {
                _gl.DeleteBuffer(buffer);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.deleteBuffer($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        //public static object GetBufferParameter(enum target, enum pname);
        //public static bool IsBuffer(GLBufferHandle buffer);


        // Framebuffer Objects [5.14.6]

        public static void BindFramebuffer(GLFramebufferTarget target, GLFramebufferHandle fb)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBindFramebuffer($@);
            @}
            else if defined(DOTNET)
            {
                _gl.BindFramebuffer(target, fb);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.bindFramebuffer($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static GLFramebufferStatus CheckFramebufferStatus(GLFramebufferTarget target)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            GLFramebufferStatus result;
            if defined(CPLUSPLUS)
            @{
                result = glCheckFramebufferStatus($@);
            @}
            else if defined(DOTNET)
            {
                result = _gl.CheckFramebufferStatus(target);
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.checkFramebufferStatus($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static GLFramebufferHandle CreateFramebuffer()
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            GLFramebufferHandle result;
            if defined(CPLUSPLUS)
            @{
                glGenFramebuffers(1, &result);
            @}
            else if defined(DOTNET)
            {
                result = _gl.CreateFramebuffer();
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.createFramebuffer();
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static void DeleteFramebuffer(GLFramebufferHandle fb)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDeleteFramebuffers(1, &$0);
            @}
            else if defined(DOTNET)
            {
                _gl.DeleteFramebuffer(fb);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.deleteFramebuffer($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void FramebufferTexture2D(GLFramebufferTarget target, GLFramebufferAttachment attachment, GLTextureTarget textarget, GLTextureHandle texture, int level)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glFramebufferTexture2D($@);
            @}
            else if defined(DOTNET)
            {
                _gl.FramebufferTexture2D(target, attachment, textarget, texture, level);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.framebufferTexture2D($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void FramebufferRenderbuffer(GLFramebufferTarget target, GLFramebufferAttachment attachment, GLRenderbufferTarget renderbuffertarget, GLRenderbufferHandle renderbuffer)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glFramebufferRenderbuffer($@);
            @}
            else if defined(DOTNET)
            {
                _gl.FramebufferRenderbuffer(target, attachment, renderbuffertarget, renderbuffer);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.framebufferRenderbuffer($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        // IsFramebuffer
        // GetFramebufferAttachmentParameter

        public static GLFramebufferHandle GetFramebufferBinding()
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            GLFramebufferHandle result;
            if defined(CPLUSPLUS)
            @{
                glGetIntegerv(GL_FRAMEBUFFER_BINDING, (GLint*)&result);
            @}
            else if defined(DOTNET)
            {
                result = return _gl.GetFramebufferBinding();
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.getParameter(gl.FRAMEBUFFER_BINDING);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }


        // Renderbuffer Objects [5.14.7]

        public static void BindRenderbuffer(GLRenderbufferTarget target, GLRenderbufferHandle renderbuffer)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBindRenderbuffer($@);
            @}
            else if defined(DOTNET)
            {
                _gl.BindRenderbuffer(target, renderbuffer);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.bindRenderbuffer($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static GLRenderbufferHandle CreateRenderbuffer()
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            GLRenderbufferHandle result;
            if defined(CPLUSPLUS)
            @{
                glGenRenderbuffers(1, &result);
            @}
            else if defined(DOTNET)
            {
                result =  _gl.CreateRenderbuffer();
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.createRenderbuffer();
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static void DeleteRenderbuffer(GLRenderbufferHandle renderbuffer)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDeleteRenderbuffers(1, &$0);
            @}
            else if defined(DOTNET)
            {
                _gl.DeleteRenderbuffer(renderbuffer);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.deleteRenderbuffer($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        // GetRenderbufferParameter
        // IsRenderbuffer

        public static void RenderbufferStorage(GLRenderbufferTarget target, GLRenderbufferStorage internalFormat, int width, int height)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glRenderbufferStorage($@);
            @}
            else if defined(DOTNET)
            {
                _gl.RenderbufferStorage(target, internalFormat, width, height);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.renderbufferStorage($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static GLRenderbufferHandle GetRenderbufferBinding()
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            GLRenderbufferHandle result;
            if defined(CPLUSPLUS)
            @{
                glGetIntegerv(GL_RENDERBUFFER_BINDING, (GLint*)&result);
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetRenderbufferBinding();
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.getParameter(gl.RENDERBUFFER_BINDING);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }


        // Texture Objects [5.14.8]

        public static void ActiveTexture(GLTextureUnit texture)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glActiveTexture($@);
            @}
            else if defined(DOTNET)
            {
                _gl.ActiveTexture(texture);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.activeTexture($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void BindTexture(GLTextureTarget target, GLTextureHandle texture)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBindTexture($@);
            @}
            else if defined(DOTNET)
            @{
                _gl.BindTexture($@);
            @}
            else if defined(JAVASCRIPT)
            @{
                gl.bindTexture($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        // CopyTexImage2D
        // CopyTexSubImage2D

        public static GLTextureHandle CreateTexture()
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            GLTextureHandle result;
            if defined(CPLUSPLUS)
            @{
                glGenTextures(1, &result);
            @}
            else if defined(DOTNET)
            {
                result = _gl.CreateTexture();
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.createTexture();
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static void DeleteTexture(GLTextureHandle texture)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDeleteTextures(1, &$0);
            @}
            else if defined(DOTNET)
            {
                _gl.DeleteTexture(texture);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.deleteTexture($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void GenerateMipmap(GLTextureTarget target)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glGenerateMipmap($@);
            @}
            else if defined(DOTNET)
            {
                _gl.GenerateMipmap(target);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.generateMipmap($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        // GetTexParameter
        // IsTexture

        [DotNetOverride]
        public static void TexImage2D(GLTextureTarget target, int level, GLPixelFormat internalFormat, int width, int height, int border, GLPixelFormat format, GLPixelType type, byte[] data)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glTexImage2D($0, $1, $2, $3, $4, $5, $6, $7, $8 ? $8->Ptr() : NULL);
            @}
            else if defined(DOTNET)
            {
                if (data != null)
                {
                    GCHandle pin = GCHandle.Alloc(data, GCHandleType.Pinned);
                    try
                    {
                        _gl.TexImage2D(target, level,
                            internalFormat, width, height, border,
                            format, type,
                            pin.AddrOfPinnedObject());
                    }
                    finally
                    {
                        pin.Free();
                    }
                }
                else
                {
                    _gl.TexImage2D(target, level,
                        internalFormat, width, height, border,
                        format, type, IntPtr.Zero);
                }
            }
            else if defined(JAVASCRIPT)
            @{
                gl.texImage2D($@);
            @}
            else
                build_error;
        }

        [DotNetOverride, Obsolete("Use the byte[] overload instead")]
        public static void TexImage2D(GLTextureTarget target, int level, GLPixelFormat internalFormat, int width, int height, int border, GLPixelFormat format, GLPixelType type, Buffer data)
        {
            if defined(CPLUSPLUS)
            @{
                glTexImage2D($0, $1, $2, $3, $4, $5, $6, $7, $8 ? U_BUFFER_PTR($8) : NULL);
            @}
            else if defined(DOTNET)
            {
                if (data != null)
                {
                    GCHandle pin;
                    _gl.TexImage2D(target, level,
                        internalFormat, width, height, border,
                        format, type,
                        data.PinPtr(out pin));
                    pin.Free();
                }
                else
                {
                    _gl.TexImage2D(target, level,
                        internalFormat, width, height, border,
                        format, type, IntPtr.Zero);
                }
            }
            else if defined(JAVASCRIPT)
            @{
                gl.texImage2D($0,$1,$2,$3,$4,$5,$6,$7,@{Uint8Array.Create(Uno.Buffer):Call($8)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void TexImage2D(GLTextureTarget target, int level, GLPixelFormat internalFormat, int width, int height, int border, GLPixelFormat format, GLPixelType type, IntPtr data)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glTexImage2D($@);
            @}
            else if defined(DOTNET)
            {
                _gl.TexImage2D(target, level, internalFormat, width, height, border, format, type, data);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.texImage2D($@);
            @}
            else
                build_error;
        }

        public static void TexSubImage2D(GLTextureTarget target, int level, int xoffset, int yoffset, int width, int height, GLPixelFormat format, GLPixelType type, byte[] data)
        {
            if defined(CPLUSPLUS)
            @{
                glTexSubImage2D($0, $1, $2, $3, $4, $5, $6, $7, $8 ? $8->Ptr() : NULL);
            @}
            else if defined(DOTNET)
            {
                if(data != null)
                {
                    GCHandle pin = GCHandle.Alloc(data, GCHandleType.Pinned);
                    try
                    {
                        _gl.TexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, pin.AddrOfPinnedObject());
                    }
                    finally
                    {
                        pin.Free();
                    }
                }
                else
                {
                    // The data pointer for glTexSubImage2D can be zero in case of 'GL_PIXEL_UNPACK_BUFFER'
                    _gl.TexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, IntPtr.Zero);
                }
            }
            else if defined(JAVASCRIPT)
            @{
                gl.texSubImage2D($@);
            @}
            else
                build_error;
        }

        public static void TexSubImage2D(GLTextureTarget target, int level, int xoffset, int yoffset, int width, int height, GLPixelFormat format, GLPixelType type, IntPtr data)
        {
            if defined(CPLUSPLUS)
            @{
                glTexSubImage2D($@);
            @}
            else if defined(DOTNET)
            {
                _gl.TexSubImage2D(target, level, xoffset, yoffset, width, height, format, type, data);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.texSubImage2D($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("TexParameteri")]
        public static void TexParameter(GLTextureTarget target, GLTextureParameterName pname, GLTextureParameterValue param)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glTexParameteri($@);
            @}
            else if defined(DOTNET)
            {
                _gl.TexParameter(target, pname, param);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.texParameteri($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        // TexSubImage2D


        // Programs and Shaders [5.14.9]

        public static void AttachShader(GLProgramHandle program, GLShaderHandle shader)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glAttachShader($@);
            @}
            else if defined(DOTNET)
            {
                _gl.AttachShader(program, shader);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.attachShader($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void BindAttribLocation(GLProgramHandle handle, int index, string name)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glBindAttribLocation($0, $1, uCString($2).Ptr);
            @}
            else if defined(DOTNET)
            {
                _gl.BindAttribLocation(handle, index, name);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.getAttribLocation($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void CompileShader(GLShaderHandle shader)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glCompileShader($@);
            @}
            else if defined(DOTNET)
            {
                _gl.CompileShader(shader);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.compileShader($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static GLProgramHandle CreateProgram()
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            GLProgramHandle result;
            if defined(CPLUSPLUS)
            @{
                result = glCreateProgram($@);
            @}
            else if defined(DOTNET)
            {
                result = _gl.CreateProgram();
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.createProgram($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static GLShaderHandle CreateShader(GLShaderType type)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            GLShaderHandle result;
            if defined(CPLUSPLUS)
            @{
                result = glCreateShader($@);
            @}
            else if defined(DOTNET)
            {
                result = _gl.CreateShader(type);
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.createShader($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static void DeleteProgram(GLProgramHandle program)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDeleteProgram($@);
            @}
            else if defined(DOTNET)
            {
                _gl.DeleteProgram(program);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.deleteProgram($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void DeleteShader(GLShaderHandle shader)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDeleteShader($@);
            @}
            else if defined(DOTNET)
            {
                _gl.DeleteShader(shader);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.deleteShader($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void DetachShader(GLProgramHandle program, GLShaderHandle shader)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDetachShader($@);
            @}
            else if defined(DOTNET)
            {
                _gl.DetachShader(program, shader);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.detachShader($@);;
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        //public static GLShaderHandle[] GetAttachedShaders(GLProgramHandle program);

        public static int GetProgramParameter(GLProgramHandle program, GLProgramParameter pname)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            int result;
            if defined(CPLUSPLUS)
            @{
                glGetProgramiv($@, &result);
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetProgramParameter(program, pname);
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.getProgramParameter($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static string GetProgramInfoLog(GLProgramHandle program)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            string result;
            if defined(CPLUSPLUS)
            @{
                int len = 0;
                const int bufSize = 4096;
                char buf[bufSize];
                glGetProgramInfoLog($0, bufSize, &len, buf);
                result = uString::Utf8(buf, len);
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetProgramInfoLog(program);
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.getProgramInfoLog($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        public static int GetShaderParameter(GLShaderHandle shader, GLShaderParameter pname)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            int result;
            if defined(CPLUSPLUS)
            @{
                glGetShaderiv($@, &result);
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetShaderParameter(shader, pname);
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.getShaderParameter($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;

        }

        public static string GetShaderInfoLog(GLShaderHandle shader)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            string result;
            if defined(CPLUSPLUS)
            @{
                int len = 0;
                const int bufSize = 4096;
                char buf[bufSize];
                glGetShaderInfoLog($0, bufSize, &len, buf);
                result = uString::Utf8(buf, len);
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetShaderInfoLog(shader);
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.getShaderInfoLog($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        //public static string GetShaderSource(GLShaderHandle shader);
        //public static bool IsProgram(GLProgramHandle program);
        //public static bool IsShader(GLShaderHandle shader);

        public static void LinkProgram(GLProgramHandle program)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glLinkProgram($@);
            @}
            else if defined(DOTNET)
            {
                _gl.LinkProgram(program);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.linkProgram($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void ShaderSource(GLShaderHandle shader, string source)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                uCString cstr($1);

                const char* code[] =
                {
#ifdef U_GL_DESKTOP
                    "#version 120\n",
#else
                    "",
#endif
                    cstr.Ptr
                };

                GLint len[] =
                {
                    (GLint)strlen(code[0]),
                    (GLint)cstr.Length
                };

                glShaderSource($0, 2, code, len);
            @}
            else if defined(DOTNET)
            {
                _gl.ShaderSource(shader, source);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.shaderSource($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void UseProgram(GLProgramHandle program)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUseProgram($@);
            @}
            else if defined(DOTNET)
            {
                _gl.UseProgram(program);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.useProgram($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        //public static void ValidateProgram(GLProgramHandle program);

        public static bool HasGetShaderPrecisionFormat
        {
            get
            {
                if defined(CPLUSPLUS)
                @{
#ifdef U_GL_DESKTOP
                    return false;
#else
                    return true;
#endif
                @}
                else if defined(DOTNET)
                {
                    return _gl.HasGetShaderPrecisionFormat;
                }
                else if defined(JAVASCRIPT)
                @{
                    return true;
                @}
                else
                    build_error;
            }
        }

        public static GLShaderPrecisionFormat GetShaderPrecisionFormat(GLShaderType shaderType, GLShaderPrecision precision)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            GLShaderPrecisionFormat result;
            if defined(CPLUSPLUS)
            @{
#ifdef U_GL_DESKTOP
                memset(&result, 0, sizeof(@{GLShaderPrecisionFormat}));
#else
                glGetShaderPrecisionFormat($@, &result.RangeMin, &result.Precision);
#endif
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetShaderPrecisionFormat(shaderType, precision);
            }
            else if defined(JAVASCRIPT)
            @{
                var tmp = gl.getShaderPrecisionFormat($@);
                result = @{GLShaderPrecisionFormat(int, int, int):New(tmp.rangeMin, tmp.rangeMax, tmp.precision)};
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        // Uniforms and Attributes [5.14.10]

        public static void DisableVertexAttribArray(int index)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDisableVertexAttribArray($@);
            @}
            else if defined(DOTNET)
            {
                _gl.DisableVertexAttribArray(index);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.disableVertexAttribArray($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void EnableVertexAttribArray(int index)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glEnableVertexAttribArray($@);
            @}
            else if defined(DOTNET)
            {
                _gl.EnableVertexAttribArray(index);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.enableVertexAttribArray($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        //public static object GetActiveAttrib(GLProgramHandle program, string name);
        //public static object GetActiveUniform(GLProgramHandle program, string name);

        public static int GetAttribLocation(GLProgramHandle program, string name)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            int result;
            if defined(CPLUSPLUS)
            @{
                result = glGetAttribLocation($0, uCString($1).Ptr);
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetAttribLocation(program, name);
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.getAttribLocation($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        //public static any GetUniform(GLProgramHandle program, int location);

        public static int GetUniformLocation(GLProgramHandle program, string name)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            int result;
            if defined(CPLUSPLUS)
            @{
                result = glGetUniformLocation($0, uCString($1).Ptr);
            @}
            else if defined(DOTNET)
            {
                result = _gl.GetUniformLocation(program, name);
            }
            else if defined(JAVASCRIPT)
            @{
                result = gl.getUniformLocation($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();

            return result;
        }

        //public static any GetVertexAttrib(uint index, enum pname);
        //public static int GetVertexAttribOffset(uint index, enum pname);
        [ExportName("Uniform1i")]
        public static void Uniform1(int location, int value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform1i($@);
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform1(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform1i($0, $1);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform2i")]
        public static void Uniform2(int location, int2 value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform2iv($0, 1, (const GLint*)&$1);
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform2(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform1i($0, @{$1.X}, @{$1.Y});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform3i")]
        public static void Uniform3(int location, int3 value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform3iv($0, 1, (const GLint*)&$1);
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform3(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform3i($0, @{$1.X}, @{$1.Y}, @{$1.Z});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform4i")]
        public static void Uniform4(int location, int4 value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform4iv($0, 1, (const GLint*)&$1);
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform4(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform4i($0, @{$1.X}, @{$1.Y}, @{$1.Z}, @{$1.W});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform1f")]
        public static void Uniform1(int location, float value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform1f($@);
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform1(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform1f($0, $1);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform2f")]
        public static void Uniform2(int location, float2 value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform2fv($0, 1, (const GLfloat*)&$1);
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform2(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform2f($0, @{$1.X}, @{$1.Y});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform3f")]
        public static void Uniform3(int location, float3 value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform3fv($0, 1, (const GLfloat*)&$1);
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform3(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform3f($0, @{$1.X}, @{$1.Y}, @{$1.Z});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform4f")]
        public static void Uniform4(int location, float4 value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform4fv($0, 1, (const GLfloat*)&$1);
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform4(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform4f($0, @{$1.X}, @{$1.Y}, @{$1.Z}, @{$1.W});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("UniformMatrix2f")]
        public static void UniformMatrix2(int location, bool transpose, float2x2 value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniformMatrix2fv($0, 1, $1, (const GLfloat*)&$2);
            @}
            else if defined(DOTNET)
            {
                _gl.UniformMatrix2(location, transpose, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniformMatrix2fv($0, $1, @{Float32Array.Create(float2x2):Call($2)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("UniformMatrix3f")]
        public static void UniformMatrix3(int location, bool transpose, float3x3 value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniformMatrix3fv($0, 1, $1, (const GLfloat*)&$2);
            @}
            else if defined(DOTNET)
            {
                _gl.UniformMatrix3(location, transpose, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniformMatrix3fv($0, $1, @{Float32Array.Create(float3x3):Call($2)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("UniformMatrix4f")]
        public static void UniformMatrix4(int location, bool transpose, float4x4 value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniformMatrix4fv($0, 1, $1, (const GLfloat*)&$2);
            @}
            else if defined(DOTNET)
            {
                _gl.UniformMatrix4(location, transpose, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniformMatrix4fv($0, $1, @{Float32Array.Create(float4x4):Call($2)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform1iv")]
        public static void Uniform1(int location, int[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform1iv($0, $1->Length(), (const GLint*)$1->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform1(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform1iv($0, @{Int32Array.Create(int[]):Call($1)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform2iv")]
        public static void Uniform2(int location, int2[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform2iv($0, $1->Length(), (const GLint*)$1->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform2(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform2iv($0, @{Int32Array.Create(int2[]):Call($1)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform3iv")]
        public static void Uniform3(int location, int3[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform3iv($0, $1->Length(), (const GLint*)$1->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform3(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform3iv($0, @{Int32Array.Create(int3[]):Call($1)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform4iv")]
        public static void Uniform4(int location, int4[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform4iv($0, $1->Length(), (const GLint*)$1->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform4(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform4iv($0, @{Int32Array.Create(int4[]):Call($1)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform1fv")]
        public static void Uniform1(int location, float[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform1fv($0, $1->Length(), (const GLfloat*)$1->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform1(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform1fv($0, @{Float32Array.Create(float[]):Call($1)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform2fv")]
        public static void Uniform2(int location, float2[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform2fv($0, $1->Length(), (const GLfloat*)$1->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform2(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform2fv($0, @{Float32Array.Create(float2[]):Call($1)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform3fv")]
        public static void Uniform3(int location, float3[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform3fv($0, $1->Length(), (const GLfloat*)$1->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform3(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform3fv($0, @{Float32Array.Create(float3[]):Call($1)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("Uniform4fv")]
        public static void Uniform4(int location, float4[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniform4fv($0, $1->Length(), (const GLfloat*)$1->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.Uniform4(location, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniform4fv($0, @{Float32Array.Create(float4[]):Call($1)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("UniformMatrix2fv")]
        public static void UniformMatrix2(int location, bool transpose, float2x2[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniformMatrix2fv($0, $2->Length(), $1, (const GLfloat*)$2->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.UniformMatrix2(location, transpose, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniformMatrix2fv($0, $1, @{Float32Array.Create(float2x2[]):Call($2)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("UniformMatrix3fv")]
        public static void UniformMatrix3(int location, bool transpose, float3x3[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniformMatrix3fv($0, $2->Length(), $1, (const GLfloat*)$2->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.UniformMatrix3(location, transpose, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniformMatrix3fv($0, $1, @{Float32Array.Create(float3x3[]):Call($2)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        [ExportName("UniformMatrix4fv")]
        public static void UniformMatrix4(int location, bool transpose, float4x4[] value)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glUniformMatrix4fv($0, $2->Length(), $1, (const GLfloat*)$2->Ptr());
            @}
            else if defined(DOTNET)
            {
                _gl.UniformMatrix4(location, transpose, value);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.uniformMatrix4fv($0, $1, @{Float32Array.Create(float4x4[]):Call($2)});
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        // (Lots of VertexAttrib overloads)

        public static void VertexAttribPointer(int index, int size, GLDataType type, bool normalized, int stride, int offset)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glVertexAttribPointer($0, $1, $2, $3, $4, (const GLvoid*)(size_t)$5);
            @}
            else if defined(DOTNET)
            {
                _gl.VertexAttribPointer(index, size, type, normalized, stride, offset);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.vertexAttribPointer($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        // Writing to the Draw Buffer [5.14.11]

        public static void DrawArrays(GLPrimitiveType mode, int first, int count)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDrawArrays($@);
            @}
            else if defined(DOTNET)
            {
                _gl.DrawArrays(mode, first, count);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.drawArrays($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        public static void DrawElements(GLPrimitiveType mode, int count, GLIndexType type, int offset)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glDrawElements($0, $1, $2, (const GLvoid*)(size_t)$3);
            @}
            else if defined(DOTNET)
            {
                _gl.DrawElements(mode, count, type, offset);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.drawElements($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        // Read Back Pixels [5.14.12]

        public static void ReadPixels(int x, int y, int width, int height, GLPixelFormat format, GLPixelType type, byte[] data)
        {
            if defined(OPENGL_VALIDATION)
                ValidateBefore();

            if defined(CPLUSPLUS)
            @{
                glReadPixels($0, $1, $2, $3, $4, $5, (uint8_t*)$6->_ptr);
            @}
            else if defined(DOTNET)
            {
                _gl.ReadPixels(x, y, width, height, format, type, data);
            }
            else if defined(JAVASCRIPT)
            @{
                gl.readPixels($@);
            @}
            else
                build_error;

            if defined(OPENGL_VALIDATION)
                ValidateAfter();
        }

        // Detect context lost events [5.14.13]

        //public static bool IsContextLost();

        // Detect and Enable Extensions [5.14.14]

        //public static string[] GetSupportedExtensions();
        //public static object GetExtension(string name);

        // .NET specific set up
        extern(DOTNET) static IGL _gl;

        extern(DOTNET)
        public static void Initialize(IGL gl, bool debug = false)
        {
            _gl = debug
                ? (IGL) new GLDebugLayer(gl)
                : gl;
            var glVersion = gl.GetString(GLStringName.Version);

            if (glVersion.StartsWith("OpenGL ES"))
                return; // If OpenGL ES just return, since we have a proper GL context.

            if (glVersion == null || glVersion.IndexOf('.') == -1 ||
                    int.Parse(glVersion.Substring(0, glVersion.IndexOf('.'))) < 2)
            {
                Debug.Log("GL_VERSION: " + glVersion);
                Debug.Log("GL_VENDOR: " + gl.GetString(GLStringName.Vendor));
                Debug.Log("GL_RENDERER: " + gl.GetString(GLStringName.Renderer));
                throw new NotSupportedException("OpenGL 2.0 is required to run this application");
            }
        }

        static void ValidateBefore()
        {
            // nothing for now
        }

        static void ValidateAfter()
        {
            // nothing for now
        }
    }
}
