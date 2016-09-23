; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Spiral.msg.html

(cl:defclass <Spiral> (roslisp-msg-protocol:ros-message)
  ((curv_start
    :reader curv_start
    :initarg :curv_start
    :type cl:float
    :initform 0.0)
   (curv_end
    :reader curv_end
    :initarg :curv_end
    :type cl:float
    :initform 0.0))
)

(cl:defclass Spiral (<Spiral>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Spiral>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Spiral)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Spiral> is deprecated: use hdmap_pb_msgs-msg:Spiral instead.")))

(cl:ensure-generic-function 'curv_start-val :lambda-list '(m))
(cl:defmethod curv_start-val ((m <Spiral>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:curv_start-val is deprecated.  Use hdmap_pb_msgs-msg:curv_start instead.")
  (curv_start m))

(cl:ensure-generic-function 'curv_end-val :lambda-list '(m))
(cl:defmethod curv_end-val ((m <Spiral>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:curv_end-val is deprecated.  Use hdmap_pb_msgs-msg:curv_end instead.")
  (curv_end m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Spiral>) ostream)
  "Serializes a message object of type '<Spiral>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'curv_start))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'curv_end))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Spiral>) istream)
  "Deserializes a message object of type '<Spiral>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'curv_start) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'curv_end) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Spiral>)))
  "Returns string type for a message object of type '<Spiral>"
  "hdmap_pb_msgs/Spiral")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Spiral)))
  "Returns string type for a message object of type 'Spiral"
  "hdmap_pb_msgs/Spiral")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Spiral>)))
  "Returns md5sum for a message object of type '<Spiral>"
  "f594efdaaef93d46121fa010457a699d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Spiral)))
  "Returns md5sum for a message object of type 'Spiral"
  "f594efdaaef93d46121fa010457a699d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Spiral>)))
  "Returns full string definition for message of type '<Spiral>"
  (cl:format cl:nil "float64 curv_start ~%float64 curv_end ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Spiral)))
  "Returns full string definition for message of type 'Spiral"
  (cl:format cl:nil "float64 curv_start ~%float64 curv_end ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Spiral>))
  (cl:+ 0
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Spiral>))
  "Converts a ROS message object to a list"
  (cl:list 'Spiral
    (cl:cons ':curv_start (curv_start msg))
    (cl:cons ':curv_end (curv_end msg))
))
