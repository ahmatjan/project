; Auto-generated. Do not edit!


(cl:in-package routing_pb_msgs-msg)


;//! \htmlinclude RoutingResult.msg.html

(cl:defclass <RoutingResult> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type header_pb_msgs-msg:Header
    :initform (cl:make-instance 'header_pb_msgs-msg:Header))
   (route
    :reader route
    :initarg :route
    :type (cl:vector routing_pb_msgs-msg:LaneSegment)
   :initform (cl:make-array 0 :element-type 'routing_pb_msgs-msg:LaneSegment :initial-element (cl:make-instance 'routing_pb_msgs-msg:LaneSegment)))
   (measurement
    :reader measurement
    :initarg :measurement
    :type routing_pb_msgs-msg:Measurement
    :initform (cl:make-instance 'routing_pb_msgs-msg:Measurement))
   (routing_request
    :reader routing_request
    :initarg :routing_request
    :type routing_pb_msgs-msg:RoutingRequest
    :initform (cl:make-instance 'routing_pb_msgs-msg:RoutingRequest)))
)

(cl:defclass RoutingResult (<RoutingResult>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <RoutingResult>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'RoutingResult)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name routing_pb_msgs-msg:<RoutingResult> is deprecated: use routing_pb_msgs-msg:RoutingResult instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <RoutingResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:header-val is deprecated.  Use routing_pb_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'route-val :lambda-list '(m))
(cl:defmethod route-val ((m <RoutingResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:route-val is deprecated.  Use routing_pb_msgs-msg:route instead.")
  (route m))

(cl:ensure-generic-function 'measurement-val :lambda-list '(m))
(cl:defmethod measurement-val ((m <RoutingResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:measurement-val is deprecated.  Use routing_pb_msgs-msg:measurement instead.")
  (measurement m))

(cl:ensure-generic-function 'routing_request-val :lambda-list '(m))
(cl:defmethod routing_request-val ((m <RoutingResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader routing_pb_msgs-msg:routing_request-val is deprecated.  Use routing_pb_msgs-msg:routing_request instead.")
  (routing_request m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <RoutingResult>) ostream)
  "Serializes a message object of type '<RoutingResult>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'route))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'route))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'measurement) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'routing_request) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <RoutingResult>) istream)
  "Deserializes a message object of type '<RoutingResult>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'route) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'route)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'routing_pb_msgs-msg:LaneSegment))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'measurement) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'routing_request) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<RoutingResult>)))
  "Returns string type for a message object of type '<RoutingResult>"
  "routing_pb_msgs/RoutingResult")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'RoutingResult)))
  "Returns string type for a message object of type 'RoutingResult"
  "routing_pb_msgs/RoutingResult")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<RoutingResult>)))
  "Returns md5sum for a message object of type '<RoutingResult>"
  "5459d2d70c199ebceeae7cbfed8d9dca")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'RoutingResult)))
  "Returns md5sum for a message object of type 'RoutingResult"
  "5459d2d70c199ebceeae7cbfed8d9dca")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<RoutingResult>)))
  "Returns full string definition for message of type '<RoutingResult>"
  (cl:format cl:nil "header_pb_msgs/Header header ~%LaneSegment[] route ~%Measurement measurement ~%RoutingRequest routing_request ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: routing_pb_msgs/LaneSegment~%string id ~%float64 start_s ~%float64 end_s ~%~%================================================================================~%MSG: routing_pb_msgs/Measurement~%float64 distance ~%~%================================================================================~%MSG: routing_pb_msgs/RoutingRequest~%header_pb_msgs/Header header ~%LaneWaypoint start ~%LaneWaypoint end ~%Lane[] blacklisted_lane ~%~%================================================================================~%MSG: routing_pb_msgs/LaneWaypoint~%string id ~%float64 s ~%Pose pose ~%~%================================================================================~%MSG: routing_pb_msgs/Pose~%float64 x ~%float64 y ~%~%================================================================================~%MSG: routing_pb_msgs/Lane~%string id ~%float64 start_s ~%float64 end_s ~%float64 expired_timestamp ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'RoutingResult)))
  "Returns full string definition for message of type 'RoutingResult"
  (cl:format cl:nil "header_pb_msgs/Header header ~%LaneSegment[] route ~%Measurement measurement ~%RoutingRequest routing_request ~%~%================================================================================~%MSG: header_pb_msgs/Header~%float64 timestamp_sec ~%string module_name ~%uint32 sequence_num ~%~%================================================================================~%MSG: routing_pb_msgs/LaneSegment~%string id ~%float64 start_s ~%float64 end_s ~%~%================================================================================~%MSG: routing_pb_msgs/Measurement~%float64 distance ~%~%================================================================================~%MSG: routing_pb_msgs/RoutingRequest~%header_pb_msgs/Header header ~%LaneWaypoint start ~%LaneWaypoint end ~%Lane[] blacklisted_lane ~%~%================================================================================~%MSG: routing_pb_msgs/LaneWaypoint~%string id ~%float64 s ~%Pose pose ~%~%================================================================================~%MSG: routing_pb_msgs/Pose~%float64 x ~%float64 y ~%~%================================================================================~%MSG: routing_pb_msgs/Lane~%string id ~%float64 start_s ~%float64 end_s ~%float64 expired_timestamp ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <RoutingResult>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'route) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'measurement))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'routing_request))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <RoutingResult>))
  "Converts a ROS message object to a list"
  (cl:list 'RoutingResult
    (cl:cons ':header (header msg))
    (cl:cons ':route (route msg))
    (cl:cons ':measurement (measurement msg))
    (cl:cons ':routing_request (routing_request msg))
))
