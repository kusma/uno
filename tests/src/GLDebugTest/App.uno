using Uno;
using OpenGL;

namespace GLDebugTest
{
    public class App : Application
    {
        void OnDebugMessage(GLDebugSource source, GLDebugType type, uint id, GLDebugSeverity severity, string message)
        {
            debug_log string.Format("OnDebugMessage: {0}, {1}, {2}, {3}, \"{4}\" ", source, type, id, severity, message);
        }

        public App()
        {
            var error = GL.GetError();
            debug_log "GL-error: " + error;
            var maxTextureSize = GL.GetInteger(GLIntegerName.MaxTextureSize);
            debug_log "MaxTextureSize: " + maxTextureSize;

            if (Array.IndexOf(GL.GetSupportedExtensions(), "GL_KHR_debug") >= 0)
            {
                debug_log "GL_KHR_debug supported!";
                GLDebug.DebugMessageCallback(OnDebugMessage);
                GLDebug.DebugMessageInsert(GLDebugSource.SourceApplication, GLDebugType.Other, 1337, GLDebugSeverity.Notification, "test!");
            }
        }

    }
}
