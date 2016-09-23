; Auto-generated. Do not edit!


(cl:in-package header_pb_msgs-msg)


;//! \htmlinclude Header.msg.html

(cl:defclass <Header> (roslisp-msg-protocol:ros-message)
  ((timestamp_sec
    :reader timestamp_sec
    :initarg :timestamp_sec
    :type cl:float
    :initform 0.0)
   (module_name
    :reader module_name
    :initarg :module_name
    :type cl:string
    :initform "")
   (sequence_num
    :reader sequence_num
    :initarg :sequence_num
    :type cl:integer
    :initform 0))
)

(cl:defclass Header (<Header>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Header>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Header)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name header_pb_msgs-msg:<Header> is deprecated: use header_pb_msgs-msg:Header instead.")))

(cl:ensure-generic-function 'timestamp_sec-val :lambda-list '(m))
(cl:defmethod timestamp_sec-val ((m <Header>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader header_pb_msgs-msg:timestamp_sec-val is deprecated.  Use header_pb_msgs-msg:timestamp_sec instead.")
  (timestamp_sec m))

(cl:ensure-generic-function 'module_name-val :lambda-list '(m))
(cl:defmethod module_name-val ((m <Header>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader header_pb_msgs-msg:module_name-val is deprecated.  Use header_pb_msgs-msg:module_name instead.")
  (module_name m))

(cl:ensure-generic-function 'sequence_num-val :lambda-list '(m))
(cl:defmethod sequence_num-val ((m <Header>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader header_pb_msgs-msg:sequence_num-val is deprecated.  Use header_pb_msgs-msg:sequence_num instead.")
  (sequence_num m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Header>) ostream)
  "Serializes a message object of type '<Header>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'timestamp_sec))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'module_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'module_name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'sequence_num)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'sequence_num)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'sequence_num)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'sequence_num)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Header>) istream)
  "Deserializes a message object of type '<Header>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'timestamp_sec) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'module_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'module_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'sequence_num)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'sequence_num)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'sequence_num)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'sequence_num)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Header>)))
  "Returns string type for a message object of type '<Header>"
  "header_pb_msgs/Header")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Header)))
  "Returns string type for a message object of type 'Header"
  "header_pb_msgs/Header")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Header>)))
  "Returns md5sum for a message object of type '<Header>"
  "06715a034fb205d0968652071794fe95")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Header)))
  "Returns md5sum for a message object of type 'Header"
  "06715a034fb205d0968652071794fe95")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Header>)))
  "Returns full string definition for message of type '<Header>"
  (cl:format cl:nil "float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Header)))
  "Returns full string definition for message of type 'Header"
  (cl:format cl:nil "float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Header>))
  (cl:+ 0
     8
     4 (cl:length (cl:slot-value msg 'module_name))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Header>))
  "Converts a ROS message object to a list"
  (cl:list 'Header
    (cl:cons ':timestamp_sec (timestamp_sec msg))
    (cl:cons ':module_name (module_name msg))
    (cl:cons ':sequence_num (sequence_num msg))
))
