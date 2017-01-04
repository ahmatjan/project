#ifndef ADU_PERCEPTION_LIB_PCL_UTIL_SENSOR_POINT_TYPES_H
#define ADU_PERCEPTION_LIB_PCL_UTIL_SENSOR_POINT_TYPES_H

#include <pcl/point_cloud.h>
#include <pcl/point_types.h>

struct PointXYZIRT {
    float x;
    float y;
    float z;
    unsigned char intensity;
    unsigned char ring;
    double timestamp;

    EIGEN_MAKE_ALIGNED_OPERATOR_NEW  // make sure our new allocators are aligned
} EIGEN_ALIGN16;  // enforce SSE padding for correct memory alignment

struct PointXYZIT {
    float x;
    float y;
    float z;
    unsigned char intensity;
    double timestamp;

    EIGEN_MAKE_ALIGNED_OPERATOR_NEW  // make sure our new allocators are aligned
} EIGEN_ALIGN16;  // enforce SSE padding for correct memory alignment

struct RawPointXYZIT {
    PCL_ADD_POINT4D
    uint8_t intensity;
    double timestamp;
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW  // make sure our new allocators are aligned
} EIGEN_ALIGN16;  // enforce SSE padding for correct memory alignment

struct PointXYZIRTd {
    double x;
    double y;
    double z;
    unsigned char intensity;
    unsigned char ring;
    double timestamp;

    EIGEN_MAKE_ALIGNED_OPERATOR_NEW  // make sure our new allocators are aligned
} EIGEN_ALIGN16;  // enforce SSE padding for correct memory alignment

struct PointXYZITd {
    double x;
    double y;
    double z;
    unsigned char intensity;
    double timestamp;

    EIGEN_MAKE_ALIGNED_OPERATOR_NEW  // make sure our new allocators are aligned
} EIGEN_ALIGN16;  // enforce SSE padding for correct memory alignment

POINT_CLOUD_REGISTER_POINT_STRUCT (
        PointXYZIT,
        (float, x, x)
        (float, y, y)
        (float, z, z)
        (uint8_t, intensity, intensity)
        (double, timestamp, timestamp)
)
POINT_CLOUD_REGISTER_POINT_STRUCT(
        RawPointXYZIT,
        (float, x, x)
        (float, y, y)
        (float, z, z)
        (uint8_t, intensity, intensity)
        (double, timestamp, timestamp)
)

POINT_CLOUD_REGISTER_POINT_STRUCT (
        PointXYZIRT,
        (float, x, x)
        (float, y, y)
        (float, z, z)
        (uint8_t, intensity, intensity)
        (uint8_t, ring, ring)
        (double, timestamp, timestamp)
)

POINT_CLOUD_REGISTER_POINT_STRUCT (
        PointXYZITd,
        (double, x, x)
        (double, y, y)
        (double, z, z)
        (uint8_t, intensity, intensity)
        (double, timestamp, timestamp)
)

POINT_CLOUD_REGISTER_POINT_STRUCT (
        PointXYZIRTd,
        (double, x, x)
        (double, y, y)
        (double, z, z)
        (uint8_t, intensity, intensity)
        (uint8_t, ring, ring)
        (double, timestamp, timestamp)
)

#endif  // ADU_PERCEPTION_LIB_PCL_UTIL_SENSOR_POINT_TYPES_H
