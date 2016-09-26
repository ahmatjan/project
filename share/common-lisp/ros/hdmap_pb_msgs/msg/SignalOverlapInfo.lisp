; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude SignalOverlapInfo.msg.html

(cl:defclass <SignalOverlapInfo> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass SignalOverlapInfo (<SignalOverlapInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SignalOverlapInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SignalOverlapInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<SignalOverlapInfo> is deprecated: use hdmap_pb_msgs-msg:SignalOverlapInfo instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SignalOverlapInfo>) ostream)
  "Serializes a message object of type '<SignalOverlapInfo>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SignalOverlapInfo>) istream)
  "Deserializes a message object of type '<SignalOverlapInfo>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SignalOverlapInfo>)))
  "Returns string type for a message object of type '<SignalOverlapInfo>"
  "hdmap_pb_msgs/SignalOverlapInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SignalOverlapInfo)))
  "Returns string type for a message object of type 'SignalOverlapInfo"
  "hdmap_pb_msgs/SignalOverlapInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SignalOverlapInfo>)))
  "Returns md5sum for a message object of type '<SignalOverlapInfo>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SignalOverlapInfo)))
  "Returns md5sum for a message object of type 'SignalOverlapInfo"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SignalOverlapInfo>)))
  "Returns full string definition for message of type '<SignalOverlapInfo>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SignalOverlapInfo)))
  "Returns full string definition for message of type 'SignalOverlapInfo"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SignalOverlapInfo>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SignalOverlapInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'SignalOverlapInfo
))
