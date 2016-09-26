; Auto-generated. Do not edit!


(cl:in-package routing_pb_msgs-msg)


;//! \htmlinclude RoutingRequest.msg.html

(cl:defclass <RoutingRequest> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type header_pb_msgs-msg:Header
    :initform (cl:make-instance 'header_pb_msgs-msg:Header))
   (start
    :reader start
    :initarg :start
    :type routing_pb_msgs-msg:LaneWaypoint
    :initform (cl:make-instance 'routing_pb_msgs-msg:LaneWaypoint))
   (end
    :reader end
    :initarg :end
    :type routing_pb_msgs-msg:LaneWaypoint
    :initform (cl:make-instance 'routing_pb_msgs-msg:LaneWaypoint))
   (blacklisted_lane
    :reader blacklisted_lane
    :initarg :blacklisted_lane
    :type (cl:vector routing_pb_msgs-msg:Lane)
   :initform (cl:make-array 0 :element-type 'routing_pb_msgs-msg:Lane :initial-element (cl:make-instance 'routing_pb_msgs-msg:Lane))))
)

(cl:defclass RoutingRequest (<RoutingRequest>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RoutingRequest>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RoutingRequest)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name routing_pb_msgs-msg:<RoutingRequest> is deprecated: use routing_pb_msgs-msg:RoutingRequest instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <RoutingRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:header-val is deprecated.  Use routing_pb_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'start-val :lambda-list '(m))
(cl:defmethod start-val ((m <RoutingRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:start-val is deprecated.  Use routing_pb_msgs-msg:start instead.")
  (start m))

(cl:ensure-generic-function 'end-val :lambda-list '(m))
(cl:defmethod end-val ((m <RoutingRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:end-val is deprecated.  Use routing_pb_msgs-msg:end instead.")
  (end m))

(cl:ensure-generic-function 'blacklisted_lane-val :lambda-list '(m))
(cl:defmethod blacklisted_lane-val ((m <RoutingRequest>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:blacklisted_lane-val is deprecated.  Use routing_pb_msgs-msg:blacklisted_lane instead.")
  (blacklisted_lane m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RoutingRequest>) ostream)
  "Serializes a message object of type '<RoutingRequest>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'start) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'end) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'blacklisted_lane))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'blacklisted_lane))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RoutingRequest>) istream)
  "Deserializes a message object of type '<RoutingRequest>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'start) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'end) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'blacklisted_lane) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'blacklisted_lane)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'routing_pb_msgs-msg:Lane))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RoutingRequest>)))
  "Returns string type for a message object of type '<RoutingRequest>"
  "routing_pb_msgs/RoutingRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RoutingRequest)))
  "Returns string type for a message object of type 'RoutingRequest"
  "routing_pb_msgs/RoutingRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RoutingRequest>)))
  "Returns md5sum for a message object of type '<RoutingRequest>"
  "4ec406a0c13a392eb58f483f1ae2b00e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RoutingRequest)))
  "Returns md5sum for a message object of type 'RoutingRequest"
  "4ec406a0c13a392eb58f483f1ae2b00e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RoutingRequest>)))
  "Returns full string definition for message of type '<RoutingRequest>"
  (cl:format cl:nil "header_pb_msgs/Header header ~%LaneWaypoint start ~%LaneWaypoint end ~%Lane[] blacklisted_lane ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: routing_pb_msgs/LaneWaypoint~%string id ~%float64 s ~%Pose pose ~%~%================================================================================~%MSG: routing_pb_msgs/Pose~%float64 x ~%float64 y ~%~%================================================================================~%MSG: routing_pb_msgs/Lane~%string id ~%float64 start_s ~%float64 end_s ~%float64 expired_timestamp ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RoutingRequest)))
  "Returns full string definition for message of type 'RoutingRequest"
  (cl:format cl:nil "header_pb_msgs/Header header ~%LaneWaypoint start ~%LaneWaypoint end ~%Lane[] blacklisted_lane ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: routing_pb_msgs/LaneWaypoint~%string id ~%float64 s ~%Pose pose ~%~%================================================================================~%MSG: routing_pb_msgs/Pose~%float64 x ~%float64 y ~%~%================================================================================~%MSG: routing_pb_msgs/Lane~%string id ~%float64 start_s ~%float64 end_s ~%float64 expired_timestamp ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RoutingRequest>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'start))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'end))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'blacklisted_lane) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RoutingRequest>))
  "Converts a ROS message object to a list"
  (cl:list 'RoutingRequest
    (cl:cons ':header (header msg))
    (cl:cons ':start (start msg))
    (cl:cons ':end (end msg))
    (cl:cons ':blacklisted_lane (blacklisted_lane msg))
))
