using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using Stuff.Core;
using Stuff.Format;
using Uno.Build.JavaScript;
using Uno.Build.Packages;
using Uno.Compiler;
using Uno.Compiler.API;
using Uno.Compiler.API.Backends;
using Uno.Compiler.API.Domain.Extensions;
using Uno.Compiler.Frontend;
using Uno.Configuration;
using Uno.Diagnostics;
using Uno.IO;
using Uno.Logging;
using Uno.ProjectFormat;
using Uno.UX.Markup.CodeGeneration;

namespace Uno.Build
{
    using Compiler.Core;

    class BuildDriver : LogObject, IDisposable
    {
        readonly BuildTarget _target;
        readonly BuildOptions _options;
        readonly CompilerOptions _compilerOptions;
        readonly Compiler _compiler;
        readonly BuildEnvironment _env;
        readonly Backend _backend;
        readonly SourceReader _input;
        readonly Project _project;
        readonly UnoConfig _config;
        readonly BuildFile _file;
        readonly PackageCache _cache;
        IDisposable _anim;

        public bool IsUpToDate => !_options.Force && _file.Exists &&
                                  !_input.HasAnythingChangedSince(_file.Timestamp) &&
                                  _file.Load() == GetHashCode();
        public bool CanBuildNative => _options.Native && _target.CanBuild(_file) && (
                                      _options.Force ||
                                      !_file.IsProductUpToDate);

        public void StopAnim()
        {
            if (_anim != null)
                _anim.Dispose();
            _anim = null;
        }

        public BuildDriver(Log log, BuildTarget target, BuildOptions options, Project project, UnoConfig config)
            : base(log)
        {
            _target = target;
            _options = options;
            _project = project;
            _config = config;
            Log.MaxErrorCount = options.MaxErrorCount;
            Log.WarningLevel = options.WarningLevel;

            Log.Reset();
            if (target.IsObsolete)
                Log.Warning("The build target " + target.Quote() + " is obsolete and might not work any more.");

            _anim = Log.StartAnimation("Configuring");
            PrintRow("Project file", project.FullPath);

            _compilerOptions = new CompilerOptions {
                BuildTarget = _target.Identifier,
                Configuration = _options.Configuration.ToString(),
                OutputDirectory = !string.IsNullOrEmpty(_options.OutputDirectory)
                    ? Path.GetFullPath(_options.OutputDirectory)
                    : project.OutputDirectory,
                MainClass = _options.MainClass,
                Debug = _options.Configuration != BuildConfiguration.Release,
                Parallel = _options.Parallel,
                Strip = _options.Strip ?? _target.DefaultStrip,
                CanCacheIL = _options.PackageCache != null,
                OptimizeLevel = _options.OptimizeLevel
            };

            if (_options.Test)
            {
                _options.Defines.Add("UNO_TEST");
                _compilerOptions.TestOptions = new TestOptions {
                    TestServerUrl = _options.TestServerUrl,
                    Filter = _options.TestFilter,
                    CategoryFilter = _options.CategoryFilter
                };
            }

            _cache = _options.PackageCache ?? new PackageCache(Log, _config);
            PrintRow("Search paths", _cache.SearchPaths);

            _compiler = new Compiler(
                Log,
                _target.CreateBackend(config),
                GetPackage(),
                _compilerOptions);
            _env = _compiler.Environment;
            _backend = _compiler.Backend;
            _input = _compiler.Input;

            if (_options.Clean)
                _compiler.Disk.DeleteDirectory(_env.OutputDirectory);

            _file = new BuildFile(_env.OutputDirectory);
        }

        SourcePackage GetPackage()
        {
            using (Log.StartProfiler(_cache))
                return _cache.GetPackage(_project);
        }

        public void Dispose()
        {
            // Dispose PackageCache if it was created by us
            if (_options.PackageCache == null)
                _cache.Dispose();
        }

        public BackendResult Build()
        {
            if (Log.HasErrors)
                return null;

            PrintRow("Packages", _input.Packages);
            PrintRow("Output dir", _env.OutputDirectory);

            _file.Delete();
            _env.Define(_target.Identifier, "TARGET_" + _target.Identifier,
                _backend.Name, _backend.ShaderBackend.Name, _backend.ShaderBackend.Name, 
                _backend.BuildType.ToString());

            if (!string.IsNullOrEmpty(_target.FormerName))
                _env.Define(_target.FormerName);
            if (_options.Defines.Contains("HEADLESS"))
                _env.Define("HEADLESS");
            if (_options.OptimizeLevel == 0)
                _options.Defines.Add("O0"); // disables native optimizations
            if (_compilerOptions.Debug)
                _env.Define("DEBUG");
            if (_options.Configuration != BuildConfiguration.Debug)
                _env.Define(_options.Configuration.ToString().ToUpperInvariant());
            if (_options.Configuration == BuildConfiguration.Preview)
                _env.Define("REFLECTION", "SIMULATOR", "STACKTRACE", "DesignMode");
            if (Log.EnableExperimental)
                _options.Defines.Add("EXPERIMENTAL");
            foreach (var def in StuffFile.DefaultDefines)
                _env.Define("HOST_" + def);
            foreach (var def in _options.Defines)
                _env.Define(def);

            _target.Initialize(_env);

            foreach (var def in _options.Undefines)
                _env.Undefine(def);

            foreach (var p in _project.GetProperties(Log))
                _env.Set("Project." + p.Key, p.Value);
            foreach (var p in _config.Flatten())
                _env.Set("Config." + p.Key, GetConfigValue(p.Key, p.Value));
            foreach (var e in _options.Settings)
                _env.Set(e.Key, GetCommandLineValue(e.Value), Disambiguation.Override);

            var unoExe = _config.GetFullPath("UnoExe", false);
            if (unoExe != null)
                Log.Warning(".unoconfig: 'UnoExe' is deprecated -- replace with 'Assemblies.Uno'");
            else
                unoExe = _config.GetFullPath("Assemblies.Uno");

            _env.Set("Uno", PlatformDetection.IsWindows
                ? unoExe.QuoteSpace()
                : GetMonoPath().QuoteSpace() + " " + unoExe.QuoteSpace());

            foreach (var dll in _config.GetFullPathArray("Assemblies.Plugins"))
                _compiler.Plugins.Load(dll);

            if (Log.HasErrors)
                return null;

            // Install NPM packages if package.json exists
            foreach (var p in _input.Packages)
                if (p.IsProject && NPM.NeedsInstall(p))
                    new NPM(Log).Install(p);

            using (Log.StartProfiler(typeof(UXProcessor)))
                UXProcessor.Build(_compiler.Disk, _input.Packages);

            if (Log.HasErrors)
                return null;

            try
            {
                _compiler.Load();
            }
            finally
            {
                StopAnim();
            }

            if (Log.HasErrors)
                return null;

            var defines = _compiler.Data.Extensions.Defines;
            var stuff = GetDirtyStuff(_env, defines, _input.Packages);

            if (stuff.Count > 0)
            {
                using (Log.StartAnimation("Installing dependencies"))
                {
                    Stuff.Log.Configure(Log.IsVeryVerbose, Log.OutWriter, Log.ErrorWriter);

                    foreach (var f in stuff)
                        if (!Installer.Install(f, 0, defines))
                            Log.Error(new Source(f), null, "Failed to install dependencies");
                }
            }

            if (Log.HasErrors)
                return null;

            using (Log.StartAnimation("Compiling syntax tree"))
                _compiler.Compile();

            if (Log.HasErrors)
                return null;

            _anim = Log.StartAnimation("Generating code and data");

            try
            {
                return _compiler.Generate(_target.Configure);
            }
            finally
            {
                // Add flag to avoid repeating warnings when this package is reused in following builds (uno doctor).
                _compiler.Input.Package.Flags |= SourcePackageFlags.Verified;

                _file.Product = _env.GetString("Product");
                _file.BuildCommand = _env.GetString("Commands.Build");
                _file.RunCommand = _env.GetString("Commands.Run");

                if (!Log.HasErrors)
                {
                    _file.Save(GetHashCode());
                    _target.DeleteOutdated(_compiler.Disk, _env);
                }

                StopAnim();
            }
        }

        public void BuildNative()
        {
            using (Log.StartAnimation("Building " + _target + (
                    _backend.BuildType == BuildType.Executable
                        ? " app"
                        : " lib")))
            {
                if (!_target.Build(_compiler.Shell, _file, _options.NativeArguments))
                    Log.Error(Source.Unknown, ErrorCode.E0200, _target + " build failed");
                else
                    _file.TouchProduct();
            }
        }

        public void PrintInternals()
        {
            var properties = _compiler.Data.Extensions.Properties.ToArray();
            Array.Sort(properties, (a, b) => string.Compare(a.Key, b.Key, StringComparison.InvariantCulture));

            var defines = _compiler.Data.Extensions.Defines.ToArray();
            Array.Sort(defines);

            Log.H1("Build internals");

            foreach (var p in properties)
                Log.WriteLine(p.Key.PadRight(40) + " " + Clamp(_env.GetString(p.Key)));

            Log.H2("Defines");
            Log.WriteLine(string.Join(" ", defines));
        }

        void PrintRow(string description, IEnumerable<object> paths)
        {
            if (!Log.IsVerbose)
                return;

            PrintRow(description, string.Join(", ", paths.Select(x => x.ToString().ToRelativePath())));
        }

        void PrintRow(string description, string path)
        {
            if (!Log.IsVerbose)
                return;

            Log.WriteLine(description + ":" + new string(' ', 13 - description.Length) + path.ToRelativePath());
        }

        public override int GetHashCode()
        {
            var hash = 13 * _options.GetHashCode() + _target.Identifier.GetHashCode();

            foreach (var upk in _compiler.Input.Packages)
                if (upk.IsCached && upk.Version != null)
                    hash = hash * 13 + upk.Version.GetHashCode();

            return hash;
        }

        public BuildResult GetResult(BackendResult result)
            => new BuildResult(Log, _project, _target, _compiler, _options, _file, result);

        List<string> GetDirtyStuff(
            IEnvironment env,
            IEnumerable<string> defines,
            IEnumerable<SourcePackage> packages)
        {
            var stuff = new List<string>();
            foreach (var p in packages)
                foreach (var f in p.StuffFiles)
                    if (env.Test(p.Source, f.Condition) &&
                            !Installer.IsUpToDate(Path.Combine(p.SourceDirectory, f.UnixPath), 0, defines))
                        stuff.Add(Path.Combine(p.SourceDirectory, f.UnixPath));
            return stuff;
        }

        SourceValue GetConfigValue(string key, StuffItem value)
            => new SourceValue(new Source(value.File.Filename, value.LineNumber), _config.GetString(key));

        SourceValue GetCommandLineValue(string s)
            => new SourceValue(new Source(Path.Combine(Directory.GetCurrentDirectory(), "uno")), s);

        string Clamp(string value)
            => ClampSingleLine(
                value != null && value.Contains('\n') && !Log.IsVeryVerbose
                    ? "(multi-line) " + value.Substring(0, value.IndexOf('\n')).TrimEnd()
                    : value);

        string ClampSingleLine(string value, int maxLength = 64)
            => value != null && value.Length > maxLength && !Log.IsVerbose
                ? value.Substring(0, maxLength - 3) + "..."
                : value;

        string GetMonoPath()
        {
            var mono = _config.GetFullPath("Mono", false);
            if (!string.IsNullOrEmpty(mono))
                return mono;

            try
            {
                if (PlatformDetection.IsMac)
                {
                    var sb = new StringBuilder(4096);
                    var len = (uint) sb.Capacity;
                    var retval = _NSGetExecutablePath(sb, ref len);
                    if (retval != 0)
                        throw new InvalidOperationException("returned " + retval + ", len " + len);
                    var str = sb.ToString();
                    return str.QuoteSpace();
                }
            }
            catch (Exception e)
            {
                Log.Warning("GetMonoPath() failed: " + e.Message);
                Log.Trace(e);
            }

            return "mono";
        }

        [DllImport("/usr/lib/libSystem.dylib")]
        static extern int _NSGetExecutablePath(StringBuilder buf, ref uint bufsize);
    }
}
