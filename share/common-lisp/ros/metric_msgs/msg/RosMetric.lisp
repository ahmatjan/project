; Auto-generated. Do not edit!


(cl:in-package metric_msgs-msg)


;//! \htmlinclude RosMetric.msg.html

(cl:defclass <RosMetric> (roslisp-msg-protocol:ros-message)
  ((group
    :reader group
    :initarg :group
    :type cl:string
    :initform "")
   (name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (testtype
    :reader testtype
    :initarg :testtype
    :type cl:integer
    :initform 0)
   (testfunc
    :reader testfunc
    :initarg :testfunc
    :type cl:string
    :initform "")
   (testargs
    :reader testargs
    :initarg :testargs
    :type cl:string
    :initform "")
   (oneshot
    :reader oneshot
    :initarg :oneshot
    :type cl:integer
    :initform 0)
   (period
    :reader period
    :initarg :period
    :type cl:integer
    :initform 0)
   (status
    :reader status
    :initarg :status
    :type cl:integer
    :initform 0))
)

(cl:defclass RosMetric (<RosMetric>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RosMetric>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RosMetric)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name metric_msgs-msg:<RosMetric> is deprecated: use metric_msgs-msg:RosMetric instead.")))

(cl:ensure-generic-function 'group-val :lambda-list '(m))
(cl:defmethod group-val ((m <RosMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:group-val is deprecated.  Use metric_msgs-msg:group instead.")
  (group m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <RosMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:name-val is deprecated.  Use metric_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'testtype-val :lambda-list '(m))
(cl:defmethod testtype-val ((m <RosMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:testtype-val is deprecated.  Use metric_msgs-msg:testtype instead.")
  (testtype m))

(cl:ensure-generic-function 'testfunc-val :lambda-list '(m))
(cl:defmethod testfunc-val ((m <RosMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:testfunc-val is deprecated.  Use metric_msgs-msg:testfunc instead.")
  (testfunc m))

(cl:ensure-generic-function 'testargs-val :lambda-list '(m))
(cl:defmethod testargs-val ((m <RosMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:testargs-val is deprecated.  Use metric_msgs-msg:testargs instead.")
  (testargs m))

(cl:ensure-generic-function 'oneshot-val :lambda-list '(m))
(cl:defmethod oneshot-val ((m <RosMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:oneshot-val is deprecated.  Use metric_msgs-msg:oneshot instead.")
  (oneshot m))

(cl:ensure-generic-function 'period-val :lambda-list '(m))
(cl:defmethod period-val ((m <RosMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:period-val is deprecated.  Use metric_msgs-msg:period instead.")
  (period m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <RosMetric>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-msg:status-val is deprecated.  Use metric_msgs-msg:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RosMetric>) ostream)
  "Serializes a message object of type '<RosMetric>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'group))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'group))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'testtype)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'testtype)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'testtype)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'testtype)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'testfunc))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'testfunc))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'testargs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'testargs))
  (cl:let* ((signed (cl:slot-value msg 'oneshot)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'period)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'period)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'period)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'period)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RosMetric>) istream)
  "Deserializes a message object of type '<RosMetric>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'group) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'group) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'testtype)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'testtype)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'testtype)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'testtype)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'testfunc) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'testfunc) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'testargs) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'testargs) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'oneshot) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'period)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'period)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'period)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'period)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RosMetric>)))
  "Returns string type for a message object of type '<RosMetric>"
  "metric_msgs/RosMetric")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RosMetric)))
  "Returns string type for a message object of type 'RosMetric"
  "metric_msgs/RosMetric")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RosMetric>)))
  "Returns md5sum for a message object of type '<RosMetric>"
  "b8813be7c9e09f78b73d1aa99c1f18f6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RosMetric)))
  "Returns md5sum for a message object of type 'RosMetric"
  "b8813be7c9e09f78b73d1aa99c1f18f6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RosMetric>)))
  "Returns full string definition for message of type '<RosMetric>"
  (cl:format cl:nil "string group~%string name~%uint32  testtype~%string testfunc~%string testargs~%int32 oneshot~%uint32 period~%int32 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RosMetric)))
  "Returns full string definition for message of type 'RosMetric"
  (cl:format cl:nil "string group~%string name~%uint32  testtype~%string testfunc~%string testargs~%int32 oneshot~%uint32 period~%int32 status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RosMetric>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'group))
     4 (cl:length (cl:slot-value msg 'name))
     4
     4 (cl:length (cl:slot-value msg 'testfunc))
     4 (cl:length (cl:slot-value msg 'testargs))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RosMetric>))
  "Converts a ROS message object to a list"
  (cl:list 'RosMetric
    (cl:cons ':group (group msg))
    (cl:cons ':name (name msg))
    (cl:cons ':testtype (testtype msg))
    (cl:cons ':testfunc (testfunc msg))
    (cl:cons ':testargs (testargs msg))
    (cl:cons ':oneshot (oneshot msg))
    (cl:cons ':period (period msg))
    (cl:cons ':status (status msg))
))
