/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
*
************************************************************************/
/**
* @file convert.h
* @author fengkaiwen01
* @date 2016/03/8
*
**/
#ifndef VELODYNE_POINTCLOUD_CONVERT_H
#define VELODYNE_POINTCLOUD_CONVERT_H

#include <ros/ros.h>
#include <sensor_msgs/PointCloud2.h>
#include <std_msgs/Time.h>
#include <sensor_msgs/Imu.h>
#include <nav_msgs/Odometry.h>

#include "rawdata.h"

namespace velodyne_pointcloud {

typedef boost::shared_ptr<velodyne_rawdata::RawData> RawDataPtr;

static const std::string TOPIC_IMU_SYNCTIME_SUB = "imu/synctime";
static const std::string TOPIC_IMU_DATA_SUB = "imu/data";
static const std::string TOPIC_IMU_RESTAMP_PUB = "imu/data_synced";

//convert velodyne data to pointcloud and republish
class Convert {

public:
    Convert(ros::NodeHandle node, ros::NodeHandle private_nh);
    ~Convert() {}

private:
    //init velodyne config struct from private_nh
    void init_config(ros::NodeHandle private_nh);
    //convert velodyne data to pointcloudn and public
    void convert_velodyne_to_pointcloud(const velodyne_msgs::VelodyneScanUnified::ConstPtr& scan_msg);

    //bocong
    //align imu timestamp
    void imu_timestamp_align(const std_msgs::Time::ConstPtr &imusynctimeMsg);
    //restamp imu timestamp and public
    sensor_msgs::Imu::Ptr restamp_imu_timestamp(const sensor_msgs::Imu::ConstPtr &imuMsg);

    void repub_imu_timestamp(const sensor_msgs::Imu::ConstPtr& imu_msg);
    //RawData class for converting data to point cloud
    RawDataPtr _raw_data;

    ros::Subscriber _velodyne_scan;
    ros::Subscriber _imu_str_scan;
    ros::Subscriber _imu_restamp_sub;
    ros::Publisher _velodyne_points_output;
    ros::Publisher _imu_restamp_pub;

    std::string _topic_packets;
    std::string _topic_pointcloud;
    std::string _topic_imu_sync_time_sub;
    std::string _topic_imu_data_sub;
    std::string _topic_imu_restamp_pub;

    ros::Duration _timealign;

    /// configuration parameters, get config struct from rawdata.h
    velodyne_rawdata::Config _config;
    //queue size for ros node pub
    int _queue_size;
};

} // namespace velodyne_pointcloud

#endif // VELODYNE_POINTCLOUD_CONVERT_H
