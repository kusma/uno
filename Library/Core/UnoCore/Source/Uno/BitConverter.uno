using Uno.Compiler.ExportTargetInterop;

namespace Uno
{
    [extern(DOTNET) DotNetType("System.BitConverter")]
    public static class BitConverter
    {
        public static long DoubleToInt64Bits(double value)
        {
            if defined(CPLUSPLUS)
            @{
                union
                {
                    double d;
                    uint64_t i;
                } u;
                u.d = value;
                return u.i;
            @}
            else
                build_error;
        }

        public static double Int64BitsToDouble(long value)
        {
            if defined(CPLUSPLUS)
            @{
                union
                {
                    double d;
                    uint64_t i;
                } u;
                u.i = value;
                return u.d;
            @}
            else
                build_error;
        }
    }
}
