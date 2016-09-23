; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude ObjectSidePass.msg.html

(cl:defclass <ObjectSidePass> (roslisp-msg-protocol:ros-message)
  ((distance_s
    :reader distance_s
    :initarg :distance_s
    :type cl:float
    :initform 0.0)
   (preferred_distance_s
    :reader preferred_distance_s
    :initarg :preferred_distance_s
    :type decision_pb_msgs-msg:Range
    :initform (cl:make-instance 'decision_pb_msgs-msg:Range))
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0))
)

(cl:defclass ObjectSidePass (<ObjectSidePass>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectSidePass>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectSidePass)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<ObjectSidePass> is deprecated: use decision_pb_msgs-msg:ObjectSidePass instead.")))

(cl:ensure-generic-function 'distance_s-val :lambda-list '(m))
(cl:defmethod distance_s-val ((m <ObjectSidePass>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:distance_s-val is deprecated.  Use decision_pb_msgs-msg:distance_s instead.")
  (distance_s m))

(cl:ensure-generic-function 'preferred_distance_s-val :lambda-list '(m))
(cl:defmethod preferred_distance_s-val ((m <ObjectSidePass>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:preferred_distance_s-val is deprecated.  Use decision_pb_msgs-msg:preferred_distance_s instead.")
  (preferred_distance_s m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <ObjectSidePass>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:type-val is deprecated.  Use decision_pb_msgs-msg:type instead.")
  (type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectSidePass>) ostream)
  "Serializes a message object of type '<ObjectSidePass>"
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
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectSidePass>) istream)
  "Deserializes a message object of type '<ObjectSidePass>"
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectSidePass>)))
  "Returns string type for a message object of type '<ObjectSidePass>"
  "decision_pb_msgs/ObjectSidePass")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectSidePass)))
  "Returns string type for a message object of type 'ObjectSidePass"
  "decision_pb_msgs/ObjectSidePass")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectSidePass>)))
  "Returns md5sum for a message object of type '<ObjectSidePass>"
  "2da38451d816de61e97f305cc615d9ab")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectSidePass)))
  "Returns md5sum for a message object of type 'ObjectSidePass"
  "2da38451d816de61e97f305cc615d9ab")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectSidePass>)))
  "Returns full string definition for message of type '<ObjectSidePass>"
  (cl:format cl:nil "float64 distance_s ~%Range preferred_distance_s ~%int32 type ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectSidePass)))
  "Returns full string definition for message of type 'ObjectSidePass"
  (cl:format cl:nil "float64 distance_s ~%Range preferred_distance_s ~%int32 type ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectSidePass>))
  (cl:+ 0
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'preferred_distance_s))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectSidePass>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectSidePass
    (cl:cons ':distance_s (distance_s msg))
    (cl:cons ':preferred_distance_s (preferred_distance_s msg))
    (cl:cons ':type (type msg))
))
