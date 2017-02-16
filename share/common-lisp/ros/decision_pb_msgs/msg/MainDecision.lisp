; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude MainDecision.msg.html

(cl:defclass <MainDecision> (roslisp-msg-protocol:ros-message)
  ((cruise
    :reader cruise
    :initarg :cruise
    :type decision_pb_msgs-msg:MainCruise
    :initform (cl:make-instance 'decision_pb_msgs-msg:MainCruise))
   (stop
    :reader stop
    :initarg :stop
    :type decision_pb_msgs-msg:MainStop
    :initform (cl:make-instance 'decision_pb_msgs-msg:MainStop))
   (estop
    :reader estop
    :initarg :estop
    :type decision_pb_msgs-msg:MainEmergencyStop
    :initform (cl:make-instance 'decision_pb_msgs-msg:MainEmergencyStop))
   (change_lane
    :reader change_lane
    :initarg :change_lane
    :type decision_pb_msgs-msg:MainChangeLane
    :initform (cl:make-instance 'decision_pb_msgs-msg:MainChangeLane))
   (mission_complete
    :reader mission_complete
    :initarg :mission_complete
    :type decision_pb_msgs-msg:MainMissionComplete
    :initform (cl:make-instance 'decision_pb_msgs-msg:MainMissionComplete))
   (not_ready
    :reader not_ready
    :initarg :not_ready
    :type decision_pb_msgs-msg:MainNotReady
    :initform (cl:make-instance 'decision_pb_msgs-msg:MainNotReady))
   (target_lane
    :reader target_lane
    :initarg :target_lane
    :type (cl:vector decision_pb_msgs-msg:TargetLane)
   :initform (cl:make-array 0 :element-type 'decision_pb_msgs-msg:TargetLane :initial-element (cl:make-instance 'decision_pb_msgs-msg:TargetLane))))
)

(cl:defclass MainDecision (<MainDecision>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MainDecision>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MainDecision)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<MainDecision> is deprecated: use decision_pb_msgs-msg:MainDecision instead.")))

(cl:ensure-generic-function 'cruise-val :lambda-list '(m))
(cl:defmethod cruise-val ((m <MainDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:cruise-val is deprecated.  Use decision_pb_msgs-msg:cruise instead.")
  (cruise m))

(cl:ensure-generic-function 'stop-val :lambda-list '(m))
(cl:defmethod stop-val ((m <MainDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:stop-val is deprecated.  Use decision_pb_msgs-msg:stop instead.")
  (stop m))

(cl:ensure-generic-function 'estop-val :lambda-list '(m))
(cl:defmethod estop-val ((m <MainDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:estop-val is deprecated.  Use decision_pb_msgs-msg:estop instead.")
  (estop m))

(cl:ensure-generic-function 'change_lane-val :lambda-list '(m))
(cl:defmethod change_lane-val ((m <MainDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:change_lane-val is deprecated.  Use decision_pb_msgs-msg:change_lane instead.")
  (change_lane m))

(cl:ensure-generic-function 'mission_complete-val :lambda-list '(m))
(cl:defmethod mission_complete-val ((m <MainDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:mission_complete-val is deprecated.  Use decision_pb_msgs-msg:mission_complete instead.")
  (mission_complete m))

(cl:ensure-generic-function 'not_ready-val :lambda-list '(m))
(cl:defmethod not_ready-val ((m <MainDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:not_ready-val is deprecated.  Use decision_pb_msgs-msg:not_ready instead.")
  (not_ready m))

(cl:ensure-generic-function 'target_lane-val :lambda-list '(m))
(cl:defmethod target_lane-val ((m <MainDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:target_lane-val is deprecated.  Use decision_pb_msgs-msg:target_lane instead.")
  (target_lane m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MainDecision>) ostream)
  "Serializes a message object of type '<MainDecision>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'cruise) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'stop) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'estop) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'change_lane) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'mission_complete) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'not_ready) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'target_lane))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'target_lane))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MainDecision>) istream)
  "Deserializes a message object of type '<MainDecision>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'cruise) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'stop) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'estop) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'change_lane) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'mission_complete) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'not_ready) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'target_lane) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'target_lane)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'decision_pb_msgs-msg:TargetLane))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MainDecision>)))
  "Returns string type for a message object of type '<MainDecision>"
  "decision_pb_msgs/MainDecision")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MainDecision)))
  "Returns string type for a message object of type 'MainDecision"
  "decision_pb_msgs/MainDecision")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MainDecision>)))
  "Returns md5sum for a message object of type '<MainDecision>"
  "e968a6f5c0bd5824f0c8df13a58bf201")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MainDecision)))
  "Returns md5sum for a message object of type 'MainDecision"
  "e968a6f5c0bd5824f0c8df13a58bf201")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MainDecision>)))
  "Returns full string definition for message of type '<MainDecision>"
  (cl:format cl:nil "MainCruise cruise ~%MainStop stop ~%MainEmergencyStop estop ~%MainChangeLane change_lane ~%MainMissionComplete mission_complete ~%MainNotReady not_ready ~%TargetLane[] target_lane ~%~%================================================================================~%MSG: decision_pb_msgs/MainCruise~%~%================================================================================~%MSG: decision_pb_msgs/MainStop~%StopLine enforced_line ~%StopLine preferred_start ~%StopLine preferred_end ~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/StopLine~%string lane_id ~%float64 distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/MainEmergencyStop~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/MainChangeLane~%int32 type ~%~%================================================================================~%MSG: decision_pb_msgs/MainMissionComplete~%~%================================================================================~%MSG: decision_pb_msgs/MainNotReady~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/TargetLane~%string id ~%float64 start_s ~%float64 end_s ~%float64 speed_limit ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MainDecision)))
  "Returns full string definition for message of type 'MainDecision"
  (cl:format cl:nil "MainCruise cruise ~%MainStop stop ~%MainEmergencyStop estop ~%MainChangeLane change_lane ~%MainMissionComplete mission_complete ~%MainNotReady not_ready ~%TargetLane[] target_lane ~%~%================================================================================~%MSG: decision_pb_msgs/MainCruise~%~%================================================================================~%MSG: decision_pb_msgs/MainStop~%StopLine enforced_line ~%StopLine preferred_start ~%StopLine preferred_end ~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/StopLine~%string lane_id ~%float64 distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/MainEmergencyStop~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/MainChangeLane~%int32 type ~%~%================================================================================~%MSG: decision_pb_msgs/MainMissionComplete~%~%================================================================================~%MSG: decision_pb_msgs/MainNotReady~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/TargetLane~%string id ~%float64 start_s ~%float64 end_s ~%float64 speed_limit ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MainDecision>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'cruise))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'stop))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'estop))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'change_lane))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'mission_complete))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'not_ready))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'target_lane) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MainDecision>))
  "Converts a ROS message object to a list"
  (cl:list 'MainDecision
    (cl:cons ':cruise (cruise msg))
    (cl:cons ':stop (stop msg))
    (cl:cons ':estop (estop msg))
    (cl:cons ':change_lane (change_lane msg))
    (cl:cons ':mission_complete (mission_complete msg))
    (cl:cons ':not_ready (not_ready msg))
    (cl:cons ':target_lane (target_lane msg))
))
