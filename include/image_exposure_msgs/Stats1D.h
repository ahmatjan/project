// Generated by gencpp from file image_exposure_msgs/Stats1D.msg
// DO NOT EDIT!


#ifndef IMAGE_EXPOSURE_MSGS_MESSAGE_STATS1D_H
#define IMAGE_EXPOSURE_MSGS_MESSAGE_STATS1D_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace image_exposure_msgs
{
template <class ContainerAllocator>
struct Stats1D_
{
  typedef Stats1D_<ContainerAllocator> Type;

  Stats1D_()
    : min(0.0)
    , max(0.0)
    , mean(0.0)
    , variance(0.0)
    , N(0)  {
    }
  Stats1D_(const ContainerAllocator& _alloc)
    : min(0.0)
    , max(0.0)
    , mean(0.0)
    , variance(0.0)
    , N(0)  {
  (void)_alloc;
    }



   typedef double _min_type;
  _min_type min;

   typedef double _max_type;
  _max_type max;

   typedef double _mean_type;
  _mean_type mean;

   typedef double _variance_type;
  _variance_type variance;

   typedef int64_t _N_type;
  _N_type N;




  typedef boost::shared_ptr< ::image_exposure_msgs::Stats1D_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::image_exposure_msgs::Stats1D_<ContainerAllocator> const> ConstPtr;

}; // struct Stats1D_

typedef ::image_exposure_msgs::Stats1D_<std::allocator<void> > Stats1D;

typedef boost::shared_ptr< ::image_exposure_msgs::Stats1D > Stats1DPtr;
typedef boost::shared_ptr< ::image_exposure_msgs::Stats1D const> Stats1DConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::image_exposure_msgs::Stats1D_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::image_exposure_msgs::Stats1D_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace image_exposure_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'image_exposure_msgs': ['/home/scmbuild/workspaces_cluster/baidu.car-os.ros/baidu/car-os/ros/drivers/src/car_ros_drivers/pointgrey_camera_3rd/image_exposure_msgs/msg'], 'std_msgs': ['/home/caros/ros/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::image_exposure_msgs::Stats1D_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::image_exposure_msgs::Stats1D_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::image_exposure_msgs::Stats1D_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::image_exposure_msgs::Stats1D_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::image_exposure_msgs::Stats1D_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::image_exposure_msgs::Stats1D_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::image_exposure_msgs::Stats1D_<ContainerAllocator> >
{
  static const char* value()
  {
    return "5e29efbcd70d63a82b5ddfac24a5bc4b";
  }

  static const char* value(const ::image_exposure_msgs::Stats1D_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x5e29efbcd70d63a8ULL;
  static const uint64_t static_value2 = 0x2b5ddfac24a5bc4bULL;
};

template<class ContainerAllocator>
struct DataType< ::image_exposure_msgs::Stats1D_<ContainerAllocator> >
{
  static const char* value()
  {
    return "image_exposure_msgs/Stats1D";
  }

  static const char* value(const ::image_exposure_msgs::Stats1D_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::image_exposure_msgs::Stats1D_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# statistics of a 1-D distribution\n\
float64 min\n\
float64 max\n\
float64 mean\n\
float64 variance\n\
int64 N\n\
";
  }

  static const char* value(const ::image_exposure_msgs::Stats1D_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::image_exposure_msgs::Stats1D_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.min);
      stream.next(m.max);
      stream.next(m.mean);
      stream.next(m.variance);
      stream.next(m.N);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct Stats1D_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::image_exposure_msgs::Stats1D_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::image_exposure_msgs::Stats1D_<ContainerAllocator>& v)
  {
    s << indent << "min: ";
    Printer<double>::stream(s, indent + "  ", v.min);
    s << indent << "max: ";
    Printer<double>::stream(s, indent + "  ", v.max);
    s << indent << "mean: ";
    Printer<double>::stream(s, indent + "  ", v.mean);
    s << indent << "variance: ";
    Printer<double>::stream(s, indent + "  ", v.variance);
    s << indent << "N: ";
    Printer<int64_t>::stream(s, indent + "  ", v.N);
  }
};

} // namespace message_operations
} // namespace ros

#endif // IMAGE_EXPOSURE_MSGS_MESSAGE_STATS1D_H
