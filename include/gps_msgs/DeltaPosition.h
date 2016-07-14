// Generated by gencpp from file gps_msgs/DeltaPosition.msg
// DO NOT EDIT!


#ifndef GPS_MSGS_MESSAGE_DELTAPOSITION_H
#define GPS_MSGS_MESSAGE_DELTAPOSITION_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>
#include <gps_msgs/XYZRpvData.h>
#include <gps_msgs/ENURpvData.h>

namespace gps_msgs
{
template <class ContainerAllocator>
struct DeltaPosition_
{
  typedef DeltaPosition_<ContainerAllocator> Type;

  DeltaPosition_()
    : header()
    , seq(0)
    , stamp()
    , frame_id()
    , gps_id()
    , gps_time0(0.0)
    , gps_time1(0.0)
    , dt(0.0)
    , status(0)
    , xyz()
    , enu()  {
    }
  DeltaPosition_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , seq(0)
    , stamp()
    , frame_id(_alloc)
    , gps_id(_alloc)
    , gps_time0(0.0)
    , gps_time1(0.0)
    , dt(0.0)
    , status(0)
    , xyz(_alloc)
    , enu(_alloc)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef uint32_t _seq_type;
  _seq_type seq;

   typedef ros::Time _stamp_type;
  _stamp_type stamp;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _frame_id_type;
  _frame_id_type frame_id;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _gps_id_type;
  _gps_id_type gps_id;

   typedef double _gps_time0_type;
  _gps_time0_type gps_time0;

   typedef double _gps_time1_type;
  _gps_time1_type gps_time1;

   typedef double _dt_type;
  _dt_type dt;

   typedef uint8_t _status_type;
  _status_type status;

   typedef  ::gps_msgs::XYZRpvData_<ContainerAllocator>  _xyz_type;
  _xyz_type xyz;

   typedef  ::gps_msgs::ENURpvData_<ContainerAllocator>  _enu_type;
  _enu_type enu;




  typedef boost::shared_ptr< ::gps_msgs::DeltaPosition_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::gps_msgs::DeltaPosition_<ContainerAllocator> const> ConstPtr;

}; // struct DeltaPosition_

typedef ::gps_msgs::DeltaPosition_<std::allocator<void> > DeltaPosition;

typedef boost::shared_ptr< ::gps_msgs::DeltaPosition > DeltaPositionPtr;
typedef boost::shared_ptr< ::gps_msgs::DeltaPosition const> DeltaPositionConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::gps_msgs::DeltaPosition_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::gps_msgs::DeltaPosition_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace gps_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'std_msgs': ['/home/caros/ros/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/home/caros/ros/share/geometry_msgs/cmake/../msg'], 'sensor_msgs': ['/home/caros/ros/share/sensor_msgs/cmake/../msg'], 'gps_msgs': ['/home/scmbuild/workspaces_cluster/baidu.car-os.ros/baidu/car-os/ros/drivers/src/car_ros_drivers/novatel/gps-msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::gps_msgs::DeltaPosition_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::gps_msgs::DeltaPosition_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::gps_msgs::DeltaPosition_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::gps_msgs::DeltaPosition_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::gps_msgs::DeltaPosition_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::gps_msgs::DeltaPosition_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::gps_msgs::DeltaPosition_<ContainerAllocator> >
{
  static const char* value()
  {
    return "c73c8087b50ba1930a88250b581bfacb";
  }

  static const char* value(const ::gps_msgs::DeltaPosition_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xc73c8087b50ba193ULL;
  static const uint64_t static_value2 = 0x0a88250b581bfacbULL;
};

template<class ContainerAllocator>
struct DataType< ::gps_msgs::DeltaPosition_<ContainerAllocator> >
{
  static const char* value()
  {
    return "gps_msgs/DeltaPosition";
  }

  static const char* value(const ::gps_msgs::DeltaPosition_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::gps_msgs::DeltaPosition_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# Message output by TDCP\n\
\n\
Header header\n\
    uint32 seq\n\
    time stamp\n\
    string frame_id\n\
\n\
string  gps_id\n\
float64 gps_time0\n\
float64 gps_time1\n\
\n\
float64 dt\n\
\n\
## Status\n\
##      0: Fault, standard positioning solution reported\n\
##      1: All good\n\
uint8 status\n\
\n\
XYZRpvData xyz\n\
ENURpvData enu\n\
\n\
================================================================================\n\
MSG: std_msgs/Header\n\
# Standard metadata for higher-level stamped data types.\n\
# This is generally used to communicate timestamped data \n\
# in a particular coordinate frame.\n\
# \n\
# sequence ID: consecutively increasing ID \n\
uint32 seq\n\
#Two-integer timestamp that is expressed as:\n\
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n\
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n\
# time-handling sugar is provided by the client library\n\
time stamp\n\
#Frame this data is associated with\n\
# 0: no frame\n\
# 1: global frame\n\
string frame_id\n\
\n\
================================================================================\n\
MSG: gps_msgs/XYZRpvData\n\
float64 x\n\
float64 y\n\
float64 z\n\
================================================================================\n\
MSG: gps_msgs/ENURpvData\n\
float64 e\n\
float64 n\n\
float64 u\n\
";
  }

  static const char* value(const ::gps_msgs::DeltaPosition_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::gps_msgs::DeltaPosition_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.seq);
      stream.next(m.stamp);
      stream.next(m.frame_id);
      stream.next(m.gps_id);
      stream.next(m.gps_time0);
      stream.next(m.gps_time1);
      stream.next(m.dt);
      stream.next(m.status);
      stream.next(m.xyz);
      stream.next(m.enu);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct DeltaPosition_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::gps_msgs::DeltaPosition_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::gps_msgs::DeltaPosition_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "seq: ";
    Printer<uint32_t>::stream(s, indent + "  ", v.seq);
    s << indent << "stamp: ";
    Printer<ros::Time>::stream(s, indent + "  ", v.stamp);
    s << indent << "frame_id: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.frame_id);
    s << indent << "gps_id: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.gps_id);
    s << indent << "gps_time0: ";
    Printer<double>::stream(s, indent + "  ", v.gps_time0);
    s << indent << "gps_time1: ";
    Printer<double>::stream(s, indent + "  ", v.gps_time1);
    s << indent << "dt: ";
    Printer<double>::stream(s, indent + "  ", v.dt);
    s << indent << "status: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.status);
    s << indent << "xyz: ";
    s << std::endl;
    Printer< ::gps_msgs::XYZRpvData_<ContainerAllocator> >::stream(s, indent + "  ", v.xyz);
    s << indent << "enu: ";
    s << std::endl;
    Printer< ::gps_msgs::ENURpvData_<ContainerAllocator> >::stream(s, indent + "  ", v.enu);
  }
};

} // namespace message_operations
} // namespace ros

#endif // GPS_MSGS_MESSAGE_DELTAPOSITION_H
