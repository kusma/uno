using Uno.Compiler.ExportTargetInterop;

namespace Uno.Runtime.Implementation
{
    [extern(DOTNET) DotNetType]
    static class GenericComparerImpl
    {
        public static int Compare<T>(T left, T right)
        {
            if defined(CPLUSPLUS)
            @{
                uType* type = @{T:TypeOf};
                // uType* MakeGeneric(size_t count, uType** args);
                return U_IS_OBJECT(type)
                        ? (uObject*)$0 == (uObject*)$1 || (
                                (uObject*)$0 &&
                                (uObject*)$1 &&
                                ((uObject*)$0)->Equals((uObject*)$1)
                            )
                        : memcmp($0, $1, type->ValueSize);
            @}
            else if defined(CSHARP)
            @{
                return global::System.Collections.Generic.Comparer<T>.Default.Equals($@);
            @}
            else if defined(JAVASCRIPT)
            @{
                return $EqOp($@);
            @}
            else
                build_error;
        }
    }
}
