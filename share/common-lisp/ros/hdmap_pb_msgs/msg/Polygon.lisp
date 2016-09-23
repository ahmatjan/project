; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Polygon.msg.html

(cl:defclass <Polygon> (roslisp-msg-protocol:ros-message)
  ((point
    :reader point
    :initarg :point
    :type (cl:vector hdmap_pb_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Point :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Point))))
)

(cl:defclass Polygon (<Polygon>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Polygon>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Polygon)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Polygon> is deprecated: use hdmap_pb_msgs-msg:Polygon instead.")))

(cl:ensure-generic-function 'point-val :lambda-list '(m))
(cl:defmethod point-val ((m <Polygon>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:point-val is deprecated.  Use hdmap_pb_msgs-msg:point instead.")
  (point m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Polygon>) ostream)
  "Serializes a message object of type '<Polygon>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'point))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'point))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Polygon>) istream)
  "Deserializes a message object of type '<Polygon>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'point) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'point)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Polygon>)))
  "Returns string type for a message object of type '<Polygon>"
  "hdmap_pb_msgs/Polygon")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Polygon)))
  "Returns string type for a message object of type 'Polygon"
  "hdmap_pb_msgs/Polygon")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Polygon>)))
  "Returns md5sum for a message object of type '<Polygon>"
  "a7c84ff13976aa04656e56e300124444")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Polygon)))
  "Returns md5sum for a message object of type 'Polygon"
  "a7c84ff13976aa04656e56e300124444")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Polygon>)))
  "Returns full string definition for message of type '<Polygon>"
  (cl:format cl:nil "Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Polygon)))
  "Returns full string definition for message of type 'Polygon"
  (cl:format cl:nil "Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Polygon>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'point) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Polygon>))
  "Converts a ROS message object to a list"
  (cl:list 'Polygon
    (cl:cons ':point (point msg))
))
