; Auto-generated. Do not edit!


(cl:in-package metric_msgs-srv)


;//! \htmlinclude Metric-request.msg.html

(cl:defclass <Metric-request> (roslisp-msg-protocol:ros-message)
  ((metric_name
    :reader metric_name
    :initarg :metric_name
    :type cl:string
    :initform ""))
)

(cl:defclass Metric-request (<Metric-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Metric-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Metric-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name metric_msgs-srv:<Metric-request> is deprecated: use metric_msgs-srv:Metric-request instead.")))

(cl:ensure-generic-function 'metric_name-val :lambda-list '(m))
(cl:defmethod metric_name-val ((m <Metric-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-srv:metric_name-val is deprecated.  Use metric_msgs-srv:metric_name instead.")
  (metric_name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Metric-request>) ostream)
  "Serializes a message object of type '<Metric-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'metric_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'metric_name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Metric-request>) istream)
  "Deserializes a message object of type '<Metric-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'metric_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'metric_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Metric-request>)))
  "Returns string type for a service object of type '<Metric-request>"
  "metric_msgs/MetricRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Metric-request)))
  "Returns string type for a service object of type 'Metric-request"
  "metric_msgs/MetricRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Metric-request>)))
  "Returns md5sum for a message object of type '<Metric-request>"
  "c2b94d4ff37f47487251d75339f8e9f9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Metric-request)))
  "Returns md5sum for a message object of type 'Metric-request"
  "c2b94d4ff37f47487251d75339f8e9f9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Metric-request>)))
  "Returns full string definition for message of type '<Metric-request>"
  (cl:format cl:nil "string metric_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Metric-request)))
  "Returns full string definition for message of type 'Metric-request"
  (cl:format cl:nil "string metric_name~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Metric-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'metric_name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Metric-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Metric-request
    (cl:cons ':metric_name (metric_name msg))
))
;//! \htmlinclude Metric-response.msg.html

(cl:defclass <Metric-response> (roslisp-msg-protocol:ros-message)
  ((status
    :reader status
    :initarg :status
    :type metric_msgs-msg:MetricStatus
    :initform (cl:make-instance 'metric_msgs-msg:MetricStatus)))
)

(cl:defclass Metric-response (<Metric-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Metric-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Metric-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name metric_msgs-srv:<Metric-response> is deprecated: use metric_msgs-srv:Metric-response instead.")))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <Metric-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader metric_msgs-srv:status-val is deprecated.  Use metric_msgs-srv:status instead.")
  (status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Metric-response>) ostream)
  "Serializes a message object of type '<Metric-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'status) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Metric-response>) istream)
  "Deserializes a message object of type '<Metric-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'status) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Metric-response>)))
  "Returns string type for a service object of type '<Metric-response>"
  "metric_msgs/MetricResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Metric-response)))
  "Returns string type for a service object of type 'Metric-response"
  "metric_msgs/MetricResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Metric-response>)))
  "Returns md5sum for a message object of type '<Metric-response>"
  "c2b94d4ff37f47487251d75339f8e9f9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Metric-response)))
  "Returns md5sum for a message object of type 'Metric-response"
  "c2b94d4ff37f47487251d75339f8e9f9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Metric-response>)))
  "Returns full string definition for message of type '<Metric-response>"
  (cl:format cl:nil "MetricStatus status~%~%~%================================================================================~%MSG: metric_msgs/MetricStatus~%uint8 OK=0~%uint8 WARN=1~%uint8 ERROR=2~%uint8 STALE=3~%~%uint8 level~%time stamp~%string message~%KeyValue[] values~%~%================================================================================~%MSG: metric_msgs/KeyValue~%string key~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Metric-response)))
  "Returns full string definition for message of type 'Metric-response"
  (cl:format cl:nil "MetricStatus status~%~%~%================================================================================~%MSG: metric_msgs/MetricStatus~%uint8 OK=0~%uint8 WARN=1~%uint8 ERROR=2~%uint8 STALE=3~%~%uint8 level~%time stamp~%string message~%KeyValue[] values~%~%================================================================================~%MSG: metric_msgs/KeyValue~%string key~%string value~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Metric-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'status))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Metric-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Metric-response
    (cl:cons ':status (status msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Metric)))
  'Metric-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Metric)))
  'Metric-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Metric)))
  "Returns string type for a service object of type '<Metric>"
  "metric_msgs/Metric")