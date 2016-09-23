; Auto-generated. Do not edit!


(cl:in-package localization_pb_msgs-msg)


;//! \htmlinclude Pose.msg.html

(cl:defclass <Pose> (roslisp-msg-protocol:ros-message)
  ((position
    :reader position
    :initarg :position
    :type common_pb_msgs-msg:PointENU
    :initform (cl:make-instance 'common_pb_msgs-msg:PointENU))
   (orientation
    :reader orientation
    :initarg :orientation
    :type common_pb_msgs-msg:Quaternion
    :initform (cl:make-instance 'common_pb_msgs-msg:Quaternion))
   (linear_velocity
    :reader linear_velocity
    :initarg :linear_velocity
    :type common_pb_msgs-msg:Point3D
    :initform (cl:make-instance 'common_pb_msgs-msg:Point3D))
   (linear_acceleration
    :reader linear_acceleration
    :initarg :linear_acceleration
    :type common_pb_msgs-msg:Point3D
    :initform (cl:make-instance 'common_pb_msgs-msg:Point3D))
   (angular_velocity
    :reader angular_velocity
    :initarg :angular_velocity
    :type common_pb_msgs-msg:Point3D
    :initform (cl:make-instance 'common_pb_msgs-msg:Point3D)))
)

(cl:defclass Pose (<Pose>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Pose>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Pose)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name localization_pb_msgs-msg:<Pose> is deprecated: use localization_pb_msgs-msg:Pose instead.")))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <Pose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:position-val is deprecated.  Use localization_pb_msgs-msg:position instead.")
  (position m))

(cl:ensure-generic-function 'orientation-val :lambda-list '(m))
(cl:defmethod orientation-val ((m <Pose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:orientation-val is deprecated.  Use localization_pb_msgs-msg:orientation instead.")
  (orientation m))

(cl:ensure-generic-function 'linear_velocity-val :lambda-list '(m))
(cl:defmethod linear_velocity-val ((m <Pose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:linear_velocity-val is deprecated.  Use localization_pb_msgs-msg:linear_velocity instead.")
  (linear_velocity m))

(cl:ensure-generic-function 'linear_acceleration-val :lambda-list '(m))
(cl:defmethod linear_acceleration-val ((m <Pose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:linear_acceleration-val is deprecated.  Use localization_pb_msgs-msg:linear_acceleration instead.")
  (linear_acceleration m))

(cl:ensure-generic-function 'angular_velocity-val :lambda-list '(m))
(cl:defmethod angular_velocity-val ((m <Pose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:angular_velocity-val is deprecated.  Use localization_pb_msgs-msg:angular_velocity instead.")
  (angular_velocity m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Pose>) ostream)
  "Serializes a message object of type '<Pose>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orientation) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'linear_velocity) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'linear_acceleration) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'angular_velocity) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Pose>) istream)
  "Deserializes a message object of type '<Pose>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orientation) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'linear_velocity) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'linear_acceleration) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'angular_velocity) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Pose>)))
  "Returns string type for a message object of type '<Pose>"
  "localization_pb_msgs/Pose")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Pose)))
  "Returns string type for a message object of type 'Pose"
  "localization_pb_msgs/Pose")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Pose>)))
  "Returns md5sum for a message object of type '<Pose>"
  "6473db1f9b1c6e38aeea3975309b5993")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Pose)))
  "Returns md5sum for a message object of type 'Pose"
  "6473db1f9b1c6e38aeea3975309b5993")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Pose>)))
  "Returns full string definition for message of type '<Pose>"
  (cl:format cl:nil "common_pb_msgs/PointENU position ~%common_pb_msgs/Quaternion orientation ~%common_pb_msgs/Point3D linear_velocity ~%common_pb_msgs/Point3D linear_acceleration ~%common_pb_msgs/Point3D angular_velocity ~%~%================================================================================~%MSG: common_pb_msgs/PointENU~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: common_pb_msgs/Quaternion~%float64 qx ~%float64 qy ~%float64 qz ~%float64 qw ~%~%================================================================================~%MSG: common_pb_msgs/Point3D~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Pose)))
  "Returns full string definition for message of type 'Pose"
  (cl:format cl:nil "common_pb_msgs/PointENU position ~%common_pb_msgs/Quaternion orientation ~%common_pb_msgs/Point3D linear_velocity ~%common_pb_msgs/Point3D linear_acceleration ~%common_pb_msgs/Point3D angular_velocity ~%~%================================================================================~%MSG: common_pb_msgs/PointENU~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: common_pb_msgs/Quaternion~%float64 qx ~%float64 qy ~%float64 qz ~%float64 qw ~%~%================================================================================~%MSG: common_pb_msgs/Point3D~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Pose>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orientation))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'linear_velocity))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'linear_acceleration))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'angular_velocity))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Pose>))
  "Converts a ROS message object to a list"
  (cl:list 'Pose
    (cl:cons ':position (position msg))
    (cl:cons ':orientation (orientation msg))
    (cl:cons ':linear_velocity (linear_velocity msg))
    (cl:cons ':linear_acceleration (linear_acceleration msg))
    (cl:cons ':angular_velocity (angular_velocity msg))
))
