; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Header.msg.html

(cl:defclass <Header> (roslisp-msg-protocol:ros-message)
  ((version
    :reader version
    :initarg :version
    :type cl:fixnum
    :initform 0)
   (date
    :reader date
    :initarg :date
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Header (<Header>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Header>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Header)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Header> is deprecated: use hdmap_pb_msgs-msg:Header instead.")))

(cl:ensure-generic-function 'version-val :lambda-list '(m))
(cl:defmethod version-val ((m <Header>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:version-val is deprecated.  Use hdmap_pb_msgs-msg:version instead.")
  (version m))

(cl:ensure-generic-function 'date-val :lambda-list '(m))
(cl:defmethod date-val ((m <Header>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:date-val is deprecated.  Use hdmap_pb_msgs-msg:date instead.")
  (date m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Header>) ostream)
  "Serializes a message object of type '<Header>"
  (cl:let* ((signed (cl:slot-value msg 'version)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'date)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Header>) istream)
  "Deserializes a message object of type '<Header>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'version) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'date) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Header>)))
  "Returns string type for a message object of type '<Header>"
  "hdmap_pb_msgs/Header")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Header)))
  "Returns string type for a message object of type 'Header"
  "hdmap_pb_msgs/Header")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Header>)))
  "Returns md5sum for a message object of type '<Header>"
  "0895db18dd17cfe60003b808a98a8084")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Header)))
  "Returns md5sum for a message object of type 'Header"
  "0895db18dd17cfe60003b808a98a8084")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Header>)))
  "Returns full string definition for message of type '<Header>"
  (cl:format cl:nil "int8 version ~%int8 date ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Header)))
  "Returns full string definition for message of type 'Header"
  (cl:format cl:nil "int8 version ~%int8 date ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Header>))
  (cl:+ 0
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Header>))
  "Converts a ROS message object to a list"
  (cl:list 'Header
    (cl:cons ':version (version msg))
    (cl:cons ':date (date msg))
))
