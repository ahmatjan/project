; Auto-generated. Do not edit!


(cl:in-package traffic_light_pb_msgs-msg)


;//! \htmlinclude TrafficLightDetection.msg.html

(cl:defclass <TrafficLightDetection> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type header_pb_msgs-msg:Header
    :initform (cl:make-instance 'header_pb_msgs-msg:Header))
   (traffic_light
    :reader traffic_light
    :initarg :traffic_light
    :type (cl:vector traffic_light_pb_msgs-msg:TrafficLight)
   :initform (cl:make-array 0 :element-type 'traffic_light_pb_msgs-msg:TrafficLight :initial-element (cl:make-instance 'traffic_light_pb_msgs-msg:TrafficLight))))
)

(cl:defclass TrafficLightDetection (<TrafficLightDetection>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TrafficLightDetection>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TrafficLightDetection)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name traffic_light_pb_msgs-msg:<TrafficLightDetection> is deprecated: use traffic_light_pb_msgs-msg:TrafficLightDetection instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TrafficLightDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader traffic_light_pb_msgs-msg:header-val is deprecated.  Use traffic_light_pb_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'traffic_light-val :lambda-list '(m))
(cl:defmethod traffic_light-val ((m <TrafficLightDetection>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader traffic_light_pb_msgs-msg:traffic_light-val is deprecated.  Use traffic_light_pb_msgs-msg:traffic_light instead.")
  (traffic_light m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TrafficLightDetection>) ostream)
  "Serializes a message object of type '<TrafficLightDetection>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'traffic_light))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'traffic_light))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TrafficLightDetection>) istream)
  "Deserializes a message object of type '<TrafficLightDetection>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'traffic_light) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'traffic_light)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'traffic_light_pb_msgs-msg:TrafficLight))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TrafficLightDetection>)))
  "Returns string type for a message object of type '<TrafficLightDetection>"
  "traffic_light_pb_msgs/TrafficLightDetection")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TrafficLightDetection)))
  "Returns string type for a message object of type 'TrafficLightDetection"
  "traffic_light_pb_msgs/TrafficLightDetection")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TrafficLightDetection>)))
  "Returns md5sum for a message object of type '<TrafficLightDetection>"
  "2f68f87c15857288408ca744423b3735")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TrafficLightDetection)))
  "Returns md5sum for a message object of type 'TrafficLightDetection"
  "2f68f87c15857288408ca744423b3735")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TrafficLightDetection>)))
  "Returns full string definition for message of type '<TrafficLightDetection>"
  (cl:format cl:nil "header_pb_msgs/Header header ~%TrafficLight[] traffic_light ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: traffic_light_pb_msgs/TrafficLight~%int32 color ~%string id ~%float64 confidence ~%float64 tracking_time ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TrafficLightDetection)))
  "Returns full string definition for message of type 'TrafficLightDetection"
  (cl:format cl:nil "header_pb_msgs/Header header ~%TrafficLight[] traffic_light ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: traffic_light_pb_msgs/TrafficLight~%int32 color ~%string id ~%float64 confidence ~%float64 tracking_time ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TrafficLightDetection>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'traffic_light) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TrafficLightDetection>))
  "Converts a ROS message object to a list"
  (cl:list 'TrafficLightDetection
    (cl:cons ':header (header msg))
    (cl:cons ':traffic_light (traffic_light msg))
))
