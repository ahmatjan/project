; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude JunctionOverlapInfo.msg.html

(cl:defclass <JunctionOverlapInfo> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass JunctionOverlapInfo (<JunctionOverlapInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JunctionOverlapInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JunctionOverlapInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<JunctionOverlapInfo> is deprecated: use hdmap_pb_msgs-msg:JunctionOverlapInfo instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JunctionOverlapInfo>) ostream)
  "Serializes a message object of type '<JunctionOverlapInfo>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JunctionOverlapInfo>) istream)
  "Deserializes a message object of type '<JunctionOverlapInfo>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JunctionOverlapInfo>)))
  "Returns string type for a message object of type '<JunctionOverlapInfo>"
  "hdmap_pb_msgs/JunctionOverlapInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JunctionOverlapInfo)))
  "Returns string type for a message object of type 'JunctionOverlapInfo"
  "hdmap_pb_msgs/JunctionOverlapInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JunctionOverlapInfo>)))
  "Returns md5sum for a message object of type '<JunctionOverlapInfo>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JunctionOverlapInfo)))
  "Returns md5sum for a message object of type 'JunctionOverlapInfo"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JunctionOverlapInfo>)))
  "Returns full string definition for message of type '<JunctionOverlapInfo>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JunctionOverlapInfo)))
  "Returns full string definition for message of type 'JunctionOverlapInfo"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JunctionOverlapInfo>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JunctionOverlapInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'JunctionOverlapInfo
))
