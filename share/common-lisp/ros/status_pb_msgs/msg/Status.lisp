; Auto-generated. Do not edit!


(cl:in-package status_pb_msgs-msg)


;//! \htmlinclude Status.msg.html

(cl:defclass <Status> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type header_pb_msgs-msg:Header
    :initform (cl:make-instance 'header_pb_msgs-msg:Header))
   (chassis
    :reader chassis
    :initarg :chassis
    :type status_pb_msgs-msg:Chassis
    :initform (cl:make-instance 'status_pb_msgs-msg:Chassis))
   (pose
    :reader pose
    :initarg :pose
    :type localization_pb_msgs-msg:Pose
    :initform (cl:make-instance 'localization_pb_msgs-msg:Pose)))
)

(cl:defclass Status (<Status>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Status>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Status)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name status_pb_msgs-msg:<Status> is deprecated: use status_pb_msgs-msg:Status instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:header-val is deprecated.  Use status_pb_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'chassis-val :lambda-list '(m))
(cl:defmethod chassis-val ((m <Status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:chassis-val is deprecated.  Use status_pb_msgs-msg:chassis instead.")
  (chassis m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <Status>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:pose-val is deprecated.  Use status_pb_msgs-msg:pose instead.")
  (pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Status>) ostream)
  "Serializes a message object of type '<Status>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'chassis) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Status>) istream)
  "Deserializes a message object of type '<Status>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'chassis) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Status>)))
  "Returns string type for a message object of type '<Status>"
  "status_pb_msgs/Status")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Status)))
  "Returns string type for a message object of type 'Status"
  "status_pb_msgs/Status")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Status>)))
  "Returns md5sum for a message object of type '<Status>"
  "c108e7cdb5158d560070b2d84145e09b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Status)))
  "Returns md5sum for a message object of type 'Status"
  "c108e7cdb5158d560070b2d84145e09b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Status>)))
  "Returns full string definition for message of type '<Status>"
  (cl:format cl:nil "header_pb_msgs/Header header ~%Chassis chassis ~%localization_pb_msgs/Pose pose ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: status_pb_msgs/Chassis~%int32 driving_mode ~%int32 error_code ~%bool engine_started ~%float32 engine_rpm ~%float32 speed_mps ~%float32 odometer_m ~%int32 fuel_range_m ~%float32 throttle_percentage ~%float32 brake_percentage ~%int32 gear_location ~%float32 steering_percentage ~%float32 steering_torque_nm ~%bool parking_brake ~%bool high_beam_signal ~%bool low_beam_signal ~%bool left_turn_signal ~%bool right_turn_signal ~%bool horn ~%bool wiper ~%~%================================================================================~%MSG: localization_pb_msgs/Pose~%common_pb_msgs/PointENU position ~%common_pb_msgs/Quaternion orientation ~%common_pb_msgs/Point3D linear_velocity ~%common_pb_msgs/Point3D linear_acceleration ~%common_pb_msgs/Point3D angular_velocity ~%~%================================================================================~%MSG: common_pb_msgs/PointENU~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: common_pb_msgs/Quaternion~%float64 qx ~%float64 qy ~%float64 qz ~%float64 qw ~%~%================================================================================~%MSG: common_pb_msgs/Point3D~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Status)))
  "Returns full string definition for message of type 'Status"
  (cl:format cl:nil "header_pb_msgs/Header header ~%Chassis chassis ~%localization_pb_msgs/Pose pose ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: status_pb_msgs/Chassis~%int32 driving_mode ~%int32 error_code ~%bool engine_started ~%float32 engine_rpm ~%float32 speed_mps ~%float32 odometer_m ~%int32 fuel_range_m ~%float32 throttle_percentage ~%float32 brake_percentage ~%int32 gear_location ~%float32 steering_percentage ~%float32 steering_torque_nm ~%bool parking_brake ~%bool high_beam_signal ~%bool low_beam_signal ~%bool left_turn_signal ~%bool right_turn_signal ~%bool horn ~%bool wiper ~%~%================================================================================~%MSG: localization_pb_msgs/Pose~%common_pb_msgs/PointENU position ~%common_pb_msgs/Quaternion orientation ~%common_pb_msgs/Point3D linear_velocity ~%common_pb_msgs/Point3D linear_acceleration ~%common_pb_msgs/Point3D angular_velocity ~%~%================================================================================~%MSG: common_pb_msgs/PointENU~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: common_pb_msgs/Quaternion~%float64 qx ~%float64 qy ~%float64 qz ~%float64 qw ~%~%================================================================================~%MSG: common_pb_msgs/Point3D~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Status>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'chassis))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Status>))
  "Converts a ROS message object to a list"
  (cl:list 'Status
    (cl:cons ':header (header msg))
    (cl:cons ':chassis (chassis msg))
    (cl:cons ':pose (pose msg))
))
