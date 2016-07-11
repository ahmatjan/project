// Generated by gencpp from file image_exposure_msgs/ExposureSequence.msg
// DO NOT EDIT!


#ifndef IMAGE_EXPOSURE_MSGS_MESSAGE_EXPOSURESEQUENCE_H
#define IMAGE_EXPOSURE_MSGS_MESSAGE_EXPOSURESEQUENCE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>

namespace image_exposure_msgs
{
template <class ContainerAllocator>
struct ExposureSequence_
{
  typedef ExposureSequence_<ContainerAllocator> Type;

  ExposureSequence_()
    : header()
    , shutter()
    , gain(0.0)
    , white_balance_blue(0)
    , white_balance_red(0)  {
    }
  ExposureSequence_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , shutter(_alloc)
    , gain(0.0)
    , white_balance_blue(0)
    , white_balance_red(0)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef std::vector<uint32_t, typename ContainerAllocator::template rebind<uint32_t>::other >  _shutter_type;
  _shutter_type shutter;

   typedef float _gain_type;
  _gain_type gain;

   typedef uint16_t _white_balance_blue_type;
  _white_balance_blue_type white_balance_blue;

   typedef uint16_t _white_balance_red_type;
  _white_balance_red_type white_balance_red;




  typedef boost::shared_ptr< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> const> ConstPtr;

}; // struct ExposureSequence_

typedef ::image_exposure_msgs::ExposureSequence_<std::allocator<void> > ExposureSequence;

typedef boost::shared_ptr< ::image_exposure_msgs::ExposureSequence > ExposureSequencePtr;
typedef boost::shared_ptr< ::image_exposure_msgs::ExposureSequence const> ExposureSequenceConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace image_exposure_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'image_exposure_msgs': ['/home/fengkaiwen/ros/drivers/src/car_ros_drivers/pointgrey_camera_3rd/image_exposure_msgs/msg'], 'std_msgs': ['/home/fengkaiwen/caros/ros/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> >
{
  static const char* value()
  {
    return "81d98e1e20eab8beb4bd07beeba6a398";
  }

  static const char* value(const ::image_exposure_msgs::ExposureSequence_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x81d98e1e20eab8beULL;
  static const uint64_t static_value2 = 0xb4bd07beeba6a398ULL;
};

template<class ContainerAllocator>
struct DataType< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> >
{
  static const char* value()
  {
    return "image_exposure_msgs/ExposureSequence";
  }

  static const char* value(const ::image_exposure_msgs::ExposureSequence_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# exposure sequence (for mult-exposure HDR)\n\
Header header\n\
uint32[]  shutter    	     # Time duration (microseconds) the shutter was open.\n\
float32 gain                 # Gain (in dB) applied to the images in the sequence.\n\
uint16 white_balance_blue    # White balance in blue.\n\
uint16 white_balance_red     # White balance in red.\n\
\n\
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
";
  }

  static const char* value(const ::image_exposure_msgs::ExposureSequence_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.shutter);
      stream.next(m.gain);
      stream.next(m.white_balance_blue);
      stream.next(m.white_balance_red);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct ExposureSequence_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::image_exposure_msgs::ExposureSequence_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::image_exposure_msgs::ExposureSequence_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "shutter[]" << std::endl;
    for (size_t i = 0; i < v.shutter.size(); ++i)
    {
      s << indent << "  shutter[" << i << "]: ";
      Printer<uint32_t>::stream(s, indent + "  ", v.shutter[i]);
    }
    s << indent << "gain: ";
    Printer<float>::stream(s, indent + "  ", v.gain);
    s << indent << "white_balance_blue: ";
    Printer<uint16_t>::stream(s, indent + "  ", v.white_balance_blue);
    s << indent << "white_balance_red: ";
    Printer<uint16_t>::stream(s, indent + "  ", v.white_balance_red);
  }
};

} // namespace message_operations
} // namespace ros

#endif // IMAGE_EXPOSURE_MSGS_MESSAGE_EXPOSURESEQUENCE_H
