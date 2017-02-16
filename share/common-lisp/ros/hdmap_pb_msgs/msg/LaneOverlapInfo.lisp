; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude LaneOverlapInfo.msg.html

(cl:defclass <LaneOverlapInfo> (roslisp-msg-protocol:ros-message)
  ((start_s
    :reader start_s
    :initarg :start_s
    :type cl:float
    :initform 0.0)
   (end_s
    :reader end_s
    :initarg :end_s
    :type cl:float
    :initform 0.0)
   (is_merge
    :reader is_merge
    :initarg :is_merge
    :type cl:boolean
    :initform cl:nil)
   (has_precedence
    :reader has_precedence
    :initarg :has_precedence
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass LaneOverlapInfo (<LaneOverlapInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneOverlapInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneOverlapInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<LaneOverlapInfo> is deprecated: use hdmap_pb_msgs-msg:LaneOverlapInfo instead.")))

(cl:ensure-generic-function 'start_s-val :lambda-list '(m))
(cl:defmethod start_s-val ((m <LaneOverlapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:start_s-val is deprecated.  Use hdmap_pb_msgs-msg:start_s instead.")
  (start_s m))

(cl:ensure-generic-function 'end_s-val :lambda-list '(m))
(cl:defmethod end_s-val ((m <LaneOverlapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:end_s-val is deprecated.  Use hdmap_pb_msgs-msg:end_s instead.")
  (end_s m))

(cl:ensure-generic-function 'is_merge-val :lambda-list '(m))
(cl:defmethod is_merge-val ((m <LaneOverlapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:is_merge-val is deprecated.  Use hdmap_pb_msgs-msg:is_merge instead.")
  (is_merge m))

(cl:ensure-generic-function 'has_precedence-val :lambda-list '(m))
(cl:defmethod has_precedence-val ((m <LaneOverlapInfo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:has_precedence-val is deprecated.  Use hdmap_pb_msgs-msg:has_precedence instead.")
  (has_precedence m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneOverlapInfo>) ostream)
  "Serializes a message object of type '<LaneOverlapInfo>"
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
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_merge) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'has_precedence) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneOverlapInfo>) istream)
  "Deserializes a message object of type '<LaneOverlapInfo>"
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
    (cl:setf (cl:slot-value msg 'is_merge) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'has_precedence) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneOverlapInfo>)))
  "Returns string type for a message object of type '<LaneOverlapInfo>"
  "hdmap_pb_msgs/LaneOverlapInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneOverlapInfo)))
  "Returns string type for a message object of type 'LaneOverlapInfo"
  "hdmap_pb_msgs/LaneOverlapInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneOverlapInfo>)))
  "Returns md5sum for a message object of type '<LaneOverlapInfo>"
  "03d30d4f798ccf751f91603c8963a348")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneOverlapInfo)))
  "Returns md5sum for a message object of type 'LaneOverlapInfo"
  "03d30d4f798ccf751f91603c8963a348")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneOverlapInfo>)))
  "Returns full string definition for message of type '<LaneOverlapInfo>"
  (cl:format cl:nil "float64 start_s ~%float64 end_s ~%bool is_merge ~%bool has_precedence ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneOverlapInfo)))
  "Returns full string definition for message of type 'LaneOverlapInfo"
  (cl:format cl:nil "float64 start_s ~%float64 end_s ~%bool is_merge ~%bool has_precedence ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneOverlapInfo>))
  (cl:+ 0
     8
     8
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneOverlapInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneOverlapInfo
    (cl:cons ':start_s (start_s msg))
    (cl:cons ':end_s (end_s msg))
    (cl:cons ':is_merge (is_merge msg))
    (cl:cons ':has_precedence (has_precedence msg))
))
