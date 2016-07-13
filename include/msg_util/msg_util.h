/************************************************************************
*
* Copyright (c) 2016 Baidu.com, Inc. All Rights Reserved
* *
************************************************************************/

/*
*@file   msg_util.h
*@author fengkaiwen01
*@brief
*/

#ifndef UTILITIES_MSG_UTIL_H
#define UTILITIES_MSG_UTIL_H

#include <ros/ros.h>
#include <fstream>

namespace msg_util {

template<class T>
void write_msg_to_file(const T &scan_msg, std::string file_path) {
    std::ofstream ofs(file_path.c_str(), std::ofstream::out | std::ofstream::binary);
    uint32_t serial_size = ros::serialization::serializationLength(*scan_msg);
    boost::shared_array<uint8_t> obuffer(new uint8_t[serial_size]);
    ros::serialization::OStream ostream(obuffer.get(), serial_size);
    ros::serialization::serialize(ostream, *scan_msg);
    ofs.write((char*)obuffer.get(), serial_size);
    ofs.close();
}

template<class T>
void read_msg_from_file(std::string file_path, T &scan_msg) {

    std::ifstream ifs(file_path.c_str(), std::ifstream::in | std::ifstream::binary);
    ifs.seekg(0, std::ios::end);
    std::streampos end = ifs.tellg();
    ifs.seekg(0, std::ios::beg);
    std::streampos begin = ifs.tellg();

    uint32_t file_size = end - begin;
    boost::shared_array<uint8_t> ibuffer(new uint8_t[file_size]);
    ifs.read((char*) ibuffer.get(), file_size);
    ros::serialization::IStream istream(ibuffer.get(), file_size);
    ros::serialization::deserialize(istream, scan_msg);
    ifs.close();
}

}

#endif // UTILITIES_MSG_UTIL_H
