#ifndef POSIX_HELPERS_H
#define POSIX_HELPERS_H

#include <time.h>
#include <sys/time.h>

static inline struct timespec uPthreadTimeoutToTimespec(int timeoutMillis)
{
    struct timeval now;
    gettimeofday(&now, NULL);
    uint64_t nanoseconds = (now.tv_sec * 1000000000ull) + (now.tv_usec * 1000);
    uint64_t timeoutNanoseconds = (timeoutMillis * 1000000ull) + nanoseconds;

    struct timespec timeout;
    timeout.tv_sec = (time_t)(timeoutNanoseconds / 1000000000ull);
    timeout.tv_nsec = (long)(timeoutNanoseconds % 1000000000ull);
    return timeout;
}

#endif
