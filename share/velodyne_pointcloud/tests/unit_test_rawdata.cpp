/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
* *
************************************************************************/

/*
*@file   unit_test_rawdata.cpp
*@author fengkaiwen01
*@brief  unit test for class RawData
*
*   Run it by follow steps
*   $ cd  path/to/ros_workspace/build
*   $ make run_tests_velodyne_pointcloud_gtest_velodyne_rawdata_utest
*
*/

#include "velodyne_unit_test.h"
#include <ros/package.h>

namespace velodyne_unit_test {

//conifg for different device
velodyne_rawdata::Config _config_64;
velodyne_rawdata::Config _config_32;
velodyne_rawdata::Config _config_16;

//the first three scan messages subscribe from /dusensor/velodyne/packets(replay bag)
velodyne_msgs::VelodyneScanUnified scan_msg_2;
velodyne_msgs::VelodyneScanUnified scan_msg_3;

//the expect output of RawData::generate_pointcloud
velodyne_rawdata::VPointCloud expect_out_msg_2;
velodyne_rawdata::VPointCloud expect_out_msg_3;

//the expect output of RawData::_order_pointcloud
velodyne_rawdata::VPointCloud expect_ordered_out_msg_2;
velodyne_rawdata::VPointCloud expect_ordered_out_msg_3;

//the actrually output message pointers
velodyne_rawdata::VPointCloud::Ptr out_msg_ptr_2(new velodyne_rawdata::VPointCloud());
velodyne_rawdata::VPointCloud::Ptr out_msg_ptr_3(new velodyne_rawdata::VPointCloud());

boost::shared_ptr<velodyne_rawdata::RawData> _rawdata;

void init_test_data() {
    std::string pkg_path = ros::package::getPath("velodyne_pointcloud");
    std::string msg_folder = pkg_path + "/tests/velodyne_test_msg_files/";

    //config for 64E_S2
    _config_64.calibration_file = pkg_path + "/params/64e_baidu_clear.yaml";
    _config_64.max_range = 70.0f;
    _config_64.min_range = 5.0f;
    _config_64.view_direction = 0.0;
    _config_64.view_width = M_PI * 2.0;
    _config_64.use_gps = true;
    _config_64.model = "64E_S2";
    _config_64.organized = true;
    _config_64.ts_aligned = false;
    _config_64.imu_sync = "xsens";

    _rawdata = boost::shared_ptr<velodyne_rawdata::RawData>(
                    new velodyne_rawdata::RawData(_config_64));
    _rawdata->setup();

    msg_util::read_msg_from_file<velodyne_msgs::VelodyneScanUnified>(
                    msg_folder + "scan_msg_43367.msg", scan_msg_2);
    msg_util::read_msg_from_file<velodyne_msgs::VelodyneScanUnified>(
                    msg_folder + "scan_msg_43368.msg", scan_msg_3);

    //the expect output of RawData::generate_pointcloud
    msg_util::read_msg_from_file<velodyne_rawdata::VPointCloud>(
                    msg_folder + "out_msg_43367.msg", expect_out_msg_2);
    msg_util::read_msg_from_file<velodyne_rawdata::VPointCloud>(
                    msg_folder + "out_msg_43368.msg", expect_out_msg_3);

    //the expect output of RawData::_order_pointcloud
    msg_util::read_msg_from_file<velodyne_rawdata::VPointCloud>(
                msg_folder + "ordered_out_msg_43367.msg", expect_ordered_out_msg_2);
    msg_util::read_msg_from_file<velodyne_rawdata::VPointCloud>(
                msg_folder + "ordered_out_msg_43368.msg", expect_ordered_out_msg_3);
}

TEST(TestSuiteRawData, generate_pointcloud) {

    _rawdata->generate_pointcloud(
            boost::make_shared<velodyne_msgs::VelodyneScanUnified const>(scan_msg_2), out_msg_ptr_2);
//    compare_out_msg(expect_out_msg_2, *out_msg_ptr_2);

     _rawdata->generate_pointcloud(
            boost::make_shared<velodyne_msgs::VelodyneScanUnified const>(scan_msg_3), out_msg_ptr_3);
    compare_out_msg(expect_out_msg_3, *out_msg_ptr_3);
}

TEST(TestSuiteRawData, order_pointcloud) {
    std::cout << out_msg_ptr_2->points.size() << std::endl;
    _rawdata->_order_pointcloud(_rawdata.get(), out_msg_ptr_2);
//    compare_out_msg(expect_ordered_out_msg_2, *out_msg_ptr_2);

    _rawdata->_order_pointcloud(_rawdata.get(), out_msg_ptr_3);
    compare_out_msg(expect_ordered_out_msg_3, *out_msg_ptr_3);
}

} //namespace velodyne_unit_test

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    velodyne_unit_test::init_test_data();
    return RUN_ALL_TESTS();
}
