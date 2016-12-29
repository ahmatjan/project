#include "test.h"

#include <iostream> //标准输入输出流

#include <pcl/io/pcd_io.h> //PCL的PCD格式文件的输入输出头文件
#include <pcl/point_types.h> //PCL对各种格式的点的支持头文件

#ifndef UNIT_TEST
int main(int argc, char *argv[]) {
#else
int inner_main(int argc, char *argv[]) {
#endif
    pcl::PointCloud<pcl::PointXYZ>::Ptr cloud (new pcl::PointCloud<pcl::PointXYZ>); // 创建点云（指针）
    if (pcl::io::loadPCDFile<pcl::PointXYZ> ("../data/bunny.pcd", *cloud) == -1) {
        PCL_ERROR ("Couldn't read file test_pcd.pcd \n"); //文件不存在时，返回错误，终止程序。
        return (-1);
    }
    std::cout << "Loaded "
            << cloud->width * cloud->height
            << " data points from test_file.pcd with the following fields: "
            << std::endl;
    //for (size_t i = 0; i < cloud->points.size (); ++i) //显示所有的点
    for (size_t i = 0; i < 5; ++i) // 为了方便观察，只显示前5个点
        std::cout << "    " << cloud->points[i].x
                << " "    << cloud->points[i].y
                << " "    << cloud->points[i].z << std::endl;
    return (0);
} 
