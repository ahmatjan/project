; Auto-generated. Do not edit!


(cl:in-package routing_pb_msgs-msg)


;//! \htmlinclude LaneWaypoint.msg.html

(cl:defclass <LaneWaypoint> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:string
    :initform "")
   (s
    :reader s
    :initarg :s
    :type cl:float
    :initform 0.0)
   (pose
    :reader pose
    :initarg :pose
    :type routing_pb_msgs-msg:Pose
    :initform (cl:make-instance 'routing_pb_msgs-msg:Pose)))
)

(cl:defclass LaneWaypoint (<LaneWaypoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneWaypoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneWaypoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name routing_pb_msgs-msg:<LaneWaypoint> is deprecated: use routing_pb_msgs-msg:LaneWaypoint instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <LaneWaypoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:id-val is deprecated.  Use routing_pb_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 's-val :lambda-list '(m))
(cl:defmethod s-val ((m <LaneWaypoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:s-val is deprecated.  Use routing_pb_msgs-msg:s instead.")
  (s m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <LaneWaypoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:pose-val is deprecated.  Use routing_pb_msgs-msg:pose instead.")
  (pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneWaypoint>) ostream)
  "Serializes a message object of type '<LaneWaypoint>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'id))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 's))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneWaypoint>) istream)
  "Deserializes a message object of type '<LaneWaypoint>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 's) (roslisp-utils:decode-double-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneWaypoint>)))
  "Returns string type for a message object of type '<LaneWaypoint>"
  "routing_pb_msgs/LaneWaypoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneWaypoint)))
  "Returns string type for a message object of type 'LaneWaypoint"
  "routing_pb_msgs/LaneWaypoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneWaypoint>)))
  "Returns md5sum for a message object of type '<LaneWaypoint>"
  "fad686053627fc458de75e74f7ec519d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneWaypoint)))
  "Returns md5sum for a message object of type 'LaneWaypoint"
  "fad686053627fc458de75e74f7ec519d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneWaypoint>)))
  "Returns full string definition for message of type '<LaneWaypoint>"
  (cl:format cl:nil "string id ~%float64 s ~%Pose pose ~%~%================================================================================~%MSG: routing_pb_msgs/Pose~%float64 x ~%float64 y ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneWaypoint)))
  "Returns full string definition for message of type 'LaneWaypoint"
  (cl:format cl:nil "string id ~%float64 s ~%Pose pose ~%~%================================================================================~%MSG: routing_pb_msgs/Pose~%float64 x ~%float64 y ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneWaypoint>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'id))
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneWaypoint>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneWaypoint
    (cl:cons ':id (id msg))
    (cl:cons ':s (s msg))
    (cl:cons ':pose (pose msg))
))
