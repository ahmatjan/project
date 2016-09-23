; Auto-generated. Do not edit!


(cl:in-package prediction_pb_msgs-msg)


;//! \htmlinclude PredictionObstacle.msg.html

(cl:defclass <PredictionObstacle> (roslisp-msg-protocol:ros-message)
  ((perception_obstacle
    :reader perception_obstacle
    :initarg :perception_obstacle
    :type perception_pb_msgs-msg:PerceptionObstacle
    :initform (cl:make-instance 'perception_pb_msgs-msg:PerceptionObstacle))
   (time_stamp
    :reader time_stamp
    :initarg :time_stamp
    :type cl:float
    :initform 0.0)
   (predicted_period
    :reader predicted_period
    :initarg :predicted_period
    :type cl:float
    :initform 0.0)
   (trajectory
    :reader trajectory
    :initarg :trajectory
    :type (cl:vector prediction_pb_msgs-msg:Trajectory)
   :initform (cl:make-array 0 :element-type 'prediction_pb_msgs-msg:Trajectory :initial-element (cl:make-instance 'prediction_pb_msgs-msg:Trajectory))))
)

(cl:defclass PredictionObstacle (<PredictionObstacle>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PredictionObstacle>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PredictionObstacle)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name prediction_pb_msgs-msg:<PredictionObstacle> is deprecated: use prediction_pb_msgs-msg:PredictionObstacle instead.")))

(cl:ensure-generic-function 'perception_obstacle-val :lambda-list '(m))
(cl:defmethod perception_obstacle-val ((m <PredictionObstacle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader prediction_pb_msgs-msg:perception_obstacle-val is deprecated.  Use prediction_pb_msgs-msg:perception_obstacle instead.")
  (perception_obstacle m))

(cl:ensure-generic-function 'time_stamp-val :lambda-list '(m))
(cl:defmethod time_stamp-val ((m <PredictionObstacle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader prediction_pb_msgs-msg:time_stamp-val is deprecated.  Use prediction_pb_msgs-msg:time_stamp instead.")
  (time_stamp m))

(cl:ensure-generic-function 'predicted_period-val :lambda-list '(m))
(cl:defmethod predicted_period-val ((m <PredictionObstacle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader prediction_pb_msgs-msg:predicted_period-val is deprecated.  Use prediction_pb_msgs-msg:predicted_period instead.")
  (predicted_period m))

(cl:ensure-generic-function 'trajectory-val :lambda-list '(m))
(cl:defmethod trajectory-val ((m <PredictionObstacle>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader prediction_pb_msgs-msg:trajectory-val is deprecated.  Use prediction_pb_msgs-msg:trajectory instead.")
  (trajectory m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PredictionObstacle>) ostream)
  "Serializes a message object of type '<PredictionObstacle>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'perception_obstacle) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'time_stamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'predicted_period))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'trajectory))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'trajectory))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PredictionObstacle>) istream)
  "Deserializes a message object of type '<PredictionObstacle>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'perception_obstacle) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'time_stamp) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'predicted_period) (roslisp-utils:decode-double-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'trajectory) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'trajectory)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'prediction_pb_msgs-msg:Trajectory))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PredictionObstacle>)))
  "Returns string type for a message object of type '<PredictionObstacle>"
  "prediction_pb_msgs/PredictionObstacle")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PredictionObstacle)))
  "Returns string type for a message object of type 'PredictionObstacle"
  "prediction_pb_msgs/PredictionObstacle")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PredictionObstacle>)))
  "Returns md5sum for a message object of type '<PredictionObstacle>"
  "5df16a919530bc677fda038e8beea7c2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PredictionObstacle)))
  "Returns md5sum for a message object of type 'PredictionObstacle"
  "5df16a919530bc677fda038e8beea7c2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PredictionObstacle>)))
  "Returns full string definition for message of type '<PredictionObstacle>"
  (cl:format cl:nil "perception_pb_msgs/PerceptionObstacle perception_obstacle ~%float64 time_stamp ~%float64 predicted_period ~%Trajectory[] trajectory ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: prediction_pb_msgs/Trajectory~%float64 probability ~%TrajectoryPoint[] trajectory_point ~%~%================================================================================~%MSG: prediction_pb_msgs/TrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 velocity ~%float64 t ~%float64 heading ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PredictionObstacle)))
  "Returns full string definition for message of type 'PredictionObstacle"
  (cl:format cl:nil "perception_pb_msgs/PerceptionObstacle perception_obstacle ~%float64 time_stamp ~%float64 predicted_period ~%Trajectory[] trajectory ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: prediction_pb_msgs/Trajectory~%float64 probability ~%TrajectoryPoint[] trajectory_point ~%~%================================================================================~%MSG: prediction_pb_msgs/TrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 velocity ~%float64 t ~%float64 heading ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PredictionObstacle>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'perception_obstacle))
     8
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'trajectory) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PredictionObstacle>))
  "Converts a ROS message object to a list"
  (cl:list 'PredictionObstacle
    (cl:cons ':perception_obstacle (perception_obstacle msg))
    (cl:cons ':time_stamp (time_stamp msg))
    (cl:cons ':predicted_period (predicted_period msg))
    (cl:cons ':trajectory (trajectory msg))
))
