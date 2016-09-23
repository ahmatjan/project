/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
* *
************************************************************************/

/*
*@file   scan_msg_transform.h
*@author fengkaiwen01
*@brief transform the scan messages from the idl ros bag file into the new format
*/

#ifndef CAR_ROS_DRIVERS_VELODYNE_VELODYNE_POINTCLOUD_SRC_SCAN_MSG_TRANSFORM_H
#define CAR_ROS_DRIVERS_VELODYNE_VELODYNE_POINTCLOUD_SRC_SCAN_MSG_TRANSFORM_H

#include "const_variables.h"

#include <ros/ros.h>
#include "velodyne_msgs/VelodyneScan.h"
#include "rawdata.h"

namespace velodyne_pointcloud {

class Transform {
public:
    Transform(ros::NodeHandle node, ros::NodeHandle private_nh);
    ~Transform() {}

private:
    ros::Subscriber _velodyne_scan_sub;
    ros::Publisher _velodyne_scan_pub;
    int _queue_size;
    std::string _topic_packets;
    std::string _topic_packets_legacy;

    void transform_scan_msg(const velodyne_msgs::VelodyneScan::ConstPtr &scan_msg_old);
};

}

#endif /* CAR_ROS_DRIVERS_VELODYNE_VELODYNE_POINTCLOUD_SRC_SCAN_MSG_TRANSFORM_H_ */
