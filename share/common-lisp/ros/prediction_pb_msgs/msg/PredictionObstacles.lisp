; Auto-generated. Do not edit!


(cl:in-package prediction_pb_msgs-msg)


;//! \htmlinclude PredictionObstacles.msg.html

(cl:defclass <PredictionObstacles> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type header_pb_msgs-msg:Header
    :initform (cl:make-instance 'header_pb_msgs-msg:Header))
   (prediction_obstacle
    :reader prediction_obstacle
    :initarg :prediction_obstacle
    :type (cl:vector prediction_pb_msgs-msg:PredictionObstacle)
   :initform (cl:make-array 0 :element-type 'prediction_pb_msgs-msg:PredictionObstacle :initial-element (cl:make-instance 'prediction_pb_msgs-msg:PredictionObstacle))))
)

(cl:defclass PredictionObstacles (<PredictionObstacles>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PredictionObstacles>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PredictionObstacles)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name prediction_pb_msgs-msg:<PredictionObstacles> is deprecated: use prediction_pb_msgs-msg:PredictionObstacles instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <PredictionObstacles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader prediction_pb_msgs-msg:header-val is deprecated.  Use prediction_pb_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'prediction_obstacle-val :lambda-list '(m))
(cl:defmethod prediction_obstacle-val ((m <PredictionObstacles>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader prediction_pb_msgs-msg:prediction_obstacle-val is deprecated.  Use prediction_pb_msgs-msg:prediction_obstacle instead.")
  (prediction_obstacle m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PredictionObstacles>) ostream)
  "Serializes a message object of type '<PredictionObstacles>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'prediction_obstacle))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'prediction_obstacle))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PredictionObstacles>) istream)
  "Deserializes a message object of type '<PredictionObstacles>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'prediction_obstacle) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'prediction_obstacle)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'prediction_pb_msgs-msg:PredictionObstacle))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PredictionObstacles>)))
  "Returns string type for a message object of type '<PredictionObstacles>"
  "prediction_pb_msgs/PredictionObstacles")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PredictionObstacles)))
  "Returns string type for a message object of type 'PredictionObstacles"
  "prediction_pb_msgs/PredictionObstacles")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PredictionObstacles>)))
  "Returns md5sum for a message object of type '<PredictionObstacles>"
  "53037b062a01e226301b735b8375f7b7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PredictionObstacles)))
  "Returns md5sum for a message object of type 'PredictionObstacles"
  "53037b062a01e226301b735b8375f7b7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PredictionObstacles>)))
  "Returns full string definition for message of type '<PredictionObstacles>"
  (cl:format cl:nil "header_pb_msgs/Header header ~%PredictionObstacle[] prediction_obstacle ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: prediction_pb_msgs/PredictionObstacle~%perception_pb_msgs/PerceptionObstacle perception_obstacle ~%float64 time_stamp ~%float64 predicted_period ~%Trajectory[] trajectory ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: prediction_pb_msgs/Trajectory~%float64 probability ~%TrajectoryPoint[] trajectory_point ~%~%================================================================================~%MSG: prediction_pb_msgs/TrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 velocity ~%float64 t ~%float64 heading ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PredictionObstacles)))
  "Returns full string definition for message of type 'PredictionObstacles"
  (cl:format cl:nil "header_pb_msgs/Header header ~%PredictionObstacle[] prediction_obstacle ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: prediction_pb_msgs/PredictionObstacle~%perception_pb_msgs/PerceptionObstacle perception_obstacle ~%float64 time_stamp ~%float64 predicted_period ~%Trajectory[] trajectory ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: prediction_pb_msgs/Trajectory~%float64 probability ~%TrajectoryPoint[] trajectory_point ~%~%================================================================================~%MSG: prediction_pb_msgs/TrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 velocity ~%float64 t ~%float64 heading ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PredictionObstacles>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'prediction_obstacle) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PredictionObstacles>))
  "Converts a ROS message object to a list"
  (cl:list 'PredictionObstacles
    (cl:cons ':header (header msg))
    (cl:cons ':prediction_obstacle (prediction_obstacle msg))
))
