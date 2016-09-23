; Auto-generated. Do not edit!


(cl:in-package planning_pb_msgs-msg)


;//! \htmlinclude ADCSignals.msg.html

(cl:defclass <ADCSignals> (roslisp-msg-protocol:ros-message)
  ((signal
    :reader signal
    :initarg :signal
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass ADCSignals (<ADCSignals>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ADCSignals>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ADCSignals)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name planning_pb_msgs-msg:<ADCSignals> is deprecated: use planning_pb_msgs-msg:ADCSignals instead.")))

(cl:ensure-generic-function 'signal-val :lambda-list '(m))
(cl:defmethod signal-val ((m <ADCSignals>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader planning_pb_msgs-msg:signal-val is deprecated.  Use planning_pb_msgs-msg:signal instead.")
  (signal m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ADCSignals>) ostream)
  "Serializes a message object of type '<ADCSignals>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'signal))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'signal))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ADCSignals>) istream)
  "Deserializes a message object of type '<ADCSignals>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'signal) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'signal)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ADCSignals>)))
  "Returns string type for a message object of type '<ADCSignals>"
  "planning_pb_msgs/ADCSignals")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ADCSignals)))
  "Returns string type for a message object of type 'ADCSignals"
  "planning_pb_msgs/ADCSignals")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ADCSignals>)))
  "Returns md5sum for a message object of type '<ADCSignals>"
  "786b16910a7e35259323311767b0bde9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ADCSignals)))
  "Returns md5sum for a message object of type 'ADCSignals"
  "786b16910a7e35259323311767b0bde9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ADCSignals>)))
  "Returns full string definition for message of type '<ADCSignals>"
  (cl:format cl:nil "int32[] signal ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ADCSignals)))
  "Returns full string definition for message of type 'ADCSignals"
  (cl:format cl:nil "int32[] signal ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ADCSignals>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'signal) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ADCSignals>))
  "Converts a ROS message object to a list"
  (cl:list 'ADCSignals
    (cl:cons ':signal (signal msg))
))
