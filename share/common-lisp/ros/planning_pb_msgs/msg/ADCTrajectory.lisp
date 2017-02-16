; Auto-generated. Do not edit!


(cl:in-package planning_pb_msgs-msg)


;//! \htmlinclude ADCTrajectory.msg.html

(cl:defclass <ADCTrajectory> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type header_pb_msgs-msg:Header
    :initform (cl:make-instance 'header_pb_msgs-msg:Header))
   (total_path_length
    :reader total_path_length
    :initarg :total_path_length
    :type cl:float
    :initform 0.0)
   (total_path_time
    :reader total_path_time
    :initarg :total_path_time
    :type cl:float
    :initform 0.0)
   (adc_trajectory_point
    :reader adc_trajectory_point
    :initarg :adc_trajectory_point
    :type (cl:vector planning_pb_msgs-msg:ADCTrajectoryPoint)
   :initform (cl:make-array 0 :element-type 'planning_pb_msgs-msg:ADCTrajectoryPoint :initial-element (cl:make-instance 'planning_pb_msgs-msg:ADCTrajectoryPoint)))
   (signals
    :reader signals
    :initarg :signals
    :type planning_pb_msgs-msg:ADCSignals
    :initform (cl:make-instance 'planning_pb_msgs-msg:ADCSignals))
   (estop
    :reader estop
    :initarg :estop
    :type planning_pb_msgs-msg:EStop
    :initform (cl:make-instance 'planning_pb_msgs-msg:EStop)))
)

(cl:defclass ADCTrajectory (<ADCTrajectory>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ADCTrajectory>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ADCTrajectory)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planning_pb_msgs-msg:<ADCTrajectory> is deprecated: use planning_pb_msgs-msg:ADCTrajectory instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ADCTrajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planning_pb_msgs-msg:header-val is deprecated.  Use planning_pb_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'total_path_length-val :lambda-list '(m))
(cl:defmethod total_path_length-val ((m <ADCTrajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planning_pb_msgs-msg:total_path_length-val is deprecated.  Use planning_pb_msgs-msg:total_path_length instead.")
  (total_path_length m))

(cl:ensure-generic-function 'total_path_time-val :lambda-list '(m))
(cl:defmethod total_path_time-val ((m <ADCTrajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planning_pb_msgs-msg:total_path_time-val is deprecated.  Use planning_pb_msgs-msg:total_path_time instead.")
  (total_path_time m))

(cl:ensure-generic-function 'adc_trajectory_point-val :lambda-list '(m))
(cl:defmethod adc_trajectory_point-val ((m <ADCTrajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planning_pb_msgs-msg:adc_trajectory_point-val is deprecated.  Use planning_pb_msgs-msg:adc_trajectory_point instead.")
  (adc_trajectory_point m))

(cl:ensure-generic-function 'signals-val :lambda-list '(m))
(cl:defmethod signals-val ((m <ADCTrajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planning_pb_msgs-msg:signals-val is deprecated.  Use planning_pb_msgs-msg:signals instead.")
  (signals m))

(cl:ensure-generic-function 'estop-val :lambda-list '(m))
(cl:defmethod estop-val ((m <ADCTrajectory>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planning_pb_msgs-msg:estop-val is deprecated.  Use planning_pb_msgs-msg:estop instead.")
  (estop m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ADCTrajectory>) ostream)
  "Serializes a message object of type '<ADCTrajectory>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'total_path_length))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'total_path_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'adc_trajectory_point))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'adc_trajectory_point))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'signals) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'estop) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ADCTrajectory>) istream)
  "Deserializes a message object of type '<ADCTrajectory>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'total_path_length) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'total_path_time) (roslisp-utils:decode-double-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'adc_trajectory_point) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'adc_trajectory_point)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'planning_pb_msgs-msg:ADCTrajectoryPoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'signals) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'estop) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ADCTrajectory>)))
  "Returns string type for a message object of type '<ADCTrajectory>"
  "planning_pb_msgs/ADCTrajectory")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ADCTrajectory)))
  "Returns string type for a message object of type 'ADCTrajectory"
  "planning_pb_msgs/ADCTrajectory")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ADCTrajectory>)))
  "Returns md5sum for a message object of type '<ADCTrajectory>"
  "6ef5874ef63757681a9300e97f2345d2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ADCTrajectory)))
  "Returns md5sum for a message object of type 'ADCTrajectory"
  "6ef5874ef63757681a9300e97f2345d2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ADCTrajectory>)))
  "Returns full string definition for message of type '<ADCTrajectory>"
  (cl:format cl:nil "header_pb_msgs/Header header ~%float64 total_path_length ~%float64 total_path_time ~%ADCTrajectoryPoint[] adc_trajectory_point ~%ADCSignals signals ~%EStop estop ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: planning_pb_msgs/ADCTrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 s ~%float64 l ~%float64 speed ~%float64 acceleration_s ~%float64 curvature ~%float64 curvature_change_rate ~%float64 relative_time ~%float64 theta ~%~%================================================================================~%MSG: planning_pb_msgs/ADCSignals~%int32[] signal ~%~%================================================================================~%MSG: planning_pb_msgs/EStop~%bool is_estop ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ADCTrajectory)))
  "Returns full string definition for message of type 'ADCTrajectory"
  (cl:format cl:nil "header_pb_msgs/Header header ~%float64 total_path_length ~%float64 total_path_time ~%ADCTrajectoryPoint[] adc_trajectory_point ~%ADCSignals signals ~%EStop estop ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: planning_pb_msgs/ADCTrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 s ~%float64 l ~%float64 speed ~%float64 acceleration_s ~%float64 curvature ~%float64 curvature_change_rate ~%float64 relative_time ~%float64 theta ~%~%================================================================================~%MSG: planning_pb_msgs/ADCSignals~%int32[] signal ~%~%================================================================================~%MSG: planning_pb_msgs/EStop~%bool is_estop ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ADCTrajectory>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     8
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'adc_trajectory_point) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'signals))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'estop))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ADCTrajectory>))
  "Converts a ROS message object to a list"
  (cl:list 'ADCTrajectory
    (cl:cons ':header (header msg))
    (cl:cons ':total_path_length (total_path_length msg))
    (cl:cons ':total_path_time (total_path_time msg))
    (cl:cons ':adc_trajectory_point (adc_trajectory_point msg))
    (cl:cons ':signals (signals msg))
    (cl:cons ':estop (estop msg))
))
