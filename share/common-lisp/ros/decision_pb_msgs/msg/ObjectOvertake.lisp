; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude ObjectOvertake.msg.html

(cl:defclass <ObjectOvertake> (roslisp-msg-protocol:ros-message)
  ((distance_s
    :reader distance_s
    :initarg :distance_s
    :type cl:float
    :initform 0.0)
   (preferred_distance_s
    :reader preferred_distance_s
    :initarg :preferred_distance_s
    :type decision_pb_msgs-msg:Range
    :initform (cl:make-instance 'decision_pb_msgs-msg:Range)))
)

(cl:defclass ObjectOvertake (<ObjectOvertake>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectOvertake>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectOvertake)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<ObjectOvertake> is deprecated: use decision_pb_msgs-msg:ObjectOvertake instead.")))

(cl:ensure-generic-function 'distance_s-val :lambda-list '(m))
(cl:defmethod distance_s-val ((m <ObjectOvertake>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:distance_s-val is deprecated.  Use decision_pb_msgs-msg:distance_s instead.")
  (distance_s m))

(cl:ensure-generic-function 'preferred_distance_s-val :lambda-list '(m))
(cl:defmethod preferred_distance_s-val ((m <ObjectOvertake>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:preferred_distance_s-val is deprecated.  Use decision_pb_msgs-msg:preferred_distance_s instead.")
  (preferred_distance_s m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectOvertake>) ostream)
  "Serializes a message object of type '<ObjectOvertake>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'distance_s))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'preferred_distance_s) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectOvertake>) istream)
  "Deserializes a message object of type '<ObjectOvertake>"
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
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'preferred_distance_s) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectOvertake>)))
  "Returns string type for a message object of type '<ObjectOvertake>"
  "decision_pb_msgs/ObjectOvertake")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectOvertake)))
  "Returns string type for a message object of type 'ObjectOvertake"
  "decision_pb_msgs/ObjectOvertake")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectOvertake>)))
  "Returns md5sum for a message object of type '<ObjectOvertake>"
  "9c96f49701835268bc12dea5225ffaca")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectOvertake)))
  "Returns md5sum for a message object of type 'ObjectOvertake"
  "9c96f49701835268bc12dea5225ffaca")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectOvertake>)))
  "Returns full string definition for message of type '<ObjectOvertake>"
  (cl:format cl:nil "float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectOvertake)))
  "Returns full string definition for message of type 'ObjectOvertake"
  (cl:format cl:nil "float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectOvertake>))
  (cl:+ 0
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'preferred_distance_s))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectOvertake>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectOvertake
    (cl:cons ':distance_s (distance_s msg))
    (cl:cons ':preferred_distance_s (preferred_distance_s msg))
))
