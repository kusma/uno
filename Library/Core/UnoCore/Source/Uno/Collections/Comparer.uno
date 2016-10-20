using Uno.Compiler.ExportTargetInterop;

namespace Uno.Collections
{
    [extern(DOTNET) DotNetType("System.Collections.Generic.Comparer`1")]
    public abstract class Comparer<T> : IComparer<T>
    {
        
    }
}
