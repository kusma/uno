using Uno;
using Uno.Compiler.ExportTargetInterop;

namespace Uno.Text.RegularExpressions
{
    [extern(DOTNET) DotNetType("System.Text.RegularExpressions.Regex")]
    [Require("Header.Include", "regex")]
    public class Regex
    {
        [TargetSpecificType]
        [Set("TypeName", "std::regex *")]
        [Require("Source.Include", "regex")]
        extern(CPLUSPLUS) internal struct RegexHandle
        {
            public static RegexHandle Create(string pattern)
            @{
                const char *tmp = uAllocCStr(pattern);

                std::regex *ret;
                try
                {
                    ret = new std::regex(tmp, std::regex::extended);
                }
                catch (std::regex_error e)
                {
                    uFreeCStr(tmp);
                    U_THROW(@{Uno.ArgumentException(string):New(uString::Utf8(e.what()))});
                }

                uFreeCStr(tmp);
                return ret;
            @}

            public static bool IsMatch(RegexHandle handle, string input)
            @{
                const char *tmp = uAllocCStr(input);
                bool ret = regex_search(tmp, *handle);
                uFreeCStr(tmp);
                return ret;
            @}
        }

        extern(CPLUSPLUS) RegexHandle _handle;

        public Regex(string pattern)
        {
            if (pattern == null)
                throw new ArgumentNullException("pattern");

            if defined(CPLUSPLUS)
                _handle = RegexHandle.Create(pattern);
            else
                build_error;
        }

        public bool IsMatch(string input)
        {
            if defined(CPLUSPLUS)
                return RegexHandle.IsMatch(_handle, input);
            else
                build_error;
        }
    }
}
