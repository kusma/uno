using Uno.Compiler.ExportTargetInterop;

namespace Uno.Net.Sockets
{
    [DotNetType("System.Net.Sockets.TcpClient")]
    public class TcpClient
    {
        private Socket _client;
        private NetworkStream _networkStream;

        public Socket Client
        {
            get { return _client; }
            set { _client = value; }
        }

        public NetworkStream GetStream()
        {
            if (_networkStream == null)
                _networkStream = new NetworkStream(_client, true);

            return _networkStream;
        }
    }
}
