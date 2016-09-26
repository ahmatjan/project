; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude ObjectOverlapInfo.msg.html

(cl:defclass <ObjectOverlapInfo> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type hdmap_pb_msgs-msg:Id
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Id))
   (lane_overlap_info
    :reader lane_overlap_info
    :initarg :lane_overlap_info
    :type hdmap_pb_msgs-msg:LaneOverlapInfo
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:LaneOverlapInfo))
   (signal_overlap_info
    :reader signal_overlap_info
    :initarg :signal_overlap_info
    :type hdmap_pb_msgs-msg:SignalOverlapInfo
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:SignalOverlapInfo))
   (stop_sign_overlap_info
    :reader stop_sign_overlap_info
    :initarg :stop_sign_overlap_info
    :type hdmap_pb_msgs-msg:StopSignOverlapInfo
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:StopSignOverlapInfo))
   (crosswalk_overlap_info
    :reader crosswalk_overlap_info
    :initarg :crosswalk_overlap_info
    :type hdmap_pb_msgs-msg:CrosswalkOverlapInfo
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:CrosswalkOverlapInfo))
   (junction_overlap_info
    :reader junction_overlap_info
    :initarg :junction_overlap_info
    :type hdmap_pb_msgs-msg:JunctionOverlapInfo
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:JunctionOverlapInfo)))
)

(cl:defclass ObjectOverlapInfo (<ObjectOverlapInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectOverlapInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectOverlapInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<ObjectOverlapInfo> is deprecated: use hdmap_pb_msgs-msg:ObjectOverlapInfo instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <ObjectOverlapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:id-val is deprecated.  Use hdmap_pb_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'lane_overlap_info-val :lambda-list '(m))
(cl:defmethod lane_overlap_info-val ((m <ObjectOverlapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:lane_overlap_info-val is deprecated.  Use hdmap_pb_msgs-msg:lane_overlap_info instead.")
  (lane_overlap_info m))

(cl:ensure-generic-function 'signal_overlap_info-val :lambda-list '(m))
(cl:defmethod signal_overlap_info-val ((m <ObjectOverlapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:signal_overlap_info-val is deprecated.  Use hdmap_pb_msgs-msg:signal_overlap_info instead.")
  (signal_overlap_info m))

(cl:ensure-generic-function 'stop_sign_overlap_info-val :lambda-list '(m))
(cl:defmethod stop_sign_overlap_info-val ((m <ObjectOverlapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:stop_sign_overlap_info-val is deprecated.  Use hdmap_pb_msgs-msg:stop_sign_overlap_info instead.")
  (stop_sign_overlap_info m))

(cl:ensure-generic-function 'crosswalk_overlap_info-val :lambda-list '(m))
(cl:defmethod crosswalk_overlap_info-val ((m <ObjectOverlapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:crosswalk_overlap_info-val is deprecated.  Use hdmap_pb_msgs-msg:crosswalk_overlap_info instead.")
  (crosswalk_overlap_info m))

(cl:ensure-generic-function 'junction_overlap_info-val :lambda-list '(m))
(cl:defmethod junction_overlap_info-val ((m <ObjectOverlapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:junction_overlap_info-val is deprecated.  Use hdmap_pb_msgs-msg:junction_overlap_info instead.")
  (junction_overlap_info m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectOverlapInfo>) ostream)
  "Serializes a message object of type '<ObjectOverlapInfo>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'id) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'lane_overlap_info) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'signal_overlap_info) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'stop_sign_overlap_info) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'crosswalk_overlap_info) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'junction_overlap_info) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectOverlapInfo>) istream)
  "Deserializes a message object of type '<ObjectOverlapInfo>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'id) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'lane_overlap_info) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'signal_overlap_info) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'stop_sign_overlap_info) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'crosswalk_overlap_info) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'junction_overlap_info) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectOverlapInfo>)))
  "Returns string type for a message object of type '<ObjectOverlapInfo>"
  "hdmap_pb_msgs/ObjectOverlapInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectOverlapInfo)))
  "Returns string type for a message object of type 'ObjectOverlapInfo"
  "hdmap_pb_msgs/ObjectOverlapInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectOverlapInfo>)))
  "Returns md5sum for a message object of type '<ObjectOverlapInfo>"
  "839259b89c01b1fa42a46936f1b66d54")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectOverlapInfo)))
  "Returns md5sum for a message object of type 'ObjectOverlapInfo"
  "839259b89c01b1fa42a46936f1b66d54")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectOverlapInfo>)))
  "Returns full string definition for message of type '<ObjectOverlapInfo>"
  (cl:format cl:nil "Id id ~%LaneOverlapInfo lane_overlap_info ~%SignalOverlapInfo signal_overlap_info ~%StopSignOverlapInfo stop_sign_overlap_info ~%CrosswalkOverlapInfo crosswalk_overlap_info ~%JunctionOverlapInfo junction_overlap_info ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/LaneOverlapInfo~%float64 start_s ~%float64 end_s ~%bool is_merge ~%bool has_precedence ~%~%================================================================================~%MSG: hdmap_pb_msgs/SignalOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/StopSignOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/CrosswalkOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/JunctionOverlapInfo~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectOverlapInfo)))
  "Returns full string definition for message of type 'ObjectOverlapInfo"
  (cl:format cl:nil "Id id ~%LaneOverlapInfo lane_overlap_info ~%SignalOverlapInfo signal_overlap_info ~%StopSignOverlapInfo stop_sign_overlap_info ~%CrosswalkOverlapInfo crosswalk_overlap_info ~%JunctionOverlapInfo junction_overlap_info ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/LaneOverlapInfo~%float64 start_s ~%float64 end_s ~%bool is_merge ~%bool has_precedence ~%~%================================================================================~%MSG: hdmap_pb_msgs/SignalOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/StopSignOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/CrosswalkOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/JunctionOverlapInfo~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectOverlapInfo>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'id))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'lane_overlap_info))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'signal_overlap_info))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'stop_sign_overlap_info))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'crosswalk_overlap_info))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'junction_overlap_info))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectOverlapInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectOverlapInfo
    (cl:cons ':id (id msg))
    (cl:cons ':lane_overlap_info (lane_overlap_info msg))
    (cl:cons ':signal_overlap_info (signal_overlap_info msg))
    (cl:cons ':stop_sign_overlap_info (stop_sign_overlap_info msg))
    (cl:cons ':crosswalk_overlap_info (crosswalk_overlap_info msg))
    (cl:cons ':junction_overlap_info (junction_overlap_info msg))
))
