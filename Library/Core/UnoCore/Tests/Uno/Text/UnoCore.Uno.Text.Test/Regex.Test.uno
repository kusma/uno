using Uno;
using Uno.Text.RegularExpressions;
using Uno.Testing;

namespace Uno.Text.Test
{
    public class RegexTest
    {
        void CreateRegexNull()
        {
            var regex = new Regex(null);
            Assert.AreEqual(null, regex);
        }

        void CreateRegexInvalid()
        {
            var regex = new Regex("[a");
            Assert.AreEqual(null, regex);
        }

        [Test]
        public void Basic()
        {
            var regex = new Regex("[a-z]+");
            Assert.AreEqual(true, regex.IsMatch("foo"));
            Assert.AreEqual(true, regex.IsMatch(" foo"));
            Assert.AreEqual(false, regex.IsMatch("FOO"));

            Assert.Throws<ArgumentNullException>(CreateRegexNull);
            Assert.Throws<ArgumentException>(CreateRegexInvalid);
        }

        [Test]
        public void MatchStartAndEnd()
        {
            var regexStart = new Regex("^[a-z]+");
            Assert.AreEqual(true, regexStart.IsMatch("foo"));
            Assert.AreEqual(false, regexStart.IsMatch(" foo"));

            var regexEnd = new Regex("[a-z]+$");
            Assert.AreEqual(true, regexEnd.IsMatch("foo"));
            Assert.AreEqual(false, regexEnd.IsMatch("foo "));

            var regexStartAndEnd = new Regex("^[a-z]+$");
            Assert.AreEqual(true, regexStartAndEnd.IsMatch("foo"));
            Assert.AreEqual(false, regexStartAndEnd.IsMatch(" foo"));
            Assert.AreEqual(false, regexStartAndEnd.IsMatch("foo "));
            Assert.AreEqual(false, regexStartAndEnd.IsMatch(" foo "));
        }

        [Test]
        [Ignore("Inconsistency between std::regex and System.Text.RegularExpressions.Regex", "CPLUSPLUS")]
        public void BracketSlash()
        {
            var regex = new Regex("[\\d]+");
            Assert.AreEqual(true, regex.IsMatch("123"));
            Assert.AreEqual(false, regex.IsMatch("\\"));
            Assert.AreEqual(false, regex.IsMatch("d"));
        }

        [Test]
        public void EmptyMatch()
        {
            var regex = new Regex("[a-z]?");
            Assert.AreEqual(true, regex.IsMatch("foo"));
            Assert.AreEqual(true, regex.IsMatch("FOO"));
        }
    }
}
