/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
* *
************************************************************************/

/*
*@file   pointcloud_save.h
*@author dengchengliang
*@brief
*/

#ifndef VELODYNE_POINTCLOUD_SAVE_H
#define VELODYNE_POINTCLOUD_SAVE_H

#include <ros/ros.h>
#include <pcl_ros/point_cloud.h>
#include <iostream>
#include <fstream>

#include "rawdata.h"

namespace velodyne_pointcloud {

//save msg to file: file name is _file_prefix + msg.seq + .msg
class PointCloudSave {

public:
    PointCloudSave(ros::NodeHandle node, ros::NodeHandle private_nh);
    ~PointCloudSave() {}

private:
    void save_callback(const velodyne_rawdata::VPointCloud::ConstPtr &msg);

    //save msg folder
    std::string _save_folder;
    //sub topic name
    std::string _topic_name;
    //save file prefix,file will be prefix_msgseq.msg
    std::string _file_prefix;
    ros::Subscriber _pointcloud_sub;

};

} // namespace velodyne_pointcloud

#endif // VELODYNE_POINTCLOUD_SAVE_H
