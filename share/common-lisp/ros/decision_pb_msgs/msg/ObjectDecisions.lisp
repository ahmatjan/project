; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude ObjectDecisions.msg.html

(cl:defclass <ObjectDecisions> (roslisp-msg-protocol:ros-message)
  ((decision
    :reader decision
    :initarg :decision
    :type (cl:vector decision_pb_msgs-msg:ObjectDecision)
   :initform (cl:make-array 0 :element-type 'decision_pb_msgs-msg:ObjectDecision :initial-element (cl:make-instance 'decision_pb_msgs-msg:ObjectDecision))))
)

(cl:defclass ObjectDecisions (<ObjectDecisions>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectDecisions>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectDecisions)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<ObjectDecisions> is deprecated: use decision_pb_msgs-msg:ObjectDecisions instead.")))

(cl:ensure-generic-function 'decision-val :lambda-list '(m))
(cl:defmethod decision-val ((m <ObjectDecisions>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:decision-val is deprecated.  Use decision_pb_msgs-msg:decision instead.")
  (decision m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectDecisions>) ostream)
  "Serializes a message object of type '<ObjectDecisions>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'decision))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'decision))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectDecisions>) istream)
  "Deserializes a message object of type '<ObjectDecisions>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'decision) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'decision)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'decision_pb_msgs-msg:ObjectDecision))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectDecisions>)))
  "Returns string type for a message object of type '<ObjectDecisions>"
  "decision_pb_msgs/ObjectDecisions")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectDecisions)))
  "Returns string type for a message object of type 'ObjectDecisions"
  "decision_pb_msgs/ObjectDecisions")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectDecisions>)))
  "Returns md5sum for a message object of type '<ObjectDecisions>"
  "f350af6d937109eae881094b92443486")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectDecisions)))
  "Returns md5sum for a message object of type 'ObjectDecisions"
  "f350af6d937109eae881094b92443486")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectDecisions>)))
  "Returns full string definition for message of type '<ObjectDecisions>"
  (cl:format cl:nil "ObjectDecision[] decision ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecision~%prediction_pb_msgs/PredictionObstacle prediction ~%string id ~%int32 type ~%ObjectDecisionType decision ~%~%================================================================================~%MSG: prediction_pb_msgs/PredictionObstacle~%perception_pb_msgs/PerceptionObstacle perception_obstacle ~%float64 time_stamp ~%float64 predicted_period ~%Trajectory[] trajectory ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: prediction_pb_msgs/Trajectory~%float64 probability ~%TrajectoryPoint[] trajectory_point ~%~%================================================================================~%MSG: prediction_pb_msgs/TrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 velocity ~%float64 t ~%float64 heading ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecisionType~%ObjectIgnore ignore ~%ObjectStop stop ~%ObjectFollow follow ~%ObjectYield yieldX ~%ObjectOvertake overtake ~%ObjectNudge nudge ~%ObjectSidePass sidepass ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectIgnore~%~%================================================================================~%MSG: decision_pb_msgs/ObjectStop~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectFollow~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectYield~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectOvertake~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectNudge~%float64 distance_l ~%int32 type ~%Range preferred_distance_l ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectSidePass~%float64 distance_s ~%Range preferred_distance_s ~%int32 type ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectDecisions)))
  "Returns full string definition for message of type 'ObjectDecisions"
  (cl:format cl:nil "ObjectDecision[] decision ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecision~%prediction_pb_msgs/PredictionObstacle prediction ~%string id ~%int32 type ~%ObjectDecisionType decision ~%~%================================================================================~%MSG: prediction_pb_msgs/PredictionObstacle~%perception_pb_msgs/PerceptionObstacle perception_obstacle ~%float64 time_stamp ~%float64 predicted_period ~%Trajectory[] trajectory ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: prediction_pb_msgs/Trajectory~%float64 probability ~%TrajectoryPoint[] trajectory_point ~%~%================================================================================~%MSG: prediction_pb_msgs/TrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 velocity ~%float64 t ~%float64 heading ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecisionType~%ObjectIgnore ignore ~%ObjectStop stop ~%ObjectFollow follow ~%ObjectYield yieldX ~%ObjectOvertake overtake ~%ObjectNudge nudge ~%ObjectSidePass sidepass ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectIgnore~%~%================================================================================~%MSG: decision_pb_msgs/ObjectStop~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectFollow~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectYield~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectOvertake~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectNudge~%float64 distance_l ~%int32 type ~%Range preferred_distance_l ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectSidePass~%float64 distance_s ~%Range preferred_distance_s ~%int32 type ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectDecisions>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'decision) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectDecisions>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectDecisions
    (cl:cons ':decision (decision msg))
))
