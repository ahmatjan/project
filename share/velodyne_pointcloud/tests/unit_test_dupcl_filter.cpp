#include <boost/format.hpp>
#include <boost/thread.hpp>
#include <errno.h>
#include <gtest/gtest.h>
#include <math.h>
#include <msg_util/msg_util.h>
#include <pcl_ros/point_cloud.h>
#include <ros/package.h>
#include <stdint.h>
#include <string>
#include <sys/time.h>
#include <time_util/time_util.h>

#include "dupcl_filter.h"
#include "velodyne_unit_test.h"

namespace velodyne_unit_test {

void init_test_data() {
}

TEST(TestSuiteFilter, voxelGridSample){
    std::string msg_folder = ros::package::getPath("velodyne_pointcloud") +
            "/tests/velodyne_test_msg_files/";
    pcl::PointCloud<pcl::PointXYZ> input_msg;
    msg_util::read_msg_from_file<pcl::PointCloud<pcl::PointXYZ> >(
            msg_folder + "voxelGrid_msg_43304.msg", input_msg);
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud =
            boost::make_shared<pcl::PointCloud<pcl::PointXYZ> >(input_msg);
    pcl::PCLPointCloud2 cloud2;
    pcl::toPCLPointCloud2(*cloud, cloud2);
    int start = get_time();
    velodyne_pointcloud::Filter::voxel_grid_sample(cloud2, 0.2, "z", -2, -1.5);
    std::cout << "duration: " << get_time() - start << "ms \n";
    pcl::PointCloud<pcl::PointXYZ> output_msg;
    msg_util::read_msg_from_file<pcl::PointCloud<pcl::PointXYZ> >(
            msg_folder + "voxelGrid_output_msg_43304.msg", output_msg);
    std::cout << output_msg.points.size() << " points\n";
    pcl::PointCloud<pcl::PointXYZ>::Ptr output_msg_ptr =
            boost::make_shared<pcl::PointCloud<pcl::PointXYZ> >(output_msg);
    pcl::fromPCLPointCloud2(cloud2, *cloud);
    compare_pcl_pointcloud_msg<pcl::PointXYZ>(cloud, output_msg_ptr);
}
} //namespace velodyne_unit_test

int main(int argc, char** argv){
    testing::InitGoogleTest(&argc, argv);
//    init_test_data();
    return RUN_ALL_TESTS();
}

