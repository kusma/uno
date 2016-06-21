using Uno;
using Uno.Testing;
using Uno.Threading;

namespace Uno.Threading.Test
{
    public class ThreadLocalTest
    {
        [Test]
        public void Basics()
        {
            var threadLocal = new ThreadLocal<int>();
            Assert.AreEqual(0, threadLocal.Value);

            threadLocal.Value = 1337;
            Assert.AreEqual(1337, threadLocal.Value);
        }
    }
}
