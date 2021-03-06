﻿using Uno.Compiler.API.Backends;
using Uno.Compiler.Backends.CPlusPlus;
using Uno.Compiler.Extensions.Foreign;
using Uno.Compiler.Extensions.Foreign.Java;
using Uno.Compiler.Extensions.Foreign.ObjC;

namespace Uno.Compiler.Extensions
{
    public class CppExtension : BackendExtension
    {
        CppBackend _backend;

        protected override void Initialize()
        {
            _backend = (CppBackend) Backend;
        }

        protected override void Begin()
        {
            AddTransform(new ForeignFilePass(Data.Extensions, Input.Package, _backend));

            if (IsDefined("ANDROID"))
                AddTransform(new ForeignJavaPass(_backend));
            if (IsDefined("FOREIGN_OBJC_SUPPORTED"))
                AddTransform(new ForeignObjCPass(_backend));

            // CPLUSPLUS is always defined here
            AddTransform(new ForeignCPlusPlusPass(_backend));
        }
    }
}
