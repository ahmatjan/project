; Auto-generated. Do not edit!


(cl:in-package localization_pb_msgs-msg)


;//! \htmlinclude LocalizationEstimate.msg.html

(cl:defclass <LocalizationEstimate> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type header_pb_msgs-msg:Header
    :initform (cl:make-instance 'header_pb_msgs-msg:Header))
   (pose
    :reader pose
    :initarg :pose
    :type localization_pb_msgs-msg:Pose
    :initform (cl:make-instance 'localization_pb_msgs-msg:Pose))
   (uncertainty
    :reader uncertainty
    :initarg :uncertainty
    :type localization_pb_msgs-msg:Uncertainty
    :initform (cl:make-instance 'localization_pb_msgs-msg:Uncertainty)))
)

(cl:defclass LocalizationEstimate (<LocalizationEstimate>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LocalizationEstimate>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LocalizationEstimate)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name localization_pb_msgs-msg:<LocalizationEstimate> is deprecated: use localization_pb_msgs-msg:LocalizationEstimate instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <LocalizationEstimate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:header-val is deprecated.  Use localization_pb_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <LocalizationEstimate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:pose-val is deprecated.  Use localization_pb_msgs-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'uncertainty-val :lambda-list '(m))
(cl:defmethod uncertainty-val ((m <LocalizationEstimate>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:uncertainty-val is deprecated.  Use localization_pb_msgs-msg:uncertainty instead.")
  (uncertainty m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LocalizationEstimate>) ostream)
  "Serializes a message object of type '<LocalizationEstimate>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'uncertainty) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LocalizationEstimate>) istream)
  "Deserializes a message object of type '<LocalizationEstimate>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'uncertainty) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LocalizationEstimate>)))
  "Returns string type for a message object of type '<LocalizationEstimate>"
  "localization_pb_msgs/LocalizationEstimate")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LocalizationEstimate)))
  "Returns string type for a message object of type 'LocalizationEstimate"
  "localization_pb_msgs/LocalizationEstimate")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LocalizationEstimate>)))
  "Returns md5sum for a message object of type '<LocalizationEstimate>"
  "331f9aef126565b5687e341f8a2fb5c0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LocalizationEstimate)))
  "Returns md5sum for a message object of type 'LocalizationEstimate"
  "331f9aef126565b5687e341f8a2fb5c0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LocalizationEstimate>)))
  "Returns full string definition for message of type '<LocalizationEstimate>"
  (cl:format cl:nil "header_pb_msgs/Header header ~%Pose pose ~%Uncertainty uncertainty ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: localization_pb_msgs/Pose~%common_pb_msgs/PointENU position ~%common_pb_msgs/Quaternion orientation ~%common_pb_msgs/Point3D linear_velocity ~%common_pb_msgs/Point3D linear_acceleration ~%common_pb_msgs/Point3D angular_velocity ~%~%================================================================================~%MSG: common_pb_msgs/PointENU~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: common_pb_msgs/Quaternion~%float64 qx ~%float64 qy ~%float64 qz ~%float64 qw ~%~%================================================================================~%MSG: common_pb_msgs/Point3D~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: localization_pb_msgs/Uncertainty~%common_pb_msgs/Point3D position_std_dev ~%common_pb_msgs/Point3D orientation_std_dev ~%common_pb_msgs/Point3D linear_velocity_std_dev ~%common_pb_msgs/Point3D linear_acceleration_std_dev ~%common_pb_msgs/Point3D angular_velocity_std_dev ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LocalizationEstimate)))
  "Returns full string definition for message of type 'LocalizationEstimate"
  (cl:format cl:nil "header_pb_msgs/Header header ~%Pose pose ~%Uncertainty uncertainty ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: localization_pb_msgs/Pose~%common_pb_msgs/PointENU position ~%common_pb_msgs/Quaternion orientation ~%common_pb_msgs/Point3D linear_velocity ~%common_pb_msgs/Point3D linear_acceleration ~%common_pb_msgs/Point3D angular_velocity ~%~%================================================================================~%MSG: common_pb_msgs/PointENU~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: common_pb_msgs/Quaternion~%float64 qx ~%float64 qy ~%float64 qz ~%float64 qw ~%~%================================================================================~%MSG: common_pb_msgs/Point3D~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: localization_pb_msgs/Uncertainty~%common_pb_msgs/Point3D position_std_dev ~%common_pb_msgs/Point3D orientation_std_dev ~%common_pb_msgs/Point3D linear_velocity_std_dev ~%common_pb_msgs/Point3D linear_acceleration_std_dev ~%common_pb_msgs/Point3D angular_velocity_std_dev ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LocalizationEstimate>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'uncertainty))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LocalizationEstimate>))
  "Converts a ROS message object to a list"
  (cl:list 'LocalizationEstimate
    (cl:cons ':header (header msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':uncertainty (uncertainty msg))
))
