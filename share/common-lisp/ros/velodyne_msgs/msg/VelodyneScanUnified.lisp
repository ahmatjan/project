; Auto-generated. Do not edit!


(cl:in-package velodyne_msgs-msg)


;//! \htmlinclude VelodyneScanUnified.msg.html

(cl:defclass <VelodyneScanUnified> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (basetime
    :reader basetime
    :initarg :basetime
    :type cl:integer
    :initform 0)
   (packets
    :reader packets
    :initarg :packets
    :type (cl:vector velodyne_msgs-msg:VelodynePacket)
   :initform (cl:make-array 0 :element-type 'velodyne_msgs-msg:VelodynePacket :initial-element (cl:make-instance 'velodyne_msgs-msg:VelodynePacket))))
)

(cl:defclass VelodyneScanUnified (<VelodyneScanUnified>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VelodyneScanUnified>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VelodyneScanUnified)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name velodyne_msgs-msg:<VelodyneScanUnified> is deprecated: use velodyne_msgs-msg:VelodyneScanUnified instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <VelodyneScanUnified>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader velodyne_msgs-msg:header-val is deprecated.  Use velodyne_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'basetime-val :lambda-list '(m))
(cl:defmethod basetime-val ((m <VelodyneScanUnified>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader velodyne_msgs-msg:basetime-val is deprecated.  Use velodyne_msgs-msg:basetime instead.")
  (basetime m))

(cl:ensure-generic-function 'packets-val :lambda-list '(m))
(cl:defmethod packets-val ((m <VelodyneScanUnified>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader velodyne_msgs-msg:packets-val is deprecated.  Use velodyne_msgs-msg:packets instead.")
  (packets m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VelodyneScanUnified>) ostream)
  "Serializes a message object of type '<VelodyneScanUnified>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'basetime)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'basetime)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'basetime)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'basetime)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'basetime)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'basetime)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'basetime)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'basetime)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'packets))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'packets))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VelodyneScanUnified>) istream)
  "Deserializes a message object of type '<VelodyneScanUnified>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'basetime)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'basetime)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'basetime)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'basetime)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'basetime)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'basetime)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'basetime)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'basetime)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'packets) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'packets)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'velodyne_msgs-msg:VelodynePacket))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VelodyneScanUnified>)))
  "Returns string type for a message object of type '<VelodyneScanUnified>"
  "velodyne_msgs/VelodyneScanUnified")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VelodyneScanUnified)))
  "Returns string type for a message object of type 'VelodyneScanUnified"
  "velodyne_msgs/VelodyneScanUnified")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VelodyneScanUnified>)))
  "Returns md5sum for a message object of type '<VelodyneScanUnified>"
  "a02f26cda99b9e0189aac08ed1065a71")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VelodyneScanUnified)))
  "Returns md5sum for a message object of type 'VelodyneScanUnified"
  "a02f26cda99b9e0189aac08ed1065a71")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VelodyneScanUnified>)))
  "Returns full string definition for message of type '<VelodyneScanUnified>"
  (cl:format cl:nil "#velodyne lidar scan packets~%~%Header           header         #standard ros message header~%uint64          basetime       #time to the top of hour~%VelodynePacket[] packets        #vector of raw packets~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: velodyne_msgs/VelodynePacket~%#old velodyne lidar packet~%~%time stamp          #packet timestamp~%uint8[1206] data    #packet contents~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VelodyneScanUnified)))
  "Returns full string definition for message of type 'VelodyneScanUnified"
  (cl:format cl:nil "#velodyne lidar scan packets~%~%Header           header         #standard ros message header~%uint64          basetime       #time to the top of hour~%VelodynePacket[] packets        #vector of raw packets~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: velodyne_msgs/VelodynePacket~%#old velodyne lidar packet~%~%time stamp          #packet timestamp~%uint8[1206] data    #packet contents~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VelodyneScanUnified>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'packets) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VelodyneScanUnified>))
  "Converts a ROS message object to a list"
  (cl:list 'VelodyneScanUnified
    (cl:cons ':header (header msg))
    (cl:cons ':basetime (basetime msg))
    (cl:cons ':packets (packets msg))
))
