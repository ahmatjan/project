; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude LaneBoundary.msg.html

(cl:defclass <LaneBoundary> (roslisp-msg-protocol:ros-message)
  ((curve
    :reader curve
    :initarg :curve
    :type hdmap_pb_msgs-msg:Curve
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Curve))
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (length
    :reader length
    :initarg :length
    :type cl:float
    :initform 0.0))
)

(cl:defclass LaneBoundary (<LaneBoundary>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LaneBoundary>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LaneBoundary)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<LaneBoundary> is deprecated: use hdmap_pb_msgs-msg:LaneBoundary instead.")))

(cl:ensure-generic-function 'curve-val :lambda-list '(m))
(cl:defmethod curve-val ((m <LaneBoundary>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:curve-val is deprecated.  Use hdmap_pb_msgs-msg:curve instead.")
  (curve m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <LaneBoundary>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:type-val is deprecated.  Use hdmap_pb_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'length-val :lambda-list '(m))
(cl:defmethod length-val ((m <LaneBoundary>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:length-val is deprecated.  Use hdmap_pb_msgs-msg:length instead.")
  (length m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LaneBoundary>) ostream)
  "Serializes a message object of type '<LaneBoundary>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'curve) ostream)
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'length))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LaneBoundary>) istream)
  "Deserializes a message object of type '<LaneBoundary>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'curve) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'length) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LaneBoundary>)))
  "Returns string type for a message object of type '<LaneBoundary>"
  "hdmap_pb_msgs/LaneBoundary")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LaneBoundary)))
  "Returns string type for a message object of type 'LaneBoundary"
  "hdmap_pb_msgs/LaneBoundary")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LaneBoundary>)))
  "Returns md5sum for a message object of type '<LaneBoundary>"
  "9eb3bfaf6ce2ab83411a6c2b48625d75")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LaneBoundary)))
  "Returns md5sum for a message object of type 'LaneBoundary"
  "9eb3bfaf6ce2ab83411a6c2b48625d75")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LaneBoundary>)))
  "Returns full string definition for message of type '<LaneBoundary>"
  (cl:format cl:nil "Curve curve ~%int32 type ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/Curve~%CurveSegment[] segment ~%~%================================================================================~%MSG: hdmap_pb_msgs/CurveSegment~%LineSegment line_segment ~%Arc arc ~%Spiral spiral ~%Spline spline ~%Poly3 poly3 ~%float64 s ~%Point start_position ~%float64 heading ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LineSegment~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: hdmap_pb_msgs/Arc~%Point center ~%float64 radius ~%float64 start_angle ~%float64 end_angle ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spiral~%float64 curv_start ~%float64 curv_end ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spline~%int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Poly3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LaneBoundary)))
  "Returns full string definition for message of type 'LaneBoundary"
  (cl:format cl:nil "Curve curve ~%int32 type ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/Curve~%CurveSegment[] segment ~%~%================================================================================~%MSG: hdmap_pb_msgs/CurveSegment~%LineSegment line_segment ~%Arc arc ~%Spiral spiral ~%Spline spline ~%Poly3 poly3 ~%float64 s ~%Point start_position ~%float64 heading ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LineSegment~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: hdmap_pb_msgs/Arc~%Point center ~%float64 radius ~%float64 start_angle ~%float64 end_angle ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spiral~%float64 curv_start ~%float64 curv_end ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spline~%int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Poly3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LaneBoundary>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'curve))
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LaneBoundary>))
  "Converts a ROS message object to a list"
  (cl:list 'LaneBoundary
    (cl:cons ':curve (curve msg))
    (cl:cons ':type (type msg))
    (cl:cons ':length (length msg))
))
