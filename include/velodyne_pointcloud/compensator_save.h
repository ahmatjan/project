/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
* *
************************************************************************/

/*
*@file   compensator_save.h
*@author dengchengliang
*@brief
*/

#ifndef VELODYNE_COMPENSATOR_SAVE_H
#define VELODYNE_COMPENSATOR_SAVE_H

#include <fstream>
#include <iostream>
#include <pcl_ros/point_cloud.h>
#include <ros/ros.h>
#include <sensor_msgs/PointCloud2.h>

namespace velodyne_pointcloud {

//save msg to file: file name is _file_prefix + msg.seq + .msg
//TODO: need a template class for save msg by topic name and type
class CompensatorSave {

public:
    CompensatorSave(ros::NodeHandle node, ros::NodeHandle private_nh);
    ~CompensatorSave() {}

private:
    void save_callback(const sensor_msgs::PointCloud2ConstPtr &msg);

    //save msg folder
    std::string _save_folder;
    //sub topic name
    std::string _topic_name;
    //save file prefix,file will be prefix_msgseq.msg
    std::string _file_prefix;
    ros::Subscriber _compensator_sub;

};

} // namespace velodyne_pointcloud

#endif // VELODYNE_COMPENSATOR_SAVE_H
