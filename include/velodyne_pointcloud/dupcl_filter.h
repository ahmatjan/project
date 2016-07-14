#ifndef VELODYNE_POINTCLOUD_DUPCL_FILTER_H
#define VELODYNE_POINTCLOUD_DUPCL_FILTER_H

#include <boost/smart_ptr/make_shared_object.hpp>
#include <boost/smart_ptr/shared_ptr.hpp>
#include <pcl/point_types.h>
#include <pcl/point_cloud.h>
#include <pcl/PCLPointCloud2.h>
#include <pcl_conversions/pcl_conversions.h>
#include <ros/node_handle.h>
#include <ros/publisher.h>
#include <ros/subscriber.h>
#include <sensor_msgs/PointCloud2.h>
#include "voxel_grid.h"

namespace velodyne_pointcloud
{
class Filter {
private:
    ros::Subscriber _sub;
    ros::Publisher _pub;
    std::string _topic_pointcloud2;
    std::string _topic_pointcloud2_filtered;
    std::string _filter_field_name;
    int _queue_size_sub;
    int _queue_size_pub;
    float _resolution;
    float _limit_min;
    float _limit_max;

public:
 
    static inline void voxel_grid_sample(pcl::PCLPointCloud2& cloud2, float resolution,
            std::string filter_field_name, float limit_min, float limit_max) {
        pcl::PCLPointCloud2 filtered_cloud;
        DuVoxelGrid voxel_grid;
        voxel_grid.set_input_cloud(cloud2);
        voxel_grid.set_leaf_size(resolution, resolution, resolution);
        voxel_grid.set_filter_field_name(filter_field_name);
        voxel_grid.set_filter_limits(limit_min, limit_max);
        voxel_grid.apply_filter(filtered_cloud);
        cloud2 = filtered_cloud;
    }

    void process(pcl::PCLPointCloud2& cloud2, float Resolution, 
        std::string Filter_field_name, float Limit_min, float Limit_max);

  /*  void process(pcl::PCLPointCloud2& cloud2);*/

    void callback(const sensor_msgs::PointCloud2ConstPtr& cloud_msg);

    Filter(ros::NodeHandle nh, ros::NodeHandle private_nh);
};

}
#endif /* VELODYNE_POINTCLOUD_DUPCL_FILTER_H */
