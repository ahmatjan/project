; Auto-generated. Do not edit!


(cl:in-package perception_pb_msgs-msg)


;//! \htmlinclude PerceptionObstacles.msg.html

(cl:defclass <PerceptionObstacles> (roslisp-msg-protocol:ros-message)
  ((perception_obstacle
    :reader perception_obstacle
    :initarg :perception_obstacle
    :type (cl:vector perception_pb_msgs-msg:PerceptionObstacle)
   :initform (cl:make-array 0 :element-type 'perception_pb_msgs-msg:PerceptionObstacle :initial-element (cl:make-instance 'perception_pb_msgs-msg:PerceptionObstacle)))
   (header
    :reader header
    :initarg :header
    :type header_pb_msgs-msg:Header
    :initform (cl:make-instance 'header_pb_msgs-msg:Header)))
)

(cl:defclass PerceptionObstacles (<PerceptionObstacles>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PerceptionObstacles>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PerceptionObstacles)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name perception_pb_msgs-msg:<PerceptionObstacles> is deprecated: use perception_pb_msgs-msg:PerceptionObstacles instead.")))

(cl:ensure-generic-function 'perception_obstacle-val :lambda-list '(m))
(cl:defmethod perception_obstacle-val ((m <PerceptionObstacles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception_pb_msgs-msg:perception_obstacle-val is deprecated.  Use perception_pb_msgs-msg:perception_obstacle instead.")
  (perception_obstacle m))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PerceptionObstacles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader perception_pb_msgs-msg:header-val is deprecated.  Use perception_pb_msgs-msg:header instead.")
  (header m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PerceptionObstacles>) ostream)
  "Serializes a message object of type '<PerceptionObstacles>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'perception_obstacle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'perception_obstacle))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PerceptionObstacles>) istream)
  "Deserializes a message object of type '<PerceptionObstacles>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'perception_obstacle) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'perception_obstacle)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'perception_pb_msgs-msg:PerceptionObstacle))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PerceptionObstacles>)))
  "Returns string type for a message object of type '<PerceptionObstacles>"
  "perception_pb_msgs/PerceptionObstacles")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PerceptionObstacles)))
  "Returns string type for a message object of type 'PerceptionObstacles"
  "perception_pb_msgs/PerceptionObstacles")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PerceptionObstacles>)))
  "Returns md5sum for a message object of type '<PerceptionObstacles>"
  "0e638b36900c4f56102d536f647bde9d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PerceptionObstacles)))
  "Returns md5sum for a message object of type 'PerceptionObstacles"
  "0e638b36900c4f56102d536f647bde9d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PerceptionObstacles>)))
  "Returns full string definition for message of type '<PerceptionObstacles>"
  (cl:format cl:nil "PerceptionObstacle[] perception_obstacle ~%header_pb_msgs/Header header ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PerceptionObstacles)))
  "Returns full string definition for message of type 'PerceptionObstacles"
  (cl:format cl:nil "PerceptionObstacle[] perception_obstacle ~%header_pb_msgs/Header header ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PerceptionObstacles>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'perception_obstacle) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PerceptionObstacles>))
  "Converts a ROS message object to a list"
  (cl:list 'PerceptionObstacles
    (cl:cons ':perception_obstacle (perception_obstacle msg))
    (cl:cons ':header (header msg))
))
