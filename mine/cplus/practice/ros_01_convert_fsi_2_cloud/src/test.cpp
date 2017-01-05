#include "test.h"

#include <iostream>  
#include <fstream>  

#include <sensor_msgs/PointCloud2.h>

#include "rosmsg_util.h"
#include "base64.h"

#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
int inner_main(int argc, char *argv[]) {
#endif
    std::string file_name = "../data/pcd.fsi";
    std::string line;
    std::ifstream read_file(file_name, std::ios::in);
    int lineno = 0;
    while(getline(read_file, line)) {
        std::cout << "line[" << lineno++ << "]" << std::endl;
        //std::cout << line << std::endl;
        std::string serialized_msg;
        base64_decode(line, &serialized_msg);
        //std::cout << serialized_msg << std::endl;
        //sensor_msgs::PointCloud2Ptr ros_pc2(new sensor_msgs::PointCloud2);
        sensor_msgs::PointCloud2* ros_pc2 = new sensor_msgs::PointCloud2;
        RosmsgUtil<sensor_msgs::PointCloud2>::string_2_rosmsg(serialized_msg, ros_pc2);
        std::cout << "height : " << ros_pc2->height << std::endl;
        std::cout << "width : " << ros_pc2->width << std::endl;
        std::cout << "is_bigendian : " << ros_pc2->is_bigendian << std::endl;
        std::cout << "point_step : " << ros_pc2->point_step << std::endl;
        std::cout << "row_step : " << ros_pc2->row_step << std::endl;
    }
    return 0;
}  
