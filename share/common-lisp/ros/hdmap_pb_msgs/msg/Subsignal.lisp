; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Subsignal.msg.html

(cl:defclass <Subsignal> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type hdmap_pb_msgs-msg:Id
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Id))
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (location
    :reader location
    :initarg :location
    :type hdmap_pb_msgs-msg:Point
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Point)))
)

(cl:defclass Subsignal (<Subsignal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Subsignal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Subsignal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Subsignal> is deprecated: use hdmap_pb_msgs-msg:Subsignal instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Subsignal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:id-val is deprecated.  Use hdmap_pb_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <Subsignal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:type-val is deprecated.  Use hdmap_pb_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'location-val :lambda-list '(m))
(cl:defmethod location-val ((m <Subsignal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:location-val is deprecated.  Use hdmap_pb_msgs-msg:location instead.")
  (location m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Subsignal>) ostream)
  "Serializes a message object of type '<Subsignal>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'id) ostream)
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'location) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Subsignal>) istream)
  "Deserializes a message object of type '<Subsignal>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'id) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'location) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Subsignal>)))
  "Returns string type for a message object of type '<Subsignal>"
  "hdmap_pb_msgs/Subsignal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Subsignal)))
  "Returns string type for a message object of type 'Subsignal"
  "hdmap_pb_msgs/Subsignal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Subsignal>)))
  "Returns md5sum for a message object of type '<Subsignal>"
  "227ecc846f6f31e38bceb609a8e59eaa")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Subsignal)))
  "Returns md5sum for a message object of type 'Subsignal"
  "227ecc846f6f31e38bceb609a8e59eaa")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Subsignal>)))
  "Returns full string definition for message of type '<Subsignal>"
  (cl:format cl:nil "Id id ~%int32 type ~%Point location ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Subsignal)))
  "Returns full string definition for message of type 'Subsignal"
  (cl:format cl:nil "Id id ~%int32 type ~%Point location ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Subsignal>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'id))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'location))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Subsignal>))
  "Converts a ROS message object to a list"
  (cl:list 'Subsignal
    (cl:cons ':id (id msg))
    (cl:cons ':type (type msg))
    (cl:cons ':location (location msg))
))
