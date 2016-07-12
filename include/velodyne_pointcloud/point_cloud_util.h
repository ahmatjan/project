#ifndef VELODYNE_POINTCLOUD_POINT_CLOUD_UTIL_H
#define VELODYNE_POINTCLOUD_POINT_CLOUD_UTIL_H

#include <Eigen/Eigen>
#include <ros/node_handle.h>

namespace velodyne_pointcloud {

bool check_offsets(const pcl::PCLPointCloud2& msg,
        int& x_offset, int& y_offset, int& z_offset) {
    //check msg width and height
    if (msg.width == 0 || msg.height == 0) {
        return false;
    }

    int x_data_type = 0;
    int y_data_type = 0;
    int z_data_type = 0;
    int point_datatype = 0;

    for (size_t i = 0; i < msg.fields.size(); ++i) {
        const pcl::PCLPointField& f = msg.fields[i];

        if (f.name == "x") {
            x_offset = f.offset;
            x_data_type = f.datatype;
            point_datatype = f.datatype;
            if ((x_data_type != 7 && x_data_type != 8)
                    || f.count != 1
                    || x_offset == -1
                    || point_datatype == -1) {
                ROS_INFO_STREAM("Invalid data type / offset / count for x field");
                return false;
            }
        } else if (f.name == "y") {
            y_offset = f.offset;
            y_data_type = f.datatype;
            if (f.count != 1 || y_offset == -1) {
                ROS_INFO_STREAM("Invalid offset / count for y field");
                return false;
            }
        } else if (f.name == "z") {
            z_offset = f.offset;
            z_data_type = f.datatype;
            if (f.count != 1 || z_offset == -1) {
                ROS_INFO_STREAM("Invalid offset / count for z field");
                return false;
            }
        }else{
            ROS_INFO_STREAM("get an unused field name:" << f.name);
        }
    }

    //check offset if valid
    return !((x_offset == -1 || y_offset == -1 || z_offset == -1 || point_datatype == -1)
            || !(x_data_type == y_data_type && y_data_type == z_data_type));
}

template<typename Scalar>
inline Scalar* get_coord(const pcl::PCLPointCloud2& cloud, int index, const int& offset) {
    return reinterpret_cast<Scalar*>(cloud.data[index * cloud.point_step + offset]);
}
}
#endif /* VELODYNE_POINTCLOUD_POINT_CLOUD_UTIL_H */
