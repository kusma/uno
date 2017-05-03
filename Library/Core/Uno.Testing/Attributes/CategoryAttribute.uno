namespace Uno.Testing
{
    [AttributeUsage(AttributeTargets.Method)]
    public sealed class CategoryAttribute : Attribute
    {
        public readonly string Name;
        public CategoryAttribute(string name)
        {
            Name = name;
        }
    }
}
