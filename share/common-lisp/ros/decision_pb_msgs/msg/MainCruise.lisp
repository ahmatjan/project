; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude MainCruise.msg.html

(cl:defclass <MainCruise> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass MainCruise (<MainCruise>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MainCruise>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MainCruise)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<MainCruise> is deprecated: use decision_pb_msgs-msg:MainCruise instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MainCruise>) ostream)
  "Serializes a message object of type '<MainCruise>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MainCruise>) istream)
  "Deserializes a message object of type '<MainCruise>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MainCruise>)))
  "Returns string type for a message object of type '<MainCruise>"
  "decision_pb_msgs/MainCruise")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MainCruise)))
  "Returns string type for a message object of type 'MainCruise"
  "decision_pb_msgs/MainCruise")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MainCruise>)))
  "Returns md5sum for a message object of type '<MainCruise>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MainCruise)))
  "Returns md5sum for a message object of type 'MainCruise"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MainCruise>)))
  "Returns full string definition for message of type '<MainCruise>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MainCruise)))
  "Returns full string definition for message of type 'MainCruise"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MainCruise>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MainCruise>))
  "Converts a ROS message object to a list"
  (cl:list 'MainCruise
))
