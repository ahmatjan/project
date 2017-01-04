#ifndef ADU_PERCEPTION_LIB_PCL_UTIL_PCD_FILE_UTIL_H
#define ADU_PERCEPTION_LIB_PCL_UTIL_PCD_FILE_UTIL_H

#include <vector>

#include <Eigen/Core>
#include <yaml-cpp/yaml.h>

//#include "lib/pcl_util/du_pcl.h"
#include "sensor_point_types.h"
//#include "pcl_types.h"
#include "pcl_util.h"

// @brief: Load pcds
// @param [in]: path to pcd file
// @param [in]: pose for the pcd
// @param [in]: whether pointcloud transformed to global
// @param [out]: pointcloud
bool load_pcl_pcds(
        const std::string& file_path,
        const Eigen::Affine3d& pose,
        bool is_global,
        PointCloudPtr* pc);

// @brief: Load the PCD poses.
// @param [in]: path to pose file
// @param [in]: extrinsic param, not used now
// @param [in]: whether to start from origin
// @param [out]: poses extracted from file
// @param [out]: timestamps extracted from file
bool load_pcd_poses(
        const std::string& file_path,
        const Eigen::Affine3d& extrinsic,
        bool start_from_origin,
        std::vector<Eigen::Affine3d>* poses,
        std::vector<double>* timestamps);

// @brief: Load the velodyne extrinsic from a YAML file.
// @param [in]: path to yaml file
// @param [out]: extrinsic transform
bool load_extrinsic(const std::string& file_path, Eigen::Affine3d* extrinsic);

#endif  // ADU_PERCEPTION_LIB_PCL_UTIL_PCD_FILE_UTIL_H
