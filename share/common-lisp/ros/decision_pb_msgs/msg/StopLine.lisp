; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude StopLine.msg.html

(cl:defclass <StopLine> (roslisp-msg-protocol:ros-message)
  ((lane_id
    :reader lane_id
    :initarg :lane_id
    :type cl:string
    :initform "")
   (distance_s
    :reader distance_s
    :initarg :distance_s
    :type cl:float
    :initform 0.0))
)

(cl:defclass StopLine (<StopLine>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StopLine>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StopLine)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<StopLine> is deprecated: use decision_pb_msgs-msg:StopLine instead.")))

(cl:ensure-generic-function 'lane_id-val :lambda-list '(m))
(cl:defmethod lane_id-val ((m <StopLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:lane_id-val is deprecated.  Use decision_pb_msgs-msg:lane_id instead.")
  (lane_id m))

(cl:ensure-generic-function 'distance_s-val :lambda-list '(m))
(cl:defmethod distance_s-val ((m <StopLine>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:distance_s-val is deprecated.  Use decision_pb_msgs-msg:distance_s instead.")
  (distance_s m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StopLine>) ostream)
  "Serializes a message object of type '<StopLine>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'lane_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'lane_id))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'distance_s))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StopLine>) istream)
  "Deserializes a message object of type '<StopLine>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lane_id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'lane_id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance_s) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StopLine>)))
  "Returns string type for a message object of type '<StopLine>"
  "decision_pb_msgs/StopLine")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StopLine)))
  "Returns string type for a message object of type 'StopLine"
  "decision_pb_msgs/StopLine")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StopLine>)))
  "Returns md5sum for a message object of type '<StopLine>"
  "a99f2b192572720b811e3cd16ac82b69")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StopLine)))
  "Returns md5sum for a message object of type 'StopLine"
  "a99f2b192572720b811e3cd16ac82b69")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StopLine>)))
  "Returns full string definition for message of type '<StopLine>"
  (cl:format cl:nil "string lane_id ~%float64 distance_s ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StopLine)))
  "Returns full string definition for message of type 'StopLine"
  (cl:format cl:nil "string lane_id ~%float64 distance_s ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StopLine>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'lane_id))
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StopLine>))
  "Converts a ROS message object to a list"
  (cl:list 'StopLine
    (cl:cons ':lane_id (lane_id msg))
    (cl:cons ':distance_s (distance_s msg))
))
