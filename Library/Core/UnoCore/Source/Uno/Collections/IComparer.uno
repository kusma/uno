using Uno.Compiler.ExportTargetInterop;

namespace Uno.Collections
{
    [extern(DOTNET) DotNetType("System.Collections.Generic.IComparer`1")]
    public interface IComparer<T>
    {
        int Compare(T x, T y);
    }
}
