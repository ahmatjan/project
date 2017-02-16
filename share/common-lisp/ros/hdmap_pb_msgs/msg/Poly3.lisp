; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Poly3.msg.html

(cl:defclass <Poly3> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Poly3 (<Poly3>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Poly3>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Poly3)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Poly3> is deprecated: use hdmap_pb_msgs-msg:Poly3 instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Poly3>) ostream)
  "Serializes a message object of type '<Poly3>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Poly3>) istream)
  "Deserializes a message object of type '<Poly3>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Poly3>)))
  "Returns string type for a message object of type '<Poly3>"
  "hdmap_pb_msgs/Poly3")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Poly3)))
  "Returns string type for a message object of type 'Poly3"
  "hdmap_pb_msgs/Poly3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Poly3>)))
  "Returns md5sum for a message object of type '<Poly3>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Poly3)))
  "Returns md5sum for a message object of type 'Poly3"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Poly3>)))
  "Returns full string definition for message of type '<Poly3>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Poly3)))
  "Returns full string definition for message of type 'Poly3"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Poly3>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Poly3>))
  "Converts a ROS message object to a list"
  (cl:list 'Poly3
))
