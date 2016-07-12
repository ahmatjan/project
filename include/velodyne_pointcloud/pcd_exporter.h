/*
 * =====================================================================================
 *
 *       Filename:  exporter.h
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  04/22/2015 02:33:53 PM
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Luo Pei (), luopei@baidu.com
 *   Organization:
 *
 * =====================================================================================
 */
#ifndef  VELODYNE_POINTCLOUD_PCD_EXPORTER_H
#define  VELODYNE_POINTCLOUD_PCD_EXPORTER_H

#include "const_variables.h"

#include <ros/ros.h>
#include <iostream>
#include <fstream>
#include <boost/filesystem.hpp>
#include <pcl_conversions/pcl_conversions.h>
#include <pcl/common/time.h>
#include <tf2_ros/transform_listener.h>
#include <eigen_conversions/eigen_msg.h>
#include <sensor_msgs/PointCloud2.h>

namespace velodyne_pointcloud {

class PCDExporter {
public:
    PCDExporter(ros::NodeHandle node, ros::NodeHandle private_nh);
    ~PCDExporter();
    void init();
    /**
     * @brief write pc data to pcd/pcd_pos/stamp file when recieve a msg
     */
    void pcd_writer_callback(const sensor_msgs::PointCloud2::ConstPtr &msg);

private:
    //An exist folder to save pcd files
    std::string _pcd_folder;
    //File name of _stamp_file;
    std::string _stamp_file;
    FILE* _stamp_file_handle;
    //File name of pcd_pose file
    std::string _pose_file;
    FILE* _pose_file_handle;
    //Default "velodyne"
    std::string _child_frame_id;
    ros::Subscriber _sub;

    boost::shared_ptr<tf2_ros::Buffer> _tf_buffer_ptr;
    boost::shared_ptr<tf2_ros::TransformListener> _tf_listener_ptr;
    //todo
    bool _skip_static_frames;
    //use the seq of a message as index or not
    bool _use_seq_as_index;
    float _time_offset;
    //todo
    float _loc_threshold;
    // Message counter, use as index when _use_seq = false
    unsigned int _pc_msg_count;
    std::string _topic_pointcloud;
    int _queue_size;

    /**
     * @brief Query pose
     */
    bool get_pose(const ros::Time &time, Eigen::Matrix4d &pose);

    void write_pcd_file(const std::string &filename,
            const sensor_msgs::PointCloud2::ConstPtr &msg);
    /**
     * @brief Write pose info with the index of message to a file
     */
    bool write_pcd_pose_file(const sensor_msgs::PointCloud2::ConstPtr &msg, int index);
};

}

#endif // VELODYNE_POINTCLOUD_PCD_EXPORTER_H
