; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude CrosswalkOverlapInfo.msg.html

(cl:defclass <CrosswalkOverlapInfo> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass CrosswalkOverlapInfo (<CrosswalkOverlapInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CrosswalkOverlapInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CrosswalkOverlapInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<CrosswalkOverlapInfo> is deprecated: use hdmap_pb_msgs-msg:CrosswalkOverlapInfo instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CrosswalkOverlapInfo>) ostream)
  "Serializes a message object of type '<CrosswalkOverlapInfo>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CrosswalkOverlapInfo>) istream)
  "Deserializes a message object of type '<CrosswalkOverlapInfo>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CrosswalkOverlapInfo>)))
  "Returns string type for a message object of type '<CrosswalkOverlapInfo>"
  "hdmap_pb_msgs/CrosswalkOverlapInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CrosswalkOverlapInfo)))
  "Returns string type for a message object of type 'CrosswalkOverlapInfo"
  "hdmap_pb_msgs/CrosswalkOverlapInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CrosswalkOverlapInfo>)))
  "Returns md5sum for a message object of type '<CrosswalkOverlapInfo>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CrosswalkOverlapInfo)))
  "Returns md5sum for a message object of type 'CrosswalkOverlapInfo"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CrosswalkOverlapInfo>)))
  "Returns full string definition for message of type '<CrosswalkOverlapInfo>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CrosswalkOverlapInfo)))
  "Returns full string definition for message of type 'CrosswalkOverlapInfo"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CrosswalkOverlapInfo>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CrosswalkOverlapInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'CrosswalkOverlapInfo
))
