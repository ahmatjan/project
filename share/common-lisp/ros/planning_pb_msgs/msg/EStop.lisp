; Auto-generated. Do not edit!


(cl:in-package planning_pb_msgs-msg)


;//! \htmlinclude EStop.msg.html

(cl:defclass <EStop> (roslisp-msg-protocol:ros-message)
  ((is_estop
    :reader is_estop
    :initarg :is_estop
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass EStop (<EStop>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EStop>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EStop)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planning_pb_msgs-msg:<EStop> is deprecated: use planning_pb_msgs-msg:EStop instead.")))

(cl:ensure-generic-function 'is_estop-val :lambda-list '(m))
(cl:defmethod is_estop-val ((m <EStop>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planning_pb_msgs-msg:is_estop-val is deprecated.  Use planning_pb_msgs-msg:is_estop instead.")
  (is_estop m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EStop>) ostream)
  "Serializes a message object of type '<EStop>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_estop) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EStop>) istream)
  "Deserializes a message object of type '<EStop>"
    (cl:setf (cl:slot-value msg 'is_estop) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EStop>)))
  "Returns string type for a message object of type '<EStop>"
  "planning_pb_msgs/EStop")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EStop)))
  "Returns string type for a message object of type 'EStop"
  "planning_pb_msgs/EStop")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EStop>)))
  "Returns md5sum for a message object of type '<EStop>"
  "f4581ae42ba8fbf872275b63a362b1de")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EStop)))
  "Returns md5sum for a message object of type 'EStop"
  "f4581ae42ba8fbf872275b63a362b1de")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EStop>)))
  "Returns full string definition for message of type '<EStop>"
  (cl:format cl:nil "bool is_estop ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EStop)))
  "Returns full string definition for message of type 'EStop"
  (cl:format cl:nil "bool is_estop ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EStop>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EStop>))
  "Converts a ROS message object to a list"
  (cl:list 'EStop
    (cl:cons ':is_estop (is_estop msg))
))
