; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude ObjectDecision.msg.html

(cl:defclass <ObjectDecision> (roslisp-msg-protocol:ros-message)
  ((prediction
    :reader prediction
    :initarg :prediction
    :type prediction_pb_msgs-msg:PredictionObstacle
    :initform (cl:make-instance 'prediction_pb_msgs-msg:PredictionObstacle))
   (id
    :reader id
    :initarg :id
    :type cl:string
    :initform "")
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (decision
    :reader decision
    :initarg :decision
    :type decision_pb_msgs-msg:ObjectDecisionType
    :initform (cl:make-instance 'decision_pb_msgs-msg:ObjectDecisionType)))
)

(cl:defclass ObjectDecision (<ObjectDecision>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectDecision>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectDecision)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<ObjectDecision> is deprecated: use decision_pb_msgs-msg:ObjectDecision instead.")))

(cl:ensure-generic-function 'prediction-val :lambda-list '(m))
(cl:defmethod prediction-val ((m <ObjectDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:prediction-val is deprecated.  Use decision_pb_msgs-msg:prediction instead.")
  (prediction m))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <ObjectDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:id-val is deprecated.  Use decision_pb_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <ObjectDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:type-val is deprecated.  Use decision_pb_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'decision-val :lambda-list '(m))
(cl:defmethod decision-val ((m <ObjectDecision>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:decision-val is deprecated.  Use decision_pb_msgs-msg:decision instead.")
  (decision m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectDecision>) ostream)
  "Serializes a message object of type '<ObjectDecision>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'prediction) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'id))
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'decision) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectDecision>) istream)
  "Deserializes a message object of type '<ObjectDecision>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'prediction) istream)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'id) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'decision) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectDecision>)))
  "Returns string type for a message object of type '<ObjectDecision>"
  "decision_pb_msgs/ObjectDecision")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectDecision)))
  "Returns string type for a message object of type 'ObjectDecision"
  "decision_pb_msgs/ObjectDecision")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectDecision>)))
  "Returns md5sum for a message object of type '<ObjectDecision>"
  "23407fe7e29b08e4de379e8cffc045f3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectDecision)))
  "Returns md5sum for a message object of type 'ObjectDecision"
  "23407fe7e29b08e4de379e8cffc045f3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectDecision>)))
  "Returns full string definition for message of type '<ObjectDecision>"
  (cl:format cl:nil "prediction_pb_msgs/PredictionObstacle prediction ~%string id ~%int32 type ~%ObjectDecisionType decision ~%~%================================================================================~%MSG: prediction_pb_msgs/PredictionObstacle~%perception_pb_msgs/PerceptionObstacle perception_obstacle ~%float64 time_stamp ~%float64 predicted_period ~%Trajectory[] trajectory ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: prediction_pb_msgs/Trajectory~%float64 probability ~%TrajectoryPoint[] trajectory_point ~%~%================================================================================~%MSG: prediction_pb_msgs/TrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 velocity ~%float64 t ~%float64 heading ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecisionType~%ObjectIgnore ignore ~%ObjectStop stop ~%ObjectFollow follow ~%ObjectYield yieldX ~%ObjectOvertake overtake ~%ObjectNudge nudge ~%ObjectSidePass sidepass ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectIgnore~%~%================================================================================~%MSG: decision_pb_msgs/ObjectStop~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectFollow~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectYield~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectOvertake~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectNudge~%float64 distance_l ~%int32 type ~%Range preferred_distance_l ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectSidePass~%float64 distance_s ~%Range preferred_distance_s ~%int32 type ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectDecision)))
  "Returns full string definition for message of type 'ObjectDecision"
  (cl:format cl:nil "prediction_pb_msgs/PredictionObstacle prediction ~%string id ~%int32 type ~%ObjectDecisionType decision ~%~%================================================================================~%MSG: prediction_pb_msgs/PredictionObstacle~%perception_pb_msgs/PerceptionObstacle perception_obstacle ~%float64 time_stamp ~%float64 predicted_period ~%Trajectory[] trajectory ~%~%================================================================================~%MSG: perception_pb_msgs/PerceptionObstacle~%int32 id ~%Point position ~%float64 theta ~%Point velocity ~%float64 length ~%float64 width ~%float64 height ~%Point[] polygon_point ~%float64 tracking_time ~%int32 type ~%float64 timestamp ~%~%================================================================================~%MSG: perception_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: prediction_pb_msgs/Trajectory~%float64 probability ~%TrajectoryPoint[] trajectory_point ~%~%================================================================================~%MSG: prediction_pb_msgs/TrajectoryPoint~%float64 x ~%float64 y ~%float64 z ~%float64 velocity ~%float64 t ~%float64 heading ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectDecisionType~%ObjectIgnore ignore ~%ObjectStop stop ~%ObjectFollow follow ~%ObjectYield yieldX ~%ObjectOvertake overtake ~%ObjectNudge nudge ~%ObjectSidePass sidepass ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectIgnore~%~%================================================================================~%MSG: decision_pb_msgs/ObjectStop~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectFollow~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectYield~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectOvertake~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectNudge~%float64 distance_l ~%int32 type ~%Range preferred_distance_l ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectSidePass~%float64 distance_s ~%Range preferred_distance_s ~%int32 type ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectDecision>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'prediction))
     4 (cl:length (cl:slot-value msg 'id))
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'decision))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectDecision>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectDecision
    (cl:cons ':prediction (prediction msg))
    (cl:cons ':id (id msg))
    (cl:cons ':type (type msg))
    (cl:cons ':decision (decision msg))
))
