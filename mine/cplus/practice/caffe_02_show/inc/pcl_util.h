#ifndef PROJECT_PATH_PCL_UTIL_H
#define PROJECT_PATH_PCL_UTIL_H

#include <Eigen/Core>
#include <Eigen/Eigenvalues>
#include <opencv2/opencv.hpp>
#include <pcl/common/common.h>
#include <pcl/common/transforms.h>
#include <pcl/sample_consensus/ransac.h>
#include <pcl/sample_consensus/sac_model_line.h>
#include <pcl/features/normal_3d.h>
#include <pcl/features/vfh.h>
#include <pcl/io/file_io.h>
#include <pcl/io/io.h>
#include <pcl/io/pcd_io.h>
#include <pcl/kdtree/kdtree_flann.h>
#include <pcl/point_cloud.h>
#include <pcl/point_types.h>
#include <pcl/visualization/pcl_visualizer.h>
#include <pcl/filters/voxel_grid.h>


// NOTE: exclude pcl/features/impl/normal_3d_omp.hpp
// Any other file should do like this if they need include "normal_3d_omp.h"
// because in our UT, 'private' is redefined to 'public' which is confilict to OpenMP
#undef PCL_NO_PRECOMPILE
#include <pcl/features/normal_3d_omp.h>
#define PCL_NO_PRECOMPILE

#include "pcl_types.h"

//FIXME: just compatible to multibooster/pcd_util lib.
//       when remove multibooster, remove the function.
void get_pointcloud_centroid(PointCloudConstPtr cloud, Eigen::VectorXf& centroid);
void get_pointcloud_centroid(PointCloudConstPtr cloud, Eigen::VectorXd& centroid);
void get_pointcloud_centroid(PointCloudConstPtr cloud, Eigen::Vector3f& centroid);
void get_pointcloud_centroid(PointCloudConstPtr cloud, Eigen::Vector3d& centroid);

template<typename T>
void _get_pointcloud_centroid(PointCloudConstPtr cloud, T& centroid) {
    for (size_t i = 0; i < cloud->points.size(); ++i) {
        centroid.coeffRef(0) += cloud->points[i].x;
        centroid.coeffRef(1) += cloud->points[i].y;
        centroid.coeffRef(2) += cloud->points[i].z;
    }
    centroid /= (double) cloud->points.size();
}

void get_pointcloud_bbox_2d(PointCloudConstPtr pc, Eigen::MatrixXf& bb);

void get_pointcloud_bbox_3d(PointCloudConstPtr pc, Eigen::MatrixXf &bb);

bool get_pointcloud_aligned_bbox(
        PointCloudConstPtr pc, BoundingCube& box, int min_num_points = 5);

void get_pointcloud_aligned_bbox(
        const PointCloud &pc,
        Eigen::Vector4f &centroid,
        Eigen::MatrixXf &bb,
        double& yaw);

bool get_pointcloud_minarea_bbox(const PointCloud& pc, BoundingCube* box,
        const int& min_num_points = 5, const bool& verbose = false);

bool pointcloud_to_eigen(const PointCloud& cloud,
                         Eigen::MatrixXf* points,
                         Eigen::VectorXf* intensities);

bool cloud_plane_projector(const PointCloud& pc, cv::Mat1b& img, const std::string& view);

void cloud_demean(PointCloud& pc);

void cloud_demean(const PointCloud& pc, PointCloud& pc_demean);

void cloud_demean(const Eigen::VectorXf& centroid, PointCloud& pc);

bool find_dominant_direction_xy(const PointCloud& pc, Eigen::VectorXf& coeff);

bool convert_to_cvmat(
        const PointCloud& pc,
        cv::Mat1b& img_resize,
        const std::string& view,
        int scale = 1);

bool crop_image(const cv::Mat1b& src, cv::Mat1b& img);

double orient_cloud(const PointCloud& pc, PointCloud& pc_out, bool demean = false);

double orient_cloud(
        const PointCloud& pc, PointCloud& pc_out, BoundingCube *bbox, bool demean = false);

double normalize_cloud_matrix(const Eigen::MatrixXf& cloud, Eigen::MatrixXf& out_cloud);

void crop_point_cloud(
        PointCloudConstPtr pc,
        const Eigen::Vector4f& maxPoint,
        const Eigen::Vector4f& minPoint,
        const Eigen::Vector3f& boxTranslation,
        const Eigen::Vector3f& boxRotation,
        PointCloud::Ptr pccrop,
        PointIndicesPtr pi = NULL);

void extract_vfh(PointCloudConstPtr cloud, Eigen::VectorXf* vfh);

//FIXME: remove extract_VFH defination when update multibooster-lib
void extract_VFH(PointCloudConstPtr cloud, Eigen::VectorXf* vfh);

// @brief: merge point indices
// @param[in]: total points num
// @param[in]: point indices vector
// @param[in]: operator and/or
// @param[out]: merged point indices
void merge_point_indices(
        unsigned pointcloud_size,
        const std::vector<PointIndices>& indices_vec,
        bool is_and,
        std::vector<PointIndices>* out_vec);

// @brief: filter point cloud with some roi indices
// @param[in]: roi indices
// @param[in]: and / or
// @param[out]: pointcloud filtered by roi
void filter_pointcloud(
        const std::vector<PointIndices>& roi_indices_vec,
        bool is_and,
        PointCloudPtr* pc_ptrptr);

#endif  // PROJECT_PATH_PCL_UTIL_H
