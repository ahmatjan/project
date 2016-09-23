; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude ObjectNudge.msg.html

(cl:defclass <ObjectNudge> (roslisp-msg-protocol:ros-message)
  ((distance_l
    :reader distance_l
    :initarg :distance_l
    :type cl:float
    :initform 0.0)
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (preferred_distance_l
    :reader preferred_distance_l
    :initarg :preferred_distance_l
    :type decision_pb_msgs-msg:Range
    :initform (cl:make-instance 'decision_pb_msgs-msg:Range)))
)

(cl:defclass ObjectNudge (<ObjectNudge>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectNudge>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectNudge)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<ObjectNudge> is deprecated: use decision_pb_msgs-msg:ObjectNudge instead.")))

(cl:ensure-generic-function 'distance_l-val :lambda-list '(m))
(cl:defmethod distance_l-val ((m <ObjectNudge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:distance_l-val is deprecated.  Use decision_pb_msgs-msg:distance_l instead.")
  (distance_l m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <ObjectNudge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:type-val is deprecated.  Use decision_pb_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'preferred_distance_l-val :lambda-list '(m))
(cl:defmethod preferred_distance_l-val ((m <ObjectNudge>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:preferred_distance_l-val is deprecated.  Use decision_pb_msgs-msg:preferred_distance_l instead.")
  (preferred_distance_l m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectNudge>) ostream)
  "Serializes a message object of type '<ObjectNudge>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'distance_l))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'preferred_distance_l) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectNudge>) istream)
  "Deserializes a message object of type '<ObjectNudge>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance_l) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'preferred_distance_l) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectNudge>)))
  "Returns string type for a message object of type '<ObjectNudge>"
  "decision_pb_msgs/ObjectNudge")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectNudge)))
  "Returns string type for a message object of type 'ObjectNudge"
  "decision_pb_msgs/ObjectNudge")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectNudge>)))
  "Returns md5sum for a message object of type '<ObjectNudge>"
  "fb0d3d4ff3a41e9fa643afca4c5c267e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectNudge)))
  "Returns md5sum for a message object of type 'ObjectNudge"
  "fb0d3d4ff3a41e9fa643afca4c5c267e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectNudge>)))
  "Returns full string definition for message of type '<ObjectNudge>"
  (cl:format cl:nil "float64 distance_l ~%int32 type ~%Range preferred_distance_l ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectNudge)))
  "Returns full string definition for message of type 'ObjectNudge"
  (cl:format cl:nil "float64 distance_l ~%int32 type ~%Range preferred_distance_l ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectNudge>))
  (cl:+ 0
     8
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'preferred_distance_l))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectNudge>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectNudge
    (cl:cons ':distance_l (distance_l msg))
    (cl:cons ':type (type msg))
    (cl:cons ':preferred_distance_l (preferred_distance_l msg))
))
