#ifndef ADU_PERCEPTION_LIB_PCL_UTIL_PCL_TYPES_H
#define ADU_PERCEPTION_LIB_PCL_UTIL_PCL_TYPES_H

#include <pcl/kdtree/kdtree_flann.h>
#include <pcl/search/impl/kdtree.hpp>
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>
#include <pcl/common/time.h>

typedef pcl::PointIndices PointIndices;
typedef pcl::PointIndices::Ptr PointIndicesPtr;
typedef pcl::PointXY Point2d;
typedef pcl::PointCloud<Point2d> PointCloud2d;
typedef pcl::PointCloud<Point2d>::Ptr PointCloud2dPtr;
typedef pcl::PointCloud<Point2d>::ConstPtr PointCloud2dConstPtr;

struct PointXYZIH;

typedef pcl::PointXYZI Point;
//typedef PointXYZIH Point;
typedef pcl::PointCloud<Point> PointCloud;
typedef pcl::PointCloud<Point>::Ptr PointCloudPtr;
typedef pcl::PointCloud<Point>::ConstPtr PointCloudConstPtr;
typedef pcl::PointXYZRGB CPoint;
typedef pcl::PointCloud<CPoint> CPointCloud;
typedef pcl::PointCloud<CPoint>::Ptr CPointCloudPtr;
typedef pcl::PointCloud<CPoint>::ConstPtr CPointCloudConstPtr;
typedef pcl::KdTreeFLANN<Point> KdTree;

struct BoundingCube {
    float x;        // center of box
    float y;        // center of box
    float z;        // center of box
    float length;
    float width;
    float height;
    float yaw;

    float trans_x;  // center of points
    float trans_y;  // center of points
    float trans_z;  // center of points
};

// using double type to define x, y, z.
struct PointD {
    double x;
    double y;
    double z;
    uint8_t intensity;
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW
} EIGEN_ALIGN16;

typedef ::pcl::PointCloud<PointD> PointDCloud;
typedef ::pcl::PointCloud<PointD>::Ptr PointDCloudPtr;
typedef ::pcl::PointCloud<PointD>::ConstPtr PointDCloudConstPtr;

POINT_CLOUD_REGISTER_POINT_STRUCT(
    PointD,
    (double, x, x)
    (double, y, y)
    (double, z, z)
    (uint8_t, intensity, intensity)
)

struct PointXYZIH {
    PCL_ADD_POINT4D;
    float intensity;
    float h;  // height from ground

    PointXYZIH () {
        x = 0.0f;
        y = 0.0f;
        z = 0.0f;
        h = 0.0f;
        intensity = 0.0f;
        data[3] = 1.0f;
    }

    inline PointXYZIH(float _intensity) {
        x = 0.0f;
        y = 0.0f;
        z = 0.0f;
        data[3] = 1.0f;
        intensity = _intensity;
    }
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW
} EIGEN_ALIGN16;

POINT_CLOUD_REGISTER_POINT_STRUCT(
    PointXYZIH,
    (float, x, x)
    (float, y, y)
    (float, z, z)
    (float, intensity, intensity)
    (float, h, h)
)

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

#endif  // ADU_PERCEPTION_LIB_PCL_UTIL_PCL_TYPES_H
