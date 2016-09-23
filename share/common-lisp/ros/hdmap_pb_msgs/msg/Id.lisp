; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Id.msg.html

(cl:defclass <Id> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Id (<Id>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Id>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Id)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Id> is deprecated: use hdmap_pb_msgs-msg:Id instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Id>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:id-val is deprecated.  Use hdmap_pb_msgs-msg:id instead.")
  (id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Id>) ostream)
  "Serializes a message object of type '<Id>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Id>) istream)
  "Deserializes a message object of type '<Id>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Id>)))
  "Returns string type for a message object of type '<Id>"
  "hdmap_pb_msgs/Id")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Id)))
  "Returns string type for a message object of type 'Id"
  "hdmap_pb_msgs/Id")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Id>)))
  "Returns md5sum for a message object of type '<Id>"
  "7d504299943ad968aabe3de24053d208")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Id)))
  "Returns md5sum for a message object of type 'Id"
  "7d504299943ad968aabe3de24053d208")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Id>)))
  "Returns full string definition for message of type '<Id>"
  (cl:format cl:nil "int8 id ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Id)))
  "Returns full string definition for message of type 'Id"
  (cl:format cl:nil "int8 id ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Id>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Id>))
  "Converts a ROS message object to a list"
  (cl:list 'Id
    (cl:cons ':id (id msg))
))
