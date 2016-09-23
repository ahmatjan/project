; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude MainMissionComplete.msg.html

(cl:defclass <MainMissionComplete> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass MainMissionComplete (<MainMissionComplete>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MainMissionComplete>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MainMissionComplete)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<MainMissionComplete> is deprecated: use decision_pb_msgs-msg:MainMissionComplete instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MainMissionComplete>) ostream)
  "Serializes a message object of type '<MainMissionComplete>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MainMissionComplete>) istream)
  "Deserializes a message object of type '<MainMissionComplete>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MainMissionComplete>)))
  "Returns string type for a message object of type '<MainMissionComplete>"
  "decision_pb_msgs/MainMissionComplete")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MainMissionComplete)))
  "Returns string type for a message object of type 'MainMissionComplete"
  "decision_pb_msgs/MainMissionComplete")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MainMissionComplete>)))
  "Returns md5sum for a message object of type '<MainMissionComplete>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MainMissionComplete)))
  "Returns md5sum for a message object of type 'MainMissionComplete"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MainMissionComplete>)))
  "Returns full string definition for message of type '<MainMissionComplete>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MainMissionComplete)))
  "Returns full string definition for message of type 'MainMissionComplete"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MainMissionComplete>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MainMissionComplete>))
  "Converts a ROS message object to a list"
  (cl:list 'MainMissionComplete
))
