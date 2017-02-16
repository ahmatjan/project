; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude DecisionResult.msg.html

(cl:defclass <DecisionResult> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type header_pb_msgs-msg:Header
    :initform (cl:make-instance 'header_pb_msgs-msg:Header))
   (object_decision
    :reader object_decision
    :initarg :object_decision
    :type decision_pb_msgs-msg:ObjectDecisions
    :initform (cl:make-instance 'decision_pb_msgs-msg:ObjectDecisions))
   (main_decision
    :reader main_decision
    :initarg :main_decision
    :type decision_pb_msgs-msg:MainDecision
    :initform (cl:make-instance 'decision_pb_msgs-msg:MainDecision)))
)

(cl:defclass DecisionResult (<DecisionResult>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DecisionResult>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DecisionResult)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<DecisionResult> is deprecated: use decision_pb_msgs-msg:DecisionResult instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <DecisionResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:header-val is deprecated.  Use decision_pb_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'object_decision-val :lambda-list '(m))
(cl:defmethod object_decision-val ((m <DecisionResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:object_decision-val is deprecated.  Use decision_pb_msgs-msg:object_decision instead.")
  (object_decision m))

(cl:ensure-generic-function 'main_decision-val :lambda-list '(m))
(cl:defmethod main_decision-val ((m <DecisionResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:main_decision-val is deprecated.  Use decision_pb_msgs-msg:main_decision instead.")
  (main_decision m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DecisionResult>) ostream)
  "Serializes a message object of type '<DecisionResult>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'object_decision) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'main_decision) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DecisionResult>) istream)
  "Deserializes a message object of type '<DecisionResult>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'object_decision) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'main_decision) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DecisionResult>)))
  "Returns string type for a message object of type '<DecisionResult>"
  "decision_pb_msgs/DecisionResult")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DecisionResult)))
  "Returns string type for a message object of type 'DecisionResult"
  "decision_pb_msgs/DecisionResult")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DecisionResult>)))
  "Returns md5sum for a message object of type '<DecisionResult>"
  "d8619ebeedaa9efa345046e0820c13b1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DecisionResult)))
  "Returns md5sum for a message object of type 'DecisionResult"
  "d8619ebeedaa9efa345046e0820c13b1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DecisionResult>)))
  "Returns full string definition for message of type '<DecisionResult>"
  (cl:format cl:nil "header_pb_msgs/Header header ~%ObjectDecisions object_decision ~%MainDecision main_decision ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecisions~%ObjectDecision[] decision ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecision~%prediction_pb_msgs/PredictionObstacle prediction ~%string id ~%int32 type ~%ObjectDecisionType decision ~%~%================================================================================~%MSG: prediction_pb_msgs/PredictionObstacle~%perception_pb_msgs/PerceptionObstacle perception_obstacle ~%float64 time_stamp ~%float64 predicted_period ~%Trajectory[] trajectory ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: prediction_pb_msgs/Trajectory~%float64 probability ~%TrajectoryPoint[] trajectory_point ~%~%================================================================================~%MSG: prediction_pb_msgs/TrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 velocity ~%float64 t ~%float64 heading ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecisionType~%ObjectIgnore ignore ~%ObjectStop stop ~%ObjectFollow follow ~%ObjectYield yieldX ~%ObjectOvertake overtake ~%ObjectNudge nudge ~%ObjectSidePass sidepass ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectIgnore~%~%================================================================================~%MSG: decision_pb_msgs/ObjectStop~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectFollow~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectYield~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectOvertake~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectNudge~%float64 distance_l ~%int32 type ~%Range preferred_distance_l ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectSidePass~%float64 distance_s ~%Range preferred_distance_s ~%int32 type ~%~%================================================================================~%MSG: decision_pb_msgs/MainDecision~%MainCruise cruise ~%MainStop stop ~%MainEmergencyStop estop ~%MainChangeLane change_lane ~%MainMissionComplete mission_complete ~%MainNotReady not_ready ~%TargetLane[] target_lane ~%~%================================================================================~%MSG: decision_pb_msgs/MainCruise~%~%================================================================================~%MSG: decision_pb_msgs/MainStop~%StopLine enforced_line ~%StopLine preferred_start ~%StopLine preferred_end ~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/StopLine~%string lane_id ~%float64 distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/MainEmergencyStop~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/MainChangeLane~%int32 type ~%~%================================================================================~%MSG: decision_pb_msgs/MainMissionComplete~%~%================================================================================~%MSG: decision_pb_msgs/MainNotReady~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/TargetLane~%string id ~%float64 start_s ~%float64 end_s ~%float64 speed_limit ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DecisionResult)))
  "Returns full string definition for message of type 'DecisionResult"
  (cl:format cl:nil "header_pb_msgs/Header header ~%ObjectDecisions object_decision ~%MainDecision main_decision ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecisions~%ObjectDecision[] decision ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecision~%prediction_pb_msgs/PredictionObstacle prediction ~%string id ~%int32 type ~%ObjectDecisionType decision ~%~%================================================================================~%MSG: prediction_pb_msgs/PredictionObstacle~%perception_pb_msgs/PerceptionObstacle perception_obstacle ~%float64 time_stamp ~%float64 predicted_period ~%Trajectory[] trajectory ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: prediction_pb_msgs/Trajectory~%float64 probability ~%TrajectoryPoint[] trajectory_point ~%~%================================================================================~%MSG: prediction_pb_msgs/TrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 velocity ~%float64 t ~%float64 heading ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecisionType~%ObjectIgnore ignore ~%ObjectStop stop ~%ObjectFollow follow ~%ObjectYield yieldX ~%ObjectOvertake overtake ~%ObjectNudge nudge ~%ObjectSidePass sidepass ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectIgnore~%~%================================================================================~%MSG: decision_pb_msgs/ObjectStop~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectFollow~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectYield~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectOvertake~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectNudge~%float64 distance_l ~%int32 type ~%Range preferred_distance_l ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectSidePass~%float64 distance_s ~%Range preferred_distance_s ~%int32 type ~%~%================================================================================~%MSG: decision_pb_msgs/MainDecision~%MainCruise cruise ~%MainStop stop ~%MainEmergencyStop estop ~%MainChangeLane change_lane ~%MainMissionComplete mission_complete ~%MainNotReady not_ready ~%TargetLane[] target_lane ~%~%================================================================================~%MSG: decision_pb_msgs/MainCruise~%~%================================================================================~%MSG: decision_pb_msgs/MainStop~%StopLine enforced_line ~%StopLine preferred_start ~%StopLine preferred_end ~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/StopLine~%string lane_id ~%float64 distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/MainEmergencyStop~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/MainChangeLane~%int32 type ~%~%================================================================================~%MSG: decision_pb_msgs/MainMissionComplete~%~%================================================================================~%MSG: decision_pb_msgs/MainNotReady~%string reason ~%~%================================================================================~%MSG: decision_pb_msgs/TargetLane~%string id ~%float64 start_s ~%float64 end_s ~%float64 speed_limit ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DecisionResult>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'object_decision))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'main_decision))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DecisionResult>))
  "Converts a ROS message object to a list"
  (cl:list 'DecisionResult
    (cl:cons ':header (header msg))
    (cl:cons ':object_decision (object_decision msg))
    (cl:cons ':main_decision (main_decision msg))
))
