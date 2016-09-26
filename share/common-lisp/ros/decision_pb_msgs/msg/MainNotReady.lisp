; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude MainNotReady.msg.html

(cl:defclass <MainNotReady> (roslisp-msg-protocol:ros-message)
  ((reason
    :reader reason
    :initarg :reason
    :type cl:string
    :initform ""))
)

(cl:defclass MainNotReady (<MainNotReady>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MainNotReady>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MainNotReady)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<MainNotReady> is deprecated: use decision_pb_msgs-msg:MainNotReady instead.")))

(cl:ensure-generic-function 'reason-val :lambda-list '(m))
(cl:defmethod reason-val ((m <MainNotReady>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:reason-val is deprecated.  Use decision_pb_msgs-msg:reason instead.")
  (reason m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MainNotReady>) ostream)
  "Serializes a message object of type '<MainNotReady>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'reason))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'reason))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MainNotReady>) istream)
  "Deserializes a message object of type '<MainNotReady>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MainNotReady>)))
  "Returns string type for a message object of type '<MainNotReady>"
  "decision_pb_msgs/MainNotReady")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MainNotReady)))
  "Returns string type for a message object of type 'MainNotReady"
  "decision_pb_msgs/MainNotReady")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MainNotReady>)))
  "Returns md5sum for a message object of type '<MainNotReady>"
  "a280da32bbce672d6bdb55a7f298c5c0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MainNotReady)))
  "Returns md5sum for a message object of type 'MainNotReady"
  "a280da32bbce672d6bdb55a7f298c5c0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MainNotReady>)))
  "Returns full string definition for message of type '<MainNotReady>"
  (cl:format cl:nil "string reason ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MainNotReady)))
  "Returns full string definition for message of type 'MainNotReady"
  (cl:format cl:nil "string reason ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MainNotReady>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'reason))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MainNotReady>))
  "Converts a ROS message object to a list"
  (cl:list 'MainNotReady
    (cl:cons ':reason (reason msg))
))
