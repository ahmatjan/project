// Generated by gencpp from file control_msgs/FollowJointTrajectoryActionGoal.msg
// DO NOT EDIT!


#ifndef CONTROL_MSGS_MESSAGE_FOLLOWJOINTTRAJECTORYACTIONGOAL_H
#define CONTROL_MSGS_MESSAGE_FOLLOWJOINTTRAJECTORYACTIONGOAL_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>
#include <actionlib_msgs/GoalID.h>
#include <control_msgs/FollowJointTrajectoryGoal.h>

namespace control_msgs
{
template <class ContainerAllocator>
struct FollowJointTrajectoryActionGoal_
{
  typedef FollowJointTrajectoryActionGoal_<ContainerAllocator> Type;

  FollowJointTrajectoryActionGoal_()
    : header()
    , goal_id()
    , goal()  {
    }
  FollowJointTrajectoryActionGoal_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , goal_id(_alloc)
    , goal(_alloc)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef  ::actionlib_msgs::GoalID_<ContainerAllocator>  _goal_id_type;
  _goal_id_type goal_id;

   typedef  ::control_msgs::FollowJointTrajectoryGoal_<ContainerAllocator>  _goal_type;
  _goal_type goal;




  typedef boost::shared_ptr< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> const> ConstPtr;

}; // struct FollowJointTrajectoryActionGoal_

typedef ::control_msgs::FollowJointTrajectoryActionGoal_<std::allocator<void> > FollowJointTrajectoryActionGoal;

typedef boost::shared_ptr< ::control_msgs::FollowJointTrajectoryActionGoal > FollowJointTrajectoryActionGoalPtr;
typedef boost::shared_ptr< ::control_msgs::FollowJointTrajectoryActionGoal const> FollowJointTrajectoryActionGoalConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace control_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'std_msgs': ['/home/fengkaiwen/caros/ros/share/std_msgs/cmake/../msg'], 'geometry_msgs': ['/home/fengkaiwen/caros/ros/share/geometry_msgs/cmake/../msg'], 'actionlib_msgs': ['/home/fengkaiwen/caros/ros/share/actionlib_msgs/cmake/../msg'], 'trajectory_msgs': ['/home/fengkaiwen/caros/ros/share/trajectory_msgs/cmake/../msg'], 'control_msgs': ['/home/fengkaiwen/devel_isolated/control_msgs/share/control_msgs/msg', '/home/fengkaiwen/ros/control_msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "cff5c1d533bf2f82dd0138d57f4304bb";
  }

  static const char* value(const ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xcff5c1d533bf2f82ULL;
  static const uint64_t static_value2 = 0xdd0138d57f4304bbULL;
};

template<class ContainerAllocator>
struct DataType< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "control_msgs/FollowJointTrajectoryActionGoal";
  }

  static const char* value(const ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======\n\
\n\
Header header\n\
actionlib_msgs/GoalID goal_id\n\
FollowJointTrajectoryGoal goal\n\
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
MSG: actionlib_msgs/GoalID\n\
# The stamp should store the time at which this goal was requested.\n\
# It is used by an action server when it tries to preempt all\n\
# goals that were requested before a certain time\n\
time stamp\n\
\n\
# The id provides a way to associate feedback and\n\
# result message with specific goal requests. The id\n\
# specified must be unique.\n\
string id\n\
\n\
\n\
================================================================================\n\
MSG: control_msgs/FollowJointTrajectoryGoal\n\
# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======\n\
# The joint trajectory to follow\n\
trajectory_msgs/JointTrajectory trajectory\n\
\n\
# Tolerances for the trajectory.  If the measured joint values fall\n\
# outside the tolerances the trajectory goal is aborted.  Any\n\
# tolerances that are not specified (by being omitted or set to 0) are\n\
# set to the defaults for the action server (often taken from the\n\
# parameter server).\n\
\n\
# Tolerances applied to the joints as the trajectory is executed.  If\n\
# violated, the goal aborts with error_code set to\n\
# PATH_TOLERANCE_VIOLATED.\n\
JointTolerance[] path_tolerance\n\
\n\
# To report success, the joints must be within goal_tolerance of the\n\
# final trajectory value.  The goal must be achieved by time the\n\
# trajectory ends plus goal_time_tolerance.  (goal_time_tolerance\n\
# allows some leeway in time, so that the trajectory goal can still\n\
# succeed even if the joints reach the goal some time after the\n\
# precise end time of the trajectory).\n\
#\n\
# If the joints are not within goal_tolerance after \"trajectory finish\n\
# time\" + goal_time_tolerance, the goal aborts with error_code set to\n\
# GOAL_TOLERANCE_VIOLATED\n\
JointTolerance[] goal_tolerance\n\
duration goal_time_tolerance\n\
\n\
\n\
================================================================================\n\
MSG: trajectory_msgs/JointTrajectory\n\
Header header\n\
string[] joint_names\n\
JointTrajectoryPoint[] points\n\
================================================================================\n\
MSG: trajectory_msgs/JointTrajectoryPoint\n\
# Each trajectory point specifies either positions[, velocities[, accelerations]]\n\
# or positions[, effort] for the trajectory to be executed.\n\
# All specified values are in the same order as the joint names in JointTrajectory.msg\n\
\n\
float64[] positions\n\
float64[] velocities\n\
float64[] accelerations\n\
float64[] effort\n\
duration time_from_start\n\
\n\
================================================================================\n\
MSG: control_msgs/JointTolerance\n\
# The tolerances specify the amount the position, velocity, and\n\
# accelerations can vary from the setpoints.  For example, in the case\n\
# of trajectory control, when the actual position varies beyond\n\
# (desired position + position tolerance), the trajectory goal may\n\
# abort.\n\
# \n\
# There are two special values for tolerances:\n\
#  * 0 - The tolerance is unspecified and will remain at whatever the default is\n\
#  * -1 - The tolerance is \"erased\".  If there was a default, the joint will be\n\
#         allowed to move without restriction.\n\
\n\
string name\n\
float64 position  # in radians or meters (for a revolute or prismatic joint, respectively)\n\
float64 velocity  # in rad/sec or m/sec\n\
float64 acceleration  # in rad/sec^2 or m/sec^2\n\
";
  }

  static const char* value(const ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.goal_id);
      stream.next(m.goal);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct FollowJointTrajectoryActionGoal_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::control_msgs::FollowJointTrajectoryActionGoal_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "goal_id: ";
    s << std::endl;
    Printer< ::actionlib_msgs::GoalID_<ContainerAllocator> >::stream(s, indent + "  ", v.goal_id);
    s << indent << "goal: ";
    s << std::endl;
    Printer< ::control_msgs::FollowJointTrajectoryGoal_<ContainerAllocator> >::stream(s, indent + "  ", v.goal);
  }
};

} // namespace message_operations
} // namespace ros

#endif // CONTROL_MSGS_MESSAGE_FOLLOWJOINTTRAJECTORYACTIONGOAL_H
