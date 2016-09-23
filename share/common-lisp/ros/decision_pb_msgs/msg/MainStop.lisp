; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude MainStop.msg.html

(cl:defclass <MainStop> (roslisp-msg-protocol:ros-message)
  ((enforced_line
    :reader enforced_line
    :initarg :enforced_line
    :type decision_pb_msgs-msg:StopLine
    :initform (cl:make-instance 'decision_pb_msgs-msg:StopLine))
   (preferred_start
    :reader preferred_start
    :initarg :preferred_start
    :type decision_pb_msgs-msg:StopLine
    :initform (cl:make-instance 'decision_pb_msgs-msg:StopLine))
   (preferred_end
    :reader preferred_end
    :initarg :preferred_end
    :type decision_pb_msgs-msg:StopLine
    :initform (cl:make-instance 'decision_pb_msgs-msg:StopLine))
   (reason
    :reader reason
    :initarg :reason
    :type cl:string
    :initform ""))
)

(cl:defclass MainStop (<MainStop>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MainStop>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MainStop)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<MainStop> is deprecated: use decision_pb_msgs-msg:MainStop instead.")))

(cl:ensure-generic-function 'enforced_line-val :lambda-list '(m))
(cl:defmethod enforced_line-val ((m <MainStop>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:enforced_line-val is deprecated.  Use decision_pb_msgs-msg:enforced_line instead.")
  (enforced_line m))

(cl:ensure-generic-function 'preferred_start-val :lambda-list '(m))
(cl:defmethod preferred_start-val ((m <MainStop>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:preferred_start-val is deprecated.  Use decision_pb_msgs-msg:preferred_start instead.")
  (preferred_start m))

(cl:ensure-generic-function 'preferred_end-val :lambda-list '(m))
(cl:defmethod preferred_end-val ((m <MainStop>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:preferred_end-val is deprecated.  Use decision_pb_msgs-msg:preferred_end instead.")
  (preferred_end m))

(cl:ensure-generic-function 'reason-val :lambda-list '(m))
(cl:defmethod reason-val ((m <MainStop>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:reason-val is deprecated.  Use decision_pb_msgs-msg:reason instead.")
  (reason m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MainStop>) ostream)
  "Serializes a message object of type '<MainStop>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'enforced_line) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'preferred_start) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'preferred_end) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'reason))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'reason))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MainStop>) istream)
  "Deserializes a message object of type '<MainStop>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'enforced_line) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'preferred_start) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'preferred_end) istream)
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MainStop>)))
  "Returns string type for a message object of type '<MainStop>"
  "decision_pb_msgs/MainStop")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MainStop)))
  "Returns string type for a message object of type 'MainStop"
  "decision_pb_msgs/MainStop")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MainStop>)))
  "Returns md5sum for a message object of type '<MainStop>"
  "ddfd7736f6ba2bbc83b655d8baafce0c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MainStop)))
  "Returns md5sum for a message object of type 'MainStop"
  "ddfd7736f6ba2bbc83b655d8baafce0c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MainStop>)))
  "Returns full string definition for message of type '<MainStop>"
  (cl:format cl:nil "StopLine enforced_line ~%StopLine preferred_start ~%StopLine preferred_end ~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/StopLine~%string lane_id ~%float64 distance_s ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MainStop)))
  "Returns full string definition for message of type 'MainStop"
  (cl:format cl:nil "StopLine enforced_line ~%StopLine preferred_start ~%StopLine preferred_end ~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/StopLine~%string lane_id ~%float64 distance_s ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MainStop>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'enforced_line))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'preferred_start))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'preferred_end))
     4 (cl:length (cl:slot-value msg 'reason))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MainStop>))
  "Converts a ROS message object to a list"
  (cl:list 'MainStop
    (cl:cons ':enforced_line (enforced_line msg))
    (cl:cons ':preferred_start (preferred_start msg))
    (cl:cons ':preferred_end (preferred_end msg))
    (cl:cons ':reason (reason msg))
))
