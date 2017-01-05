#ifndef PROJECT_PATH_MACROS_H
#define PROJECT_PATH_MACROS_H

#include <iomanip>

#ifdef GLOG_TIMESTAMP
#undef GLOG_TIMESTAMP
#endif

#define GLOG_TIMESTAMP(timestamp)  \
        std::fixed << std::setprecision(6) << timestamp

#define GLOG_DOUBLE(value)  \
        std::fixed << std::setprecision(6) << value

#define GLOG_DOUBLE_WITH_PRECISION(value, precision)  \
        std::fixed << std::setprecision(precision) << value

// for unsed variable
#undef UNUSED
#define UNUSED(x) (void)(x)

#endif  // PROJECT_PATH_MACROS_H
