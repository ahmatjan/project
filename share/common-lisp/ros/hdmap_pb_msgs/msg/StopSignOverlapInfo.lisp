; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude StopSignOverlapInfo.msg.html

(cl:defclass <StopSignOverlapInfo> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass StopSignOverlapInfo (<StopSignOverlapInfo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StopSignOverlapInfo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StopSignOverlapInfo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<StopSignOverlapInfo> is deprecated: use hdmap_pb_msgs-msg:StopSignOverlapInfo instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StopSignOverlapInfo>) ostream)
  "Serializes a message object of type '<StopSignOverlapInfo>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StopSignOverlapInfo>) istream)
  "Deserializes a message object of type '<StopSignOverlapInfo>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StopSignOverlapInfo>)))
  "Returns string type for a message object of type '<StopSignOverlapInfo>"
  "hdmap_pb_msgs/StopSignOverlapInfo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StopSignOverlapInfo)))
  "Returns string type for a message object of type 'StopSignOverlapInfo"
  "hdmap_pb_msgs/StopSignOverlapInfo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StopSignOverlapInfo>)))
  "Returns md5sum for a message object of type '<StopSignOverlapInfo>"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StopSignOverlapInfo)))
  "Returns md5sum for a message object of type 'StopSignOverlapInfo"
  "d41d8cd98f00b204e9800998ecf8427e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StopSignOverlapInfo>)))
  "Returns full string definition for message of type '<StopSignOverlapInfo>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StopSignOverlapInfo)))
  "Returns full string definition for message of type 'StopSignOverlapInfo"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StopSignOverlapInfo>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StopSignOverlapInfo>))
  "Converts a ROS message object to a list"
  (cl:list 'StopSignOverlapInfo
))
