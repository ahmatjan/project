; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude LaneSampleAssociation.msg.html

(cl:defclass <LaneSampleAssociation> (roslisp-msg-protocol:ros-message)
  ((s
    :reader s
    :initarg :s
    :type cl:float
    :initform 0.0)
   (width
    :reader width
    :initarg :width
    :type cl:float
    :initform 0.0))
)

(cl:defclass LaneSampleAssociation (<LaneSampleAssociation>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneSampleAssociation>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneSampleAssociation)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<LaneSampleAssociation> is deprecated: use hdmap_pb_msgs-msg:LaneSampleAssociation instead.")))

(cl:ensure-generic-function 's-val :lambda-list '(m))
(cl:defmethod s-val ((m <LaneSampleAssociation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:s-val is deprecated.  Use hdmap_pb_msgs-msg:s instead.")
  (s m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <LaneSampleAssociation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:width-val is deprecated.  Use hdmap_pb_msgs-msg:width instead.")
  (width m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneSampleAssociation>) ostream)
  "Serializes a message object of type '<LaneSampleAssociation>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 's))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'width))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneSampleAssociation>) istream)
  "Deserializes a message object of type '<LaneSampleAssociation>"
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'width) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneSampleAssociation>)))
  "Returns string type for a message object of type '<LaneSampleAssociation>"
  "hdmap_pb_msgs/LaneSampleAssociation")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneSampleAssociation)))
  "Returns string type for a message object of type 'LaneSampleAssociation"
  "hdmap_pb_msgs/LaneSampleAssociation")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneSampleAssociation>)))
  "Returns md5sum for a message object of type '<LaneSampleAssociation>"
  "b8e5e301474ef7c2d89e3bb687484700")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneSampleAssociation)))
  "Returns md5sum for a message object of type 'LaneSampleAssociation"
  "b8e5e301474ef7c2d89e3bb687484700")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneSampleAssociation>)))
  "Returns full string definition for message of type '<LaneSampleAssociation>"
  (cl:format cl:nil "float64 s ~%float64 width ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneSampleAssociation)))
  "Returns full string definition for message of type 'LaneSampleAssociation"
  (cl:format cl:nil "float64 s ~%float64 width ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneSampleAssociation>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneSampleAssociation>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneSampleAssociation
    (cl:cons ':s (s msg))
    (cl:cons ':width (width msg))
))
