/************************************************************************
 *
 * Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
 *
 ************************************************************************/
/**
 * @file compensator.h
 * @author dengchengliang
 * @date 2016/03/15
 *
 **/

#ifndef VELODYNE_POINTCLOUD_COMPENSATOR_H
#define VELODYNE_POINTCLOUD_COMPENSATOR_H

#include "const_variables.h"

#include <eigen_conversions/eigen_msg.h>
#include <Eigen/Eigen>
#include <pcl/common/time.h>
#include <ros/ros.h>
#include <sensor_msgs/PointCloud2.h>
#include <std_msgs/String.h>
#include <tf2_ros/transform_listener.h>

namespace velodyne_pointcloud {

//default child frame id
static const std::string VELODYNE_FRAME_ID_DEFAULT = "velodyne";
//ros publisher and subscriber default queue size
static const int QUEUE_SIZE = 10;

class Compensator {

public:
    Compensator(ros::NodeHandle node, ros::NodeHandle private_nh);
    virtual ~Compensator() {}

private:
    /**
    * @brief get pointcloud2 msg, compensate it,publish pointcloud2 after compensator
    *  TODO: why callback data type is sensor_msgs::PointCloud2, not velodyne_rawdata::VPointCloud
    */
    void pointcloud_callback(const sensor_msgs::PointCloud2ConstPtr& msg);
    /**
    * @brief get pose matrix from tf2 by gps timestamp
    *   novatel-preprocess broadcast the tf2 transfrom.
    */
    bool query_pose_from_tf2(const double& timestamp, Eigen::Matrix4d& pose);
    /**
    * @brief check if message is valid, check width, height, timesatmp.
    *   set timestamp_offset and point data type
    */
    bool check_message(const sensor_msgs::PointCloud2ConstPtr& msg);
    /**
    * @brief motion compensation for point cloud
    */
    template <typename Scalar>
    void motion_compensation(sensor_msgs::PointCloud2::Ptr& msg,
            const double timestamp_min, const double timestamp_max,
            const Eigen::Matrix4d& pose_min_time, const Eigen::Matrix4d& pose_max_time);
    /**
    * @brief get min timestamp and max timestamp from points in pointcloud2
    */
    inline void get_timestamp_interval(const sensor_msgs::PointCloud2ConstPtr& msg,
                                       double& timestamp_min, double& timestamp_max);
    /**
    * @brief get point field size by sensor_msgs::datatype
    */
    inline uint get_field_size(const int data_type);

    //subsrcibe velodyne pointcloud2 msg.
    ros::Subscriber _velodyne_points_subscriber;
    //publish point cloud2 after motion compensation
    ros::Publisher _compensation_publisher;
    //tf2 buffer
    tf2_ros::Buffer _tf2_buffer;
    //tf2 transform listener to get transform by gps timestamp.
    tf2_ros::TransformListener _tf2_transform_listener;
    //transform child frame id(world -> child frame)
    std::string _child_frame_id;


    //varibes for point fields value, we get point x,y,z by these offset
    int _x_offset;
    int _y_offset;
    int _z_offset;
    int _timestamp_offset;
    uint _timestamp_data_size;
    //point datatype: float or double
    int8_t _point_datatype;
    std::list<sensor_msgs::PointCloud2ConstPtr> _pointcloud_queue;

    //topic names
    std::string _topic_compensated_pointcloud;
    std::string _topic_pointcloud;
    //ros queue size for publisher and subscriber
    int _queue_size;
};

} // namespace velodyne_pointcloud

#endif
