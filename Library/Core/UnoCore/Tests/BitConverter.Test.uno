using Uno;
using Uno.Testing;

namespace Uno.Test
{
    public class BitConverterTest
    {
        [Test]
        public void DoubleToInt64Bits()
        {
            Assert.AreEqual(0x0000000000000000, BitConverter.DoubleToInt64Bits( 0.0));
            Assert.AreEqual(0x3FF0000000000000, BitConverter.DoubleToInt64Bits( 1.0));
            Assert.AreEqual(0x8000000000000000, (ulong)BitConverter.DoubleToInt64Bits(-0.0));
            Assert.AreEqual(0xBFF0000000000000, (ulong)BitConverter.DoubleToInt64Bits(-1.0));
        }

        [Test]
        public void Int64BitsToDouble()
        {
            Assert.AreEqual( 0.0, BitConverter.Int64BitsToDouble(0x0000000000000000));
            Assert.AreEqual( 1.0, BitConverter.Int64BitsToDouble(0x3FF0000000000000));
            Assert.AreEqual(-0.0, BitConverter.Int64BitsToDouble((long)0x8000000000000000));
            Assert.AreEqual(-1.0, BitConverter.Int64BitsToDouble((long)0xBFF0000000000000));
        }
    }
}
