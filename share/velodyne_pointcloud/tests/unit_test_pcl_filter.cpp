#include <gtest/gtest.h>
#include <boost/thread.hpp>
#include <errno.h>
#include <stdint.h>
#include <string>
#include <boost/format.hpp>
#include <math.h>

#include <msg_util/msg_util.h>
#include <pcl_filter.h>
#include <ros/package.h>
#include <time_util/time_util.h>
#include <pcl_ros/point_cloud.h>
#include "velodyne_unit_test.h"

namespace velodyne_unit_test {

void init_test_data() {
}

TEST(TestSuiteFilter, fieldFilter){
    std::string msg_folder = ros::package::getPath("velodyne_pointcloud") + 
        "/tests/velodyne_test_msg_files/";
    pcl::PointCloud<pcl::PointXYZ> cloud_msg_1;
    msg_util::read_msg_from_file<pcl::PointCloud<pcl::PointXYZ> >(msg_folder + "filterZ_msg_43304.msg", cloud_msg_1);
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_msg_ptr = 
        boost::make_shared<pcl::PointCloud<pcl::PointXYZ> >(cloud_msg_1);
    velodyne_pointcloud::PclFilter::field_filter(cloud_msg_ptr, "z", -2, -1.5);
    for (int i = 0; i < cloud_msg_ptr->points.size(); ++i) {
        pcl::PointXYZ point = cloud_msg_ptr->points.at(i);
        EXPECT_GE(point.z, -2);
        EXPECT_LE(point.z, -1.5);
    }
}

TEST(TestSuiteFilter, computeNormal){
    std::string msg_folder = ros::package::getPath("velodyne_pointcloud") + 
        "/tests/velodyne_test_msg_files/";
    pcl::PointCloud<pcl::PointXYZ> input_msg;
    msg_util::read_msg_from_file<pcl::PointCloud<pcl::PointXYZ> >(
        msg_folder + "computeNormal_msg_43304.msg", input_msg);
    pcl::PointCloud<pcl::PointXYZ>::Ptr input_msg_ptr = 
        boost::make_shared<pcl::PointCloud<pcl::PointXYZ> >(input_msg);

    pcl::PointCloud<pcl::PointNormal>::Ptr normaled(new pcl::PointCloud<pcl::PointNormal>);
    velodyne_pointcloud::PclFilter::compute_normal(input_msg_ptr, normaled);

    pcl::PointCloud<pcl::PointNormal> output_msg;
    msg_util::read_msg_from_file<pcl::PointCloud<pcl::PointNormal> >(
        msg_folder + "computeNormal_output_msg_43304.msg", output_msg);
    compare_pcl_pointnormal_msg(*normaled, output_msg);
}

TEST(TestSuiteFilter, voxelGridSample){
    std::string msg_folder = ros::package::getPath("velodyne_pointcloud") + 
        "/tests/velodyne_test_msg_files/";
    pcl::PointCloud<pcl::PointXYZ> input_msg;
    msg_util::read_msg_from_file<pcl::PointCloud<pcl::PointXYZ> >(
            msg_folder + "voxelGrid_msg_43304.msg", input_msg);
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud = 
        boost::make_shared<pcl::PointCloud<pcl::PointXYZ> >(input_msg);

    velodyne_pointcloud::PclFilter::voxel_grid_sample<pcl::PointXYZ>(cloud, 0.2);

    pcl::PointCloud<pcl::PointXYZ> output_msg;
    msg_util::read_msg_from_file<pcl::PointCloud<pcl::PointXYZ> >(
        msg_folder + "voxelGrid_output_msg_43304.msg", output_msg);
    pcl::PointCloud<pcl::PointXYZ>::Ptr output_msg_ptr = 
        boost::make_shared<pcl::PointCloud<pcl::PointXYZ> >(output_msg);
    compare_pcl_pointcloud_msg<pcl::PointXYZ>(cloud, output_msg_ptr);
}

TEST(TestSuiteFilter, process){
    std::string msg_folder = ros::package::getPath("velodyne_pointcloud") +
        "/tests/velodyne_test_msg_files/";
    pcl::PCLPointCloud2 input_msg;
    msg_util::read_msg_from_file<pcl::PCLPointCloud2>(
            msg_folder + "process_msg_43304.msg", input_msg);
    pcl::PCLPointCloud2::Ptr cloud2 =
      boost::make_shared<pcl::PCLPointCloud2>(input_msg);
/* default setting of compute_normal is 1,if just want to test down sample function,pls generate new *.msg files use roslaunch after set the value of compute_normal to be false in *.launch file, at last change the input variable compute_normal of process and compare_pcl_pclpointcloud2_msg function to be 0.
*/
    velodyne_pointcloud::PclFilter::process(*cloud2, 1);

    pcl::PCLPointCloud2 output_msg;
    msg_util::read_msg_from_file<pcl::PCLPointCloud2>(
        msg_folder + "process_output_msg_43304.msg", output_msg);
    pcl::PCLPointCloud2::Ptr output_msg_ptr =
    boost::make_shared<pcl::PCLPointCloud2>(output_msg);
    compare_pcl_pclpointcloud2_msg(cloud2, output_msg_ptr, 1);
}
} //namespace velodyne_unit_test

int main(int argc, char** argv){
    testing::InitGoogleTest(&argc, argv);
//    init_test_data();
    return RUN_ALL_TESTS();
}

