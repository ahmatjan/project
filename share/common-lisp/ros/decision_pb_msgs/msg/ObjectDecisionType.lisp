; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude ObjectDecisionType.msg.html

(cl:defclass <ObjectDecisionType> (roslisp-msg-protocol:ros-message)
  ((ignore
    :reader ignore
    :initarg :ignore
    :type decision_pb_msgs-msg:ObjectIgnore
    :initform (cl:make-instance 'decision_pb_msgs-msg:ObjectIgnore))
   (stop
    :reader stop
    :initarg :stop
    :type decision_pb_msgs-msg:ObjectStop
    :initform (cl:make-instance 'decision_pb_msgs-msg:ObjectStop))
   (follow
    :reader follow
    :initarg :follow
    :type decision_pb_msgs-msg:ObjectFollow
    :initform (cl:make-instance 'decision_pb_msgs-msg:ObjectFollow))
   (yieldX
    :reader yieldX
    :initarg :yieldX
    :type decision_pb_msgs-msg:ObjectYield
    :initform (cl:make-instance 'decision_pb_msgs-msg:ObjectYield))
   (overtake
    :reader overtake
    :initarg :overtake
    :type decision_pb_msgs-msg:ObjectOvertake
    :initform (cl:make-instance 'decision_pb_msgs-msg:ObjectOvertake))
   (nudge
    :reader nudge
    :initarg :nudge
    :type decision_pb_msgs-msg:ObjectNudge
    :initform (cl:make-instance 'decision_pb_msgs-msg:ObjectNudge))
   (sidepass
    :reader sidepass
    :initarg :sidepass
    :type decision_pb_msgs-msg:ObjectSidePass
    :initform (cl:make-instance 'decision_pb_msgs-msg:ObjectSidePass)))
)

(cl:defclass ObjectDecisionType (<ObjectDecisionType>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectDecisionType>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectDecisionType)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<ObjectDecisionType> is deprecated: use decision_pb_msgs-msg:ObjectDecisionType instead.")))

(cl:ensure-generic-function 'ignore-val :lambda-list '(m))
(cl:defmethod ignore-val ((m <ObjectDecisionType>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:ignore-val is deprecated.  Use decision_pb_msgs-msg:ignore instead.")
  (ignore m))

(cl:ensure-generic-function 'stop-val :lambda-list '(m))
(cl:defmethod stop-val ((m <ObjectDecisionType>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:stop-val is deprecated.  Use decision_pb_msgs-msg:stop instead.")
  (stop m))

(cl:ensure-generic-function 'follow-val :lambda-list '(m))
(cl:defmethod follow-val ((m <ObjectDecisionType>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:follow-val is deprecated.  Use decision_pb_msgs-msg:follow instead.")
  (follow m))

(cl:ensure-generic-function 'yieldX-val :lambda-list '(m))
(cl:defmethod yieldX-val ((m <ObjectDecisionType>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:yieldX-val is deprecated.  Use decision_pb_msgs-msg:yieldX instead.")
  (yieldX m))

(cl:ensure-generic-function 'overtake-val :lambda-list '(m))
(cl:defmethod overtake-val ((m <ObjectDecisionType>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:overtake-val is deprecated.  Use decision_pb_msgs-msg:overtake instead.")
  (overtake m))

(cl:ensure-generic-function 'nudge-val :lambda-list '(m))
(cl:defmethod nudge-val ((m <ObjectDecisionType>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:nudge-val is deprecated.  Use decision_pb_msgs-msg:nudge instead.")
  (nudge m))

(cl:ensure-generic-function 'sidepass-val :lambda-list '(m))
(cl:defmethod sidepass-val ((m <ObjectDecisionType>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader decision_pb_msgs-msg:sidepass-val is deprecated.  Use decision_pb_msgs-msg:sidepass instead.")
  (sidepass m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectDecisionType>) ostream)
  "Serializes a message object of type '<ObjectDecisionType>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ignore) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'stop) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'follow) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'yieldX) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'overtake) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'nudge) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'sidepass) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectDecisionType>) istream)
  "Deserializes a message object of type '<ObjectDecisionType>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ignore) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'stop) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'follow) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'yieldX) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'overtake) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'nudge) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'sidepass) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectDecisionType>)))
  "Returns string type for a message object of type '<ObjectDecisionType>"
  "decision_pb_msgs/ObjectDecisionType")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectDecisionType)))
  "Returns string type for a message object of type 'ObjectDecisionType"
  "decision_pb_msgs/ObjectDecisionType")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectDecisionType>)))
  "Returns md5sum for a message object of type '<ObjectDecisionType>"
  "7880879315d35535b631c60df2769d46")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectDecisionType)))
  "Returns md5sum for a message object of type 'ObjectDecisionType"
  "7880879315d35535b631c60df2769d46")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectDecisionType>)))
  "Returns full string definition for message of type '<ObjectDecisionType>"
  (cl:format cl:nil "ObjectIgnore ignore ~%ObjectStop stop ~%ObjectFollow follow ~%ObjectYield yieldX ~%ObjectOvertake overtake ~%ObjectNudge nudge ~%ObjectSidePass sidepass ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectIgnore~%~%================================================================================~%MSG: decision_pb_msgs/ObjectStop~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectFollow~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectYield~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectOvertake~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectNudge~%float64 distance_l ~%int32 type ~%Range preferred_distance_l ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectSidePass~%float64 distance_s ~%Range preferred_distance_s ~%int32 type ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectDecisionType)))
  "Returns full string definition for message of type 'ObjectDecisionType"
  (cl:format cl:nil "ObjectIgnore ignore ~%ObjectStop stop ~%ObjectFollow follow ~%ObjectYield yieldX ~%ObjectOvertake overtake ~%ObjectNudge nudge ~%ObjectSidePass sidepass ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectIgnore~%~%================================================================================~%MSG: decision_pb_msgs/ObjectStop~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/Range~%float64 start ~%float64 end ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectFollow~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectYield~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectOvertake~%float64 distance_s ~%Range preferred_distance_s ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectNudge~%float64 distance_l ~%int32 type ~%Range preferred_distance_l ~%~%================================================================================~%MSG: decision_pb_msgs/ObjectSidePass~%float64 distance_s ~%Range preferred_distance_s ~%int32 type ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectDecisionType>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ignore))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'stop))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'follow))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'yieldX))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'overtake))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'nudge))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'sidepass))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectDecisionType>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectDecisionType
    (cl:cons ':ignore (ignore msg))
    (cl:cons ':stop (stop msg))
    (cl:cons ':follow (follow msg))
    (cl:cons ':yieldX (yieldX msg))
    (cl:cons ':overtake (overtake msg))
    (cl:cons ':nudge (nudge msg))
    (cl:cons ':sidepass (sidepass msg))
))
