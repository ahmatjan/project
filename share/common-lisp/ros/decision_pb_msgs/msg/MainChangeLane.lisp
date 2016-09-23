; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude MainChangeLane.msg.html

(cl:defclass <MainChangeLane> (roslisp-msg-protocol:ros-message)
  ((type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0))
)

(cl:defclass MainChangeLane (<MainChangeLane>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MainChangeLane>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MainChangeLane)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<MainChangeLane> is deprecated: use decision_pb_msgs-msg:MainChangeLane instead.")))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <MainChangeLane>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:type-val is deprecated.  Use decision_pb_msgs-msg:type instead.")
  (type m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MainChangeLane>) ostream)
  "Serializes a message object of type '<MainChangeLane>"
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MainChangeLane>) istream)
  "Deserializes a message object of type '<MainChangeLane>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MainChangeLane>)))
  "Returns string type for a message object of type '<MainChangeLane>"
  "decision_pb_msgs/MainChangeLane")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MainChangeLane)))
  "Returns string type for a message object of type 'MainChangeLane"
  "decision_pb_msgs/MainChangeLane")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MainChangeLane>)))
  "Returns md5sum for a message object of type '<MainChangeLane>"
  "bda37decd5e3814bcc042f341d2e60a1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MainChangeLane)))
  "Returns md5sum for a message object of type 'MainChangeLane"
  "bda37decd5e3814bcc042f341d2e60a1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MainChangeLane>)))
  "Returns full string definition for message of type '<MainChangeLane>"
  (cl:format cl:nil "int32 type ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MainChangeLane)))
  "Returns full string definition for message of type 'MainChangeLane"
  (cl:format cl:nil "int32 type ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MainChangeLane>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MainChangeLane>))
  "Converts a ROS message object to a list"
  (cl:list 'MainChangeLane
    (cl:cons ':type (type msg))
))
