using Uno.Compiler.ExportTargetInterop;
using Uno.Time;

namespace Uno
{
    [DotNetType("System.DateTimeKind")]
    public enum DateTimeKind
    {
        // Unspecified = 0,
        Utc = 1,
        Local = 2
    }

    extern(CPLUSPLUS) static class TimeHelpers
    {
        [TargetSpecificType]
        [Set("Include", "time.h")]
        [Set("TypeName", "struct tm")]
        public struct TmHandle
        {
        }

        [Require("Source.Include", "sys/time.h")]
        public static bool UtcNow(out long result)
        @{
            struct timeval tv;
            if (gettimeofday(&tv, NULL) < 0)
                return false;

            *result = 621355968000000000ll +
                      tv.tv_sec * 10000000ll +
                      tv.tv_usec * 10;

            return true;
        @}

        public static bool LocalTime(long ticks, out TmHandle result)
        @{
            time_t time = (utcTicks - 621355968000000000ll) / 10000000;

            if (localtime_r(&time, result) == NULL)
                return false;

            return true;
        @}

        public static bool UtcTime(long utcTicks, out TmHandle result)
        @{
            time_t time = (utcTicks - 621355968000000000ll) / 10000000;

            if (gmtime_r(&time, result) == NULL)
                return false;

            return true;
        @}
    }

    [DotNetType("System.DateTime")]
    public struct DateTime
    {
        extern(!CPLUSPLUS || MSVC) static Instant DotNetTimeBase { get { return Instant.FromUtc(1, 1, 1, 0, 0); } }

        extern(!CPLUSPLUS || MSVC) static Duration DotNetTimeOffset
        {
            get {
                var UnixEpoch = Instant.FromUtc(1970, 1, 1, 0, 0);
                return UnixEpoch - DotNetTimeBase;
            }
        }

        readonly DateTimeKind _kind;

        extern(CPLUSPLUS && !MSVC) readonly long _ticks;
        extern(CPLUSPLUS && !MSVC) readonly TimeHelpers.TmHandle _tmHandle;
        extern(!CPLUSPLUS || MSVC) readonly ZonedDateTime _time;

        public DateTime(long ticks, DateTimeKind kind)
        {
            if (ticks < 0)
                throw new ArgumentOutOfRangeException(nameof(ticks));

            _kind = kind;

            if defined(CPLUSPLUS && !MSVC)
            {
                _ticks = ticks;
                if (!TimeHelpers.UtcTime(ticks, out _tmHandle))
                    throw new Exception("TimeHelpers.UtcTime() failed");
            }
            else
                _time = new ZonedDateTime(new Instant(ticks) - DotNetTimeOffset, DateTimeZone.Utc);
        }

        extern(!CPLUSPLUS || MSVC) DateTime(ZonedDateTime time)
        {
            _kind = DateTimeKind.Utc;
            _time = time.WithZone(DateTimeZone.Utc);
        }

        extern(DOTNET)
        internal DateTime(int year, int month, int day);

        // It's possible to be constructed by the default ctor, in which case _time will be null, so
        //  this should be used instead wherever possible in this impl
        extern(!CPLUSPLUS || MSVC) ZonedDateTime InternalTimeOrDefault()
        {
            return _time ?? new ZonedDateTime(DotNetTimeBase, DateTimeZone.Utc);
        }

        internal static DateTime Now
        {
            get
            {
                if defined(CPLUSPLUS && !MSVC)
                {
                    long utcTicks;
                    if (!TimeHelpers.UtcNow(out utcTicks))
                        throw new Exception("gettimeofday() failed");

                    return new DateTime(utcTicks, DateTimeKind.Local);
                }
                else
                    return new DateTime(ZonedDateTime.Now);
            }
        }

        public static DateTime UtcNow
        {
            get
            {
                if defined(CPLUSPLUS && !MSVC)
                {
                    long utcTicks;
                    if (!TimeHelpers.UtcNow(out utcTicks))
                        throw new Exception("gettimeofday() failed");

                    return new DateTime(utcTicks, DateTimeKind.Utc);
                }
                else
                    return new DateTime(ZonedDateTime.Now.WithZone(DateTimeZone.Utc));
            }
        }

        public DateTimeKind Kind { get { return _kind; } }

        public long Ticks
        {
            get
            {
                if defined(CPLUSPLUS && !MSVC)
                    return _ticks;
                else
                    return (InternalTimeOrDefault().Instant + DotNetTimeOffset).Ticks;
            }
        }

        internal int Year
        {
            get
            {
                if defined(CPLUSPLUS && !MSVC)
                    return 1900 + extern<int>(_tmHandle) "$0.tm_year";
                else
                    return InternalTimeOrDefault().Year;
            }
        }

        internal int Month
        {
            get
            {
                if defined(CPLUSPLUS && !MSVC)
                    return 1 + extern<int>(_tmHandle) "$0.tm_mon";
                else
                    return InternalTimeOrDefault().Month;
            }
        }

        internal int Day
        {
            get
            {
                if defined(CPLUSPLUS && !MSVC)
                    return extern<int>(_tmHandle) "$0.tm_mday";
                else
                    return InternalTimeOrDefault().Day;
            }
        }

        internal int Hour
        {
            get
            {
                if defined(CPLUSPLUS && !MSVC)
                    return extern<int>(_tmHandle) "$0.tm_hour";
                else
                    return InternalTimeOrDefault().Hour;
            }
        }

        internal int Minute
        {
            get
            {
                if defined(CPLUSPLUS && !MSVC)
                    return extern<int>(_tmHandle) "$0.tm_min";
                else
                    return InternalTimeOrDefault().Minute;
            }
        }

        internal int Second
        {
            get
            {
                if defined(CPLUSPLUS && !MSVC)
                    return extern<int>(_tmHandle) "$0.tm_sec";
                else
                    return InternalTimeOrDefault().Second;
            }
        }

        public override bool Equals(object obj)
        {
            return obj is DateTime && this == (DateTime)obj;
        }

        public override int GetHashCode()
        {
            var t = Ticks;
            return (int)(t >> 32) ^ (int)t;
        }

        public static bool operator ==(DateTime x, DateTime y)
        {
            return x.Ticks == y.Ticks;
        }

        public static bool operator !=(DateTime x, DateTime y)
        {
            return !(x == y);
        }

        public DateTime ToUniversalTime()
        {
            // Since we only suppport DateTimeKind.Utc currently, we'll just return a new object with the same value
            return new DateTime(Ticks, Kind);
        }

        public override string ToString()
        {
            switch (_kind)
            {
                case DateTimeKind.Utc:
                    return
                        Month.ToString().PadLeft(2, '0') + "/" + Day.ToString().PadLeft(2, '0') + "/" + Year.ToString().PadLeft(4, '0') +
                        " " +
                        Hour.ToString().PadLeft(2, '0') + ":" + Minute.ToString().PadLeft(2, '0') + ":" + Second.ToString().PadLeft(2, '0');

                default:
                    throw new NotImplementedException();
            }
        }
    }
}
