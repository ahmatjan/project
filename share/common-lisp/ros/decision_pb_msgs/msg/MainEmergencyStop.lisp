; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude MainEmergencyStop.msg.html

(cl:defclass <MainEmergencyStop> (roslisp-msg-protocol:ros-message)
  ((reason
    :reader reason
    :initarg :reason
    :type cl:string
    :initform ""))
)

(cl:defclass MainEmergencyStop (<MainEmergencyStop>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MainEmergencyStop>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MainEmergencyStop)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<MainEmergencyStop> is deprecated: use decision_pb_msgs-msg:MainEmergencyStop instead.")))

(cl:ensure-generic-function 'reason-val :lambda-list '(m))
(cl:defmethod reason-val ((m <MainEmergencyStop>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:reason-val is deprecated.  Use decision_pb_msgs-msg:reason instead.")
  (reason m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MainEmergencyStop>) ostream)
  "Serializes a message object of type '<MainEmergencyStop>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'reason))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'reason))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MainEmergencyStop>) istream)
  "Deserializes a message object of type '<MainEmergencyStop>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'reason) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'reason) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MainEmergencyStop>)))
  "Returns string type for a message object of type '<MainEmergencyStop>"
  "decision_pb_msgs/MainEmergencyStop")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MainEmergencyStop)))
  "Returns string type for a message object of type 'MainEmergencyStop"
  "decision_pb_msgs/MainEmergencyStop")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MainEmergencyStop>)))
  "Returns md5sum for a message object of type '<MainEmergencyStop>"
  "a280da32bbce672d6bdb55a7f298c5c0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MainEmergencyStop)))
  "Returns md5sum for a message object of type 'MainEmergencyStop"
  "a280da32bbce672d6bdb55a7f298c5c0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MainEmergencyStop>)))
  "Returns full string definition for message of type '<MainEmergencyStop>"
  (cl:format cl:nil "string reason ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MainEmergencyStop)))
  "Returns full string definition for message of type 'MainEmergencyStop"
  (cl:format cl:nil "string reason ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MainEmergencyStop>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'reason))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MainEmergencyStop>))
  "Converts a ROS message object to a list"
  (cl:list 'MainEmergencyStop
    (cl:cons ':reason (reason msg))
))
