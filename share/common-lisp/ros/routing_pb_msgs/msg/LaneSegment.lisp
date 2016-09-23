; Auto-generated. Do not edit!


(cl:in-package routing_pb_msgs-msg)


;//! \htmlinclude LaneSegment.msg.html

(cl:defclass <LaneSegment> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:string
    :initform "")
   (start_s
    :reader start_s
    :initarg :start_s
    :type cl:float
    :initform 0.0)
   (end_s
    :reader end_s
    :initarg :end_s
    :type cl:float
    :initform 0.0))
)

(cl:defclass LaneSegment (<LaneSegment>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneSegment>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneSegment)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name routing_pb_msgs-msg:<LaneSegment> is deprecated: use routing_pb_msgs-msg:LaneSegment instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <LaneSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:id-val is deprecated.  Use routing_pb_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'start_s-val :lambda-list '(m))
(cl:defmethod start_s-val ((m <LaneSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:start_s-val is deprecated.  Use routing_pb_msgs-msg:start_s instead.")
  (start_s m))

(cl:ensure-generic-function 'end_s-val :lambda-list '(m))
(cl:defmethod end_s-val ((m <LaneSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:end_s-val is deprecated.  Use routing_pb_msgs-msg:end_s instead.")
  (end_s m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneSegment>) ostream)
  "Serializes a message object of type '<LaneSegment>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'id))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'start_s))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'end_s))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneSegment>) istream)
  "Deserializes a message object of type '<LaneSegment>"
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
    (cl:setf (cl:slot-value msg 'start_s) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'end_s) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneSegment>)))
  "Returns string type for a message object of type '<LaneSegment>"
  "routing_pb_msgs/LaneSegment")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneSegment)))
  "Returns string type for a message object of type 'LaneSegment"
  "routing_pb_msgs/LaneSegment")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneSegment>)))
  "Returns md5sum for a message object of type '<LaneSegment>"
  "84908c83fe9738f40eb153cc54d9330b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneSegment)))
  "Returns md5sum for a message object of type 'LaneSegment"
  "84908c83fe9738f40eb153cc54d9330b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneSegment>)))
  "Returns full string definition for message of type '<LaneSegment>"
  (cl:format cl:nil "string id ~%float64 start_s ~%float64 end_s ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneSegment)))
  "Returns full string definition for message of type 'LaneSegment"
  (cl:format cl:nil "string id ~%float64 start_s ~%float64 end_s ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneSegment>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'id))
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneSegment>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneSegment
    (cl:cons ':id (id msg))
    (cl:cons ':start_s (start_s msg))
    (cl:cons ':end_s (end_s msg))
))
