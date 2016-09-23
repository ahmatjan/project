; Auto-generated. Do not edit!


(cl:in-package localization_pb_msgs-msg)


;//! \htmlinclude Uncertainty.msg.html

(cl:defclass <Uncertainty> (roslisp-msg-protocol:ros-message)
  ((position_std_dev
    :reader position_std_dev
    :initarg :position_std_dev
    :type common_pb_msgs-msg:Point3D
    :initform (cl:make-instance 'common_pb_msgs-msg:Point3D))
   (orientation_std_dev
    :reader orientation_std_dev
    :initarg :orientation_std_dev
    :type common_pb_msgs-msg:Point3D
    :initform (cl:make-instance 'common_pb_msgs-msg:Point3D))
   (linear_velocity_std_dev
    :reader linear_velocity_std_dev
    :initarg :linear_velocity_std_dev
    :type common_pb_msgs-msg:Point3D
    :initform (cl:make-instance 'common_pb_msgs-msg:Point3D))
   (linear_acceleration_std_dev
    :reader linear_acceleration_std_dev
    :initarg :linear_acceleration_std_dev
    :type common_pb_msgs-msg:Point3D
    :initform (cl:make-instance 'common_pb_msgs-msg:Point3D))
   (angular_velocity_std_dev
    :reader angular_velocity_std_dev
    :initarg :angular_velocity_std_dev
    :type common_pb_msgs-msg:Point3D
    :initform (cl:make-instance 'common_pb_msgs-msg:Point3D)))
)

(cl:defclass Uncertainty (<Uncertainty>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Uncertainty>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Uncertainty)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name localization_pb_msgs-msg:<Uncertainty> is deprecated: use localization_pb_msgs-msg:Uncertainty instead.")))

(cl:ensure-generic-function 'position_std_dev-val :lambda-list '(m))
(cl:defmethod position_std_dev-val ((m <Uncertainty>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:position_std_dev-val is deprecated.  Use localization_pb_msgs-msg:position_std_dev instead.")
  (position_std_dev m))

(cl:ensure-generic-function 'orientation_std_dev-val :lambda-list '(m))
(cl:defmethod orientation_std_dev-val ((m <Uncertainty>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:orientation_std_dev-val is deprecated.  Use localization_pb_msgs-msg:orientation_std_dev instead.")
  (orientation_std_dev m))

(cl:ensure-generic-function 'linear_velocity_std_dev-val :lambda-list '(m))
(cl:defmethod linear_velocity_std_dev-val ((m <Uncertainty>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:linear_velocity_std_dev-val is deprecated.  Use localization_pb_msgs-msg:linear_velocity_std_dev instead.")
  (linear_velocity_std_dev m))

(cl:ensure-generic-function 'linear_acceleration_std_dev-val :lambda-list '(m))
(cl:defmethod linear_acceleration_std_dev-val ((m <Uncertainty>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:linear_acceleration_std_dev-val is deprecated.  Use localization_pb_msgs-msg:linear_acceleration_std_dev instead.")
  (linear_acceleration_std_dev m))

(cl:ensure-generic-function 'angular_velocity_std_dev-val :lambda-list '(m))
(cl:defmethod angular_velocity_std_dev-val ((m <Uncertainty>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader localization_pb_msgs-msg:angular_velocity_std_dev-val is deprecated.  Use localization_pb_msgs-msg:angular_velocity_std_dev instead.")
  (angular_velocity_std_dev m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Uncertainty>) ostream)
  "Serializes a message object of type '<Uncertainty>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position_std_dev) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'orientation_std_dev) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'linear_velocity_std_dev) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'linear_acceleration_std_dev) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'angular_velocity_std_dev) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Uncertainty>) istream)
  "Deserializes a message object of type '<Uncertainty>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position_std_dev) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'orientation_std_dev) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'linear_velocity_std_dev) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'linear_acceleration_std_dev) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'angular_velocity_std_dev) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Uncertainty>)))
  "Returns string type for a message object of type '<Uncertainty>"
  "localization_pb_msgs/Uncertainty")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Uncertainty)))
  "Returns string type for a message object of type 'Uncertainty"
  "localization_pb_msgs/Uncertainty")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Uncertainty>)))
  "Returns md5sum for a message object of type '<Uncertainty>"
  "0a26c653df4736501b569f3e3f7250e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Uncertainty)))
  "Returns md5sum for a message object of type 'Uncertainty"
  "0a26c653df4736501b569f3e3f7250e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Uncertainty>)))
  "Returns full string definition for message of type '<Uncertainty>"
  (cl:format cl:nil "common_pb_msgs/Point3D position_std_dev ~%common_pb_msgs/Point3D orientation_std_dev ~%common_pb_msgs/Point3D linear_velocity_std_dev ~%common_pb_msgs/Point3D linear_acceleration_std_dev ~%common_pb_msgs/Point3D angular_velocity_std_dev ~%~%================================================================================~%MSG: common_pb_msgs/Point3D~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Uncertainty)))
  "Returns full string definition for message of type 'Uncertainty"
  (cl:format cl:nil "common_pb_msgs/Point3D position_std_dev ~%common_pb_msgs/Point3D orientation_std_dev ~%common_pb_msgs/Point3D linear_velocity_std_dev ~%common_pb_msgs/Point3D linear_acceleration_std_dev ~%common_pb_msgs/Point3D angular_velocity_std_dev ~%~%================================================================================~%MSG: common_pb_msgs/Point3D~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Uncertainty>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position_std_dev))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'orientation_std_dev))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'linear_velocity_std_dev))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'linear_acceleration_std_dev))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'angular_velocity_std_dev))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Uncertainty>))
  "Converts a ROS message object to a list"
  (cl:list 'Uncertainty
    (cl:cons ':position_std_dev (position_std_dev msg))
    (cl:cons ':orientation_std_dev (orientation_std_dev msg))
    (cl:cons ':linear_velocity_std_dev (linear_velocity_std_dev msg))
    (cl:cons ':linear_acceleration_std_dev (linear_acceleration_std_dev msg))
    (cl:cons ':angular_velocity_std_dev (angular_velocity_std_dev msg))
))
