; Auto-generated. Do not edit!


(cl:in-package decision_pb_msgs-msg)


;//! \htmlinclude ObjectIgnore.msg.html

(cl:defclass <ObjectIgnore> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ObjectIgnore (<ObjectIgnore>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObjectIgnore>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObjectIgnore)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name decision_pb_msgs-msg:<ObjectIgnore> is deprecated: use decision_pb_msgs-msg:ObjectIgnore instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObjectIgnore>) ostream)
  "Serializes a message object of type '<ObjectIgnore>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObjectIgnore>) istream)
  "Deserializes a message object of type '<ObjectIgnore>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObjectIgnore>)))
  "Returns string type for a message object of type '<ObjectIgnore>"
  "decision_pb_msgs/ObjectIgnore")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObjectIgnore)))
  "Returns string type for a message object of type 'ObjectIgnore"
  "decision_pb_msgs/ObjectIgnore")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObjectIgnore>)))
  "Returns md5sum for a message object of type '<ObjectIgnore>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObjectIgnore)))
  "Returns md5sum for a message object of type 'ObjectIgnore"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObjectIgnore>)))
  "Returns full string definition for message of type '<ObjectIgnore>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObjectIgnore)))
  "Returns full string definition for message of type 'ObjectIgnore"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObjectIgnore>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObjectIgnore>))
  "Converts a ROS message object to a list"
  (cl:list 'ObjectIgnore
))
