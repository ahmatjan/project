#ifndef ADU_PERCEPTION_LIB_BASE_ROSMSG_UTIL_H
#define ADU_PERCEPTION_LIB_BASE_ROSMSG_UTIL_H

#include <fstream>
#include <string>

#include <ros/ros.h>

#include "noncopyable.h"

template <class T>
class RosmsgUtil {
public:
    RosmsgUtil() {}
    ~RosmsgUtil() {}

    // T: std_msgs::ColorRGBA etc
    static void string_2_rosmsg(const std::string& line, T* msg);

    // T: std_msgs::ColorRGBAPtr etc
    static void rosmsg_2_string(const T& msg, std::string* line);

private:
    DISALLOW_COPY_AND_ASSIGN(RosmsgUtil);
};

template <class T>
void RosmsgUtil<T>::string_2_rosmsg(const std::string& line, T* msg) {
    uint32_t len = static_cast<uint32_t>(line.size());
    boost::shared_array<uint8_t> buffer(new uint8_t[len]);
    line.copy((char*)buffer.get(), len);
    ros::serialization::IStream istream(buffer.get(), len);
    ros::serialization::deserialize(istream, *msg); 
}

template <class T>
void RosmsgUtil<T>::rosmsg_2_string(const T& msg, std::string* line) {
    uint32_t len = ros::serialization::serializationLength(*msg);
    boost::shared_array<uint8_t> buffer(new uint8_t[len]);
    ros::serialization::OStream ostream(buffer.get(), len);
    ros::serialization::serialize(ostream, *msg);
    std::string temp((char*)buffer.get(), len);
    swap(temp, *line);
}

#endif  // ADU_PERCEPTION_LIB_BASE_ROSMSG_UTIL_H
