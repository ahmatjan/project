/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
* *
************************************************************************/

/*
*@file   verify_compensator.cpp
*@author dengchengliang
*@brief
*/
#include "velodyne_unit_test.h"

namespace velodyne_unit_test {

std::string _run_save_folder;
std::string _expected_save_folder;
//file name prefix
std::string _run_file_prefix;
std::string _expected_file_prefix;
int _start_seq;
int _end_seq;
int _wait_time;

TEST(TestSuiteVerifyCompensator, verify_compensator) {
    for (int i = _start_seq; i <= _end_seq; ++i) {
        std::string run_file = _run_save_folder + "/" + _run_file_prefix
                                + boost::lexical_cast<std::string>(i) + ".msg";
        std::cout << run_file << std::endl;

        std::string expected_file = _expected_save_folder + "/" + _expected_file_prefix
                                + boost::lexical_cast<std::string>(i) + ".msg";
        std::cout << expected_file << std::endl;

        sensor_msgs::PointCloud2 run_out_msg;
        msg_util::read_msg_from_file<sensor_msgs::PointCloud2>(run_file, run_out_msg);
        sensor_msgs::PointCloud2 expected_out_msg;
        msg_util::read_msg_from_file<sensor_msgs::PointCloud2>(expected_file, expected_out_msg);

        compare_pointcloud2_msg(expected_out_msg, run_out_msg);
    }
    remove_tmp_files(_run_save_folder, "64e_compensator_out");
}

}

int main(int argc, char** argv) {
    ros::init(argc, argv, "verify_compensator");
    testing::InitGoogleTest(&argc, argv);
    ros::NodeHandle priv_nh("~");
    priv_nh.param("run_save_folder", velodyne_unit_test::_run_save_folder, std::string(""));
    priv_nh.param("expected_save_folder", velodyne_unit_test::_expected_save_folder,
            std::string(""));
    priv_nh.param("run_file_prefix", velodyne_unit_test::_run_file_prefix, std::string(""));
    priv_nh.param("expected_file_prefix", velodyne_unit_test::_expected_file_prefix,
            std::string(""));
    priv_nh.param("start_seq", velodyne_unit_test::_start_seq, 0);
    priv_nh.param("end_seq", velodyne_unit_test::_end_seq, 0);
    priv_nh.param("wait_time", velodyne_unit_test::_wait_time, 0);

    ros::Duration(velodyne_unit_test::_wait_time).sleep();
    ros::shutdown();

    return RUN_ALL_TESTS();
}
