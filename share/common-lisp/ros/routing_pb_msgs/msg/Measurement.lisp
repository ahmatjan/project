; Auto-generated. Do not edit!


(cl:in-package routing_pb_msgs-msg)


;//! \htmlinclude Measurement.msg.html

(cl:defclass <Measurement> (roslisp-msg-protocol:ros-message)
  ((distance
    :reader distance
    :initarg :distance
    :type cl:float
    :initform 0.0))
)

(cl:defclass Measurement (<Measurement>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Measurement>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Measurement)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name routing_pb_msgs-msg:<Measurement> is deprecated: use routing_pb_msgs-msg:Measurement instead.")))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <Measurement>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:distance-val is deprecated.  Use routing_pb_msgs-msg:distance instead.")
  (distance m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Measurement>) ostream)
  "Serializes a message object of type '<Measurement>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Measurement>) istream)
  "Deserializes a message object of type '<Measurement>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Measurement>)))
  "Returns string type for a message object of type '<Measurement>"
  "routing_pb_msgs/Measurement")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Measurement)))
  "Returns string type for a message object of type 'Measurement"
  "routing_pb_msgs/Measurement")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Measurement>)))
  "Returns md5sum for a message object of type '<Measurement>"
  "acff7fda0c683c872875f5c4b069f124")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Measurement)))
  "Returns md5sum for a message object of type 'Measurement"
  "acff7fda0c683c872875f5c4b069f124")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Measurement>)))
  "Returns full string definition for message of type '<Measurement>"
  (cl:format cl:nil "float64 distance ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Measurement)))
  "Returns full string definition for message of type 'Measurement"
  (cl:format cl:nil "float64 distance ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Measurement>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Measurement>))
  "Converts a ROS message object to a list"
  (cl:list 'Measurement
    (cl:cons ':distance (distance msg))
))
