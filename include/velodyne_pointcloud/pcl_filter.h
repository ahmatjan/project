#ifndef VELODYNE_POINTCLOUD_PCL_FILTER_H
#define VELODYNE_POINTCLOUD_PCL_FILTER_H

#include <ros/ros.h>
#include <boost/lexical_cast.hpp>


// FIXME(libo24) Unknown bug with nodelet: Without PCL_NO_PRECOMPILE, when
// running FilterNodelet and other nodelets under a same nodelet manager,
// Eigen::JacobiSVD in other nodelet will fail.
#define PCL_NO_PRECOMPILE
#include <pcl/features/normal_3d.h>
// #include <pcl/filters/filter.h>
#include <pcl/filters/passthrough.h>
#include <pcl/filters/random_sample.h>
#include <pcl/filters/voxel_grid.h>
#include <pcl/filters/covariance_sampling.h>
#undef PCL_NO_PRECOMPILE

#include <pcl/point_cloud.h>
#include <pcl/point_types.h>
#include <pcl_conversions/pcl_conversions.h>
#include <pcl_ros/point_cloud.h>
#include <pcl/common/time.h>
#include <pcl/range_image/range_image_spherical.h>
#include <sensor_msgs/PointCloud2.h>
#include <msg_util/msg_util.h>

#include "const_variables.h"

//#define WRITE_MSG_TO_FILE

namespace velodyne_pointcloud {

typedef pcl::PointCloud<pcl::PointXYZ> XYZPointCloud;

class PclFilter {
public:
    PclFilter(ros::NodeHandle nh, ros::NodeHandle private_nh);
    virtual ~PclFilter() {};
    void covariance_sample(pcl::PointCloud<pcl::PointNormal>::Ptr& cloud, uint samples);

    static void remove_nan(XYZPointCloud::Ptr& cloud)
    {
        // pcl::ScopeTime time("remove nan");
        assert(!cloud->is_dense);
        std::vector<int> indices;
        XYZPointCloud::Ptr concatenate_cloud(new XYZPointCloud);
        pcl::removeNaNFromPointCloud(*cloud, *concatenate_cloud, indices);
        cloud = concatenate_cloud;
    }

    template<typename PointT>
    static void voxel_grid_sample(
        typename pcl::PointCloud<PointT>::Ptr& cloud, float resolution = 1.5)
    {
#ifdef WRITE_MSG_TO_FILE
        //    write msgs to files for unit test
        std::string input_file_path =
            "/home/zhaijing01/msg_files/voxelGrid_msg_" +
            boost::lexical_cast<std::string>(cloud->header.seq) + ".msg";
        msg_util::write_msg_to_file<typename pcl::PointCloud<PointT>::ConstPtr>(
            cloud, input_file_path);
#endif
        typename pcl::PointCloud<PointT>::Ptr filtered_cloud(new pcl::PointCloud<PointT>);
        pcl::VoxelGrid<PointT> filter;
        filter.setInputCloud(cloud);
        filter.setLeafSize(resolution, resolution, resolution);
        filter.filter(*filtered_cloud);
        cloud = filtered_cloud;
#ifdef WRITE_MSG_TO_FILE
        //    write msgs to files for unit test
        std::string output_file_path =
            "/home/zhaijing01/msg_files/voxelGrid_output_msg_" +
            boost::lexical_cast<std::string>(cloud->header.seq) + ".msg";
        msg_util::write_msg_to_file<typename pcl::PointCloud<PointT>::ConstPtr>(
            cloud, output_file_path);
#endif
    }

    static void compute_normal(const XYZPointCloud::ConstPtr& cloud, 
                              pcl::PointCloud<pcl::PointNormal>::Ptr& normaled)
    {
#ifdef WRITE_MSG_TO_FILE
        //    write msgs to files for unit test
        std::string input_file_path =
            "/home/zhaijing01/msg_files/computeNormal_msg_" +
            boost::lexical_cast<std::string>(cloud->header.seq) + ".msg";
        msg_util::write_msg_to_file<pcl::PointCloud<pcl::PointXYZ>::ConstPtr>(
            cloud, input_file_path);
#endif
        pcl::copyPointCloud(*cloud, *normaled);
        pcl::NormalEstimation<pcl::PointNormal, pcl::PointNormal> normal_estimator;

        normal_estimator.setInputCloud(normaled);

        pcl::search::KdTree<pcl::PointNormal>::Ptr tree(
            new pcl::search::KdTree<pcl::PointNormal>());
        normal_estimator.setSearchMethod(tree);
        normal_estimator.setKSearch(10);
        normal_estimator.compute(*normaled);

#ifdef WRITE_MSG_TO_FILE
        //    write msgs to files for unit test
        std::string output_file_path = "/home/zhaijing01/msg_files/computeNormal_output_msg_" +
            boost::lexical_cast<std::string>(normaled->header.seq) + ".msg";
        msg_util::write_msg_to_file<pcl::PointCloud<pcl::PointNormal>::ConstPtr>(
            normaled, output_file_path);
#endif
    }

    static void field_filter(pcl::PointCloud<pcl::PointXYZ>::Ptr &cloud, const std::string &field,
            const float &limit_min, const float &limit_max) {
#ifdef WRITE_MSG_TO_FILE
    //    write msgs to files for unit test
        std::string input_file_path = "/home/zhaijing01/msg_files/filterZ_msg_" +
            boost::lexical_cast<std::string>(cloud->header.seq) + ".msg";
        msg_util::write_msg_to_file<XYZPointCloud::ConstPtr>(
            cloud, input_file_path);
#endif
        XYZPointCloud::Ptr filtered_cloud(new XYZPointCloud);
        pcl::PassThrough<pcl::PointXYZ> filter;
        filter.setInputCloud(cloud);
        filter.setFilterLimitsNegative(false);
        filter.setFilterFieldName(field);
        filter.setFilterLimits(limit_min, limit_max);
        filter.filter(*filtered_cloud);
        cloud = filtered_cloud;
    }

    static void range_image_sample(pcl::PointCloud<pcl::PointXYZ>::Ptr& cloud) {
        pcl::StopWatch timer;
        timer.reset();
        // Set openmp thread number
        pcl::RangeImage::max_no_of_threads = 8;
        // We now want to create a range image from the above point cloud, with a 1deg angular resolution
        float angularResolution_x = pcl::deg2rad(0.4137931);
        float angularResolution_y = pcl::deg2rad(0.41875);
        float maxAngleWidth = pcl::deg2rad(360.0); // 360.0 degree in radians
        float maxAngleHeight = pcl::deg2rad(180.0); // 180.0 degree in radians
        Eigen::Affine3f scene_sensor_pose = Eigen::Affine3f(
                Eigen::Translation3f(cloud->sensor_origin_[0],
                        cloud->sensor_origin_[1], cloud->sensor_origin_[2]))
                * Eigen::Affine3f(cloud->sensor_orientation_);
        pcl::RangeImage::CoordinateFrame coordinate_frame =
                pcl::RangeImage::LASER_FRAME;
        float noiseLevel = 0.00;
        float minRange = 0.0f;
        int borderSize = 0;

        pcl::RangeImageSpherical::Ptr rangeImage(new pcl::RangeImageSpherical);
        rangeImage->createFromPointCloud(*cloud, angularResolution_x,
                angularResolution_y, maxAngleWidth, maxAngleHeight,
                scene_sensor_pose, coordinate_frame, noiseLevel, minRange,
                borderSize);

        pcl::copyPointCloud(*rangeImage, *cloud);

        std::cerr << cloud->at(100).getVector3fMap().transpose() << std::endl;
        std::cerr << angularResolution_x << " " << angularResolution_y << " "
                << maxAngleWidth << " " << maxAngleHeight << " "
                << scene_sensor_pose.matrix() << std::endl;
        ROS_DEBUG_STREAM(
                "range_image_sample cloud takes : " << timer.getTime());

    }

    static void process(pcl::PCLPointCloud2& cloud2, bool is_compute_normal) {
        XYZPointCloud::Ptr cloud(new XYZPointCloud);
#ifdef WRITE_MSG_TO_FILE
        //write msgs to files for unit test
        std::string input_file_path =
            "/home/hada/msg_files/process_msg_" +
            boost::lexical_cast<std::string>(cloud2.header.seq) + ".msg";
        pcl::PCLPointCloud2::Ptr cloud2_ptr = 
        boost::make_shared<pcl::PCLPointCloud2>(cloud2);
        msg_util::write_msg_to_file<pcl::PCLPointCloud2::Ptr>(
            cloud2_ptr, input_file_path);
#endif
        pcl::fromPCLPointCloud2(cloud2, *cloud);

        cloud->is_dense = false;
        remove_nan(cloud);

        field_filter(cloud, "z", -2, -1.5);

        voxel_grid_sample<pcl::PointXYZ>(cloud, 0.2);

        if (is_compute_normal) {
            pcl::PointCloud<pcl::PointNormal>::Ptr normaled(
                    new pcl::PointCloud<pcl::PointNormal>);

            compute_normal(cloud, normaled);
            voxel_grid_sample<pcl::PointNormal>(normaled, 1.5);
            pcl::toPCLPointCloud2(*normaled, cloud2);
        } else {
            voxel_grid_sample<pcl::PointXYZ>(cloud, 1.5);
            pcl::toPCLPointCloud2(*cloud, cloud2);
        }
#ifdef WRITE_MSG_TO_FILE
        //    write msgs to files for unit test
        std::string output_file_path = "/home/hada/msg_files/process_output_msg_" +
            boost::lexical_cast<std::string>(cloud2.header.seq) + ".msg";
        pcl::PCLPointCloud2::Ptr cloud3_ptr = 
        boost::make_shared<pcl::PCLPointCloud2>(cloud2);
        msg_util::write_msg_to_file<pcl::PCLPointCloud2::Ptr>(
            cloud3_ptr, output_file_path);
#endif 
    }

private:
    ros::Subscriber _sub;
    ros::Publisher _pub;
    std::string _topic_pointcloud2;
    std::string _topic_pointcloud2_filtered;
    int _queue_size_sub;
    int _queue_size_pub;
    bool _is_compute_normal;

    void callback(const sensor_msgs::PointCloud2ConstPtr& cloud_msg);
};

}  // namespace velodyne_pointcloud

#endif
