; Auto-generated. Do not edit!


(cl:in-package metric_msgs-msg)


;//! \htmlinclude MetricStatus.msg.html

(cl:defclass <MetricStatus> (roslisp-msg-protocol:ros-message)
  ((level
    :reader level
    :initarg :level
    :type cl:fixnum
    :initform 0)
   (stamp
    :reader stamp
    :initarg :stamp
    :type cl:real
    :initform 0)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform "")
   (values
    :reader values
    :initarg :values
    :type (cl:vector metric_msgs-msg:KeyValue)
   :initform (cl:make-array 0 :element-type 'metric_msgs-msg:KeyValue :initial-element (cl:make-instance 'metric_msgs-msg:KeyValue))))
)

(cl:defclass MetricStatus (<MetricStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MetricStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MetricStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name metric_msgs-msg:<MetricStatus> is deprecated: use metric_msgs-msg:MetricStatus instead.")))

(cl:ensure-generic-function 'level-val :lambda-list '(m))
(cl:defmethod level-val ((m <MetricStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:level-val is deprecated.  Use metric_msgs-msg:level instead.")
  (level m))

(cl:ensure-generic-function 'stamp-val :lambda-list '(m))
(cl:defmethod stamp-val ((m <MetricStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:stamp-val is deprecated.  Use metric_msgs-msg:stamp instead.")
  (stamp m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <MetricStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:message-val is deprecated.  Use metric_msgs-msg:message instead.")
  (message m))

(cl:ensure-generic-function 'values-val :lambda-list '(m))
(cl:defmethod values-val ((m <MetricStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:values-val is deprecated.  Use metric_msgs-msg:values instead.")
  (values m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<MetricStatus>)))
    "Constants for message type '<MetricStatus>"
  '((:OK . 0)
    (:WARN . 1)
    (:ERROR . 2)
    (:STALE . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'MetricStatus)))
    "Constants for message type 'MetricStatus"
  '((:OK . 0)
    (:WARN . 1)
    (:ERROR . 2)
    (:STALE . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MetricStatus>) ostream)
  "Serializes a message object of type '<MetricStatus>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'level)) ostream)
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'stamp)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'stamp) (cl:floor (cl:slot-value msg 'stamp)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'values))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'values))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MetricStatus>) istream)
  "Deserializes a message object of type '<MetricStatus>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'level)) (cl:read-byte istream))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'stamp) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'values) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'values)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'metric_msgs-msg:KeyValue))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MetricStatus>)))
  "Returns string type for a message object of type '<MetricStatus>"
  "metric_msgs/MetricStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MetricStatus)))
  "Returns string type for a message object of type 'MetricStatus"
  "metric_msgs/MetricStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MetricStatus>)))
  "Returns md5sum for a message object of type '<MetricStatus>"
  "376e87c0d702dd9e1244411d350ed86a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MetricStatus)))
  "Returns md5sum for a message object of type 'MetricStatus"
  "376e87c0d702dd9e1244411d350ed86a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MetricStatus>)))
  "Returns full string definition for message of type '<MetricStatus>"
  (cl:format cl:nil "uint8 OK=0~%uint8 WARN=1~%uint8 ERROR=2~%uint8 STALE=3~%~%uint8 level~%time stamp~%string message~%KeyValue[] values~%~%================================================================================~%MSG: metric_msgs/KeyValue~%string key~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MetricStatus)))
  "Returns full string definition for message of type 'MetricStatus"
  (cl:format cl:nil "uint8 OK=0~%uint8 WARN=1~%uint8 ERROR=2~%uint8 STALE=3~%~%uint8 level~%time stamp~%string message~%KeyValue[] values~%~%================================================================================~%MSG: metric_msgs/KeyValue~%string key~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MetricStatus>))
  (cl:+ 0
     1
     8
     4 (cl:length (cl:slot-value msg 'message))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'values) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MetricStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'MetricStatus
    (cl:cons ':level (level msg))
    (cl:cons ':stamp (stamp msg))
    (cl:cons ':message (message msg))
    (cl:cons ':values (values msg))
))
