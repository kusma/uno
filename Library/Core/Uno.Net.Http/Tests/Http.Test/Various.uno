using Uno;
using Uno.Testing;
using Uno.Net.Http;
using Uno.Collections;

namespace Http.Test
{
    public class Various
    {
        public void OnError(HttpMessageHandlerRequest msg, string reason)
        {
            throw new Exception("http request failed: " + reason);
        }

        public void OnLoaded(HttpMessageHandlerRequest resp)
        {
            debug_log "response: " + resp;
        }

        [Test]
        public void ManyRequests()
        {
            var handler = new HttpMessageHandler();
            var url = "http://google.com";

            for (int i = 0; i < 1000; ++i)
            {
                var request = handler.CreateRequest("GET", url);
                request.Error += OnError;
                request.Done += OnLoaded;
                request.SetResponseType(HttpResponseType.ByteArray);
                request.SendAsync();
            }
        }
    }
}
