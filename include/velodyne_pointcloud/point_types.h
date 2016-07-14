/************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 *
 ************************************************************************/
/**
 * @file point_types.h
 * @author fengkaiwen01
 * @date 2016/03/8
 *
 **/

#ifndef VELODYNE_POINTCLOUD_POINT_TYPES_H
#define VELODYNE_POINTCLOUD_POINT_TYPES_H
#include <pcl/point_types.h>

namespace velodyne_pointcloud {

struct PointXYZIT {
    PCL_ADD_POINT4D
    uint8_t intensity;
    double timestamp;
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW // make sure our new allocators are aligned
} EIGEN_ALIGN16;
// enforce SSE padding for correct memory alignment

struct PointXYZITd {
    double x;
    double y;
    double z;
    uint8_t intensity;
    double timestamp;
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW // make sure our new allocators are aligned
} EIGEN_ALIGN16;
// enforce SSE padding for correct memory alignment

struct PointXYZd {
    double x;
    double y;
    double z;
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW // make sure our new allocators are aligned
} EIGEN_ALIGN16;

struct PointXYZRGBd {
    double x;
    double y;
    double z;
    PCL_ADD_RGB
    EIGEN_MAKE_ALIGNED_OPERATOR_NEW  // make sure our new allocators are aligned
} EIGEN_ALIGN16;

} // namespace velodyne_pointcloud

POINT_CLOUD_REGISTER_POINT_STRUCT(velodyne_pointcloud::PointXYZIT,
                                  (float, x, x)(float, y, y)(float, z, z)
                                  (uint8_t, intensity, intensity)(double, timestamp, timestamp))

POINT_CLOUD_REGISTER_POINT_STRUCT(velodyne_pointcloud::PointXYZITd,
                                  (double, x, x)(double, y, y)(double, z, z)(uint8_t, intensity, intensity)(double, timestamp,
                                          timestamp))

POINT_CLOUD_REGISTER_POINT_STRUCT(velodyne_pointcloud::PointXYZd,
                                  (double, x, x)(double, y, y)(double, z, z))
POINT_CLOUD_REGISTER_POINT_STRUCT(velodyne_pointcloud::PointXYZRGBd,
                                  (double, x, x)(double, y, y)(double, z, z)(float, rgb, rgb))
#endif  // VELODYNE_POINTCLOUD_POINT_TYPES_H
