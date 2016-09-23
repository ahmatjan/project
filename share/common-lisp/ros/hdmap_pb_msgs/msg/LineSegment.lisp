; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude LineSegment.msg.html

(cl:defclass <LineSegment> (roslisp-msg-protocol:ros-message)
  ((point
    :reader point
    :initarg :point
    :type (cl:vector hdmap_pb_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Point :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Point))))
)

(cl:defclass LineSegment (<LineSegment>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LineSegment>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LineSegment)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<LineSegment> is deprecated: use hdmap_pb_msgs-msg:LineSegment instead.")))

(cl:ensure-generic-function 'point-val :lambda-list '(m))
(cl:defmethod point-val ((m <LineSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:point-val is deprecated.  Use hdmap_pb_msgs-msg:point instead.")
  (point m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LineSegment>) ostream)
  "Serializes a message object of type '<LineSegment>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'point))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'point))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LineSegment>) istream)
  "Deserializes a message object of type '<LineSegment>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LineSegment>)))
  "Returns string type for a message object of type '<LineSegment>"
  "hdmap_pb_msgs/LineSegment")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LineSegment)))
  "Returns string type for a message object of type 'LineSegment"
  "hdmap_pb_msgs/LineSegment")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LineSegment>)))
  "Returns md5sum for a message object of type '<LineSegment>"
  "a7c84ff13976aa04656e56e300124444")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LineSegment)))
  "Returns md5sum for a message object of type 'LineSegment"
  "a7c84ff13976aa04656e56e300124444")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LineSegment>)))
  "Returns full string definition for message of type '<LineSegment>"
  (cl:format cl:nil "Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LineSegment)))
  "Returns full string definition for message of type 'LineSegment"
  (cl:format cl:nil "Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LineSegment>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'point) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LineSegment>))
  "Converts a ROS message object to a list"
  (cl:list 'LineSegment
    (cl:cons ':point (point msg))
))
