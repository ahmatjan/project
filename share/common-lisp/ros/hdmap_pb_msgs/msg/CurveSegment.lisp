; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude CurveSegment.msg.html

(cl:defclass <CurveSegment> (roslisp-msg-protocol:ros-message)
  ((line_segment
    :reader line_segment
    :initarg :line_segment
    :type hdmap_pb_msgs-msg:LineSegment
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:LineSegment))
   (arc
    :reader arc
    :initarg :arc
    :type hdmap_pb_msgs-msg:Arc
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Arc))
   (spiral
    :reader spiral
    :initarg :spiral
    :type hdmap_pb_msgs-msg:Spiral
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Spiral))
   (spline
    :reader spline
    :initarg :spline
    :type hdmap_pb_msgs-msg:Spline
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Spline))
   (poly3
    :reader poly3
    :initarg :poly3
    :type hdmap_pb_msgs-msg:Poly3
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Poly3))
   (s
    :reader s
    :initarg :s
    :type cl:float
    :initform 0.0)
   (start_position
    :reader start_position
    :initarg :start_position
    :type hdmap_pb_msgs-msg:Point
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Point))
   (heading
    :reader heading
    :initarg :heading
    :type cl:float
    :initform 0.0)
   (length
    :reader length
    :initarg :length
    :type cl:float
    :initform 0.0))
)

(cl:defclass CurveSegment (<CurveSegment>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CurveSegment>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CurveSegment)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<CurveSegment> is deprecated: use hdmap_pb_msgs-msg:CurveSegment instead.")))

(cl:ensure-generic-function 'line_segment-val :lambda-list '(m))
(cl:defmethod line_segment-val ((m <CurveSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:line_segment-val is deprecated.  Use hdmap_pb_msgs-msg:line_segment instead.")
  (line_segment m))

(cl:ensure-generic-function 'arc-val :lambda-list '(m))
(cl:defmethod arc-val ((m <CurveSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:arc-val is deprecated.  Use hdmap_pb_msgs-msg:arc instead.")
  (arc m))

(cl:ensure-generic-function 'spiral-val :lambda-list '(m))
(cl:defmethod spiral-val ((m <CurveSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:spiral-val is deprecated.  Use hdmap_pb_msgs-msg:spiral instead.")
  (spiral m))

(cl:ensure-generic-function 'spline-val :lambda-list '(m))
(cl:defmethod spline-val ((m <CurveSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:spline-val is deprecated.  Use hdmap_pb_msgs-msg:spline instead.")
  (spline m))

(cl:ensure-generic-function 'poly3-val :lambda-list '(m))
(cl:defmethod poly3-val ((m <CurveSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:poly3-val is deprecated.  Use hdmap_pb_msgs-msg:poly3 instead.")
  (poly3 m))

(cl:ensure-generic-function 's-val :lambda-list '(m))
(cl:defmethod s-val ((m <CurveSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:s-val is deprecated.  Use hdmap_pb_msgs-msg:s instead.")
  (s m))

(cl:ensure-generic-function 'start_position-val :lambda-list '(m))
(cl:defmethod start_position-val ((m <CurveSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:start_position-val is deprecated.  Use hdmap_pb_msgs-msg:start_position instead.")
  (start_position m))

(cl:ensure-generic-function 'heading-val :lambda-list '(m))
(cl:defmethod heading-val ((m <CurveSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:heading-val is deprecated.  Use hdmap_pb_msgs-msg:heading instead.")
  (heading m))

(cl:ensure-generic-function 'length-val :lambda-list '(m))
(cl:defmethod length-val ((m <CurveSegment>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:length-val is deprecated.  Use hdmap_pb_msgs-msg:length instead.")
  (length m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CurveSegment>) ostream)
  "Serializes a message object of type '<CurveSegment>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'line_segment) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'arc) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'spiral) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'spline) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'poly3) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 's))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'start_position) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'heading))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CurveSegment>) istream)
  "Deserializes a message object of type '<CurveSegment>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'line_segment) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'arc) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'spiral) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'spline) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'poly3) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 's) (roslisp-utils:decode-double-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'start_position) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'heading) (roslisp-utils:decode-double-float-bits bits)))
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CurveSegment>)))
  "Returns string type for a message object of type '<CurveSegment>"
  "hdmap_pb_msgs/CurveSegment")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CurveSegment)))
  "Returns string type for a message object of type 'CurveSegment"
  "hdmap_pb_msgs/CurveSegment")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CurveSegment>)))
  "Returns md5sum for a message object of type '<CurveSegment>"
  "e8e639851340fc147eabd434b5f7c8bd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CurveSegment)))
  "Returns md5sum for a message object of type 'CurveSegment"
  "e8e639851340fc147eabd434b5f7c8bd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CurveSegment>)))
  "Returns full string definition for message of type '<CurveSegment>"
  (cl:format cl:nil "LineSegment line_segment ~%Arc arc ~%Spiral spiral ~%Spline spline ~%Poly3 poly3 ~%float64 s ~%Point start_position ~%float64 heading ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LineSegment~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: hdmap_pb_msgs/Arc~%Point center ~%float64 radius ~%float64 start_angle ~%float64 end_angle ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spiral~%float64 curv_start ~%float64 curv_end ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spline~%int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Poly3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CurveSegment)))
  "Returns full string definition for message of type 'CurveSegment"
  (cl:format cl:nil "LineSegment line_segment ~%Arc arc ~%Spiral spiral ~%Spline spline ~%Poly3 poly3 ~%float64 s ~%Point start_position ~%float64 heading ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LineSegment~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: hdmap_pb_msgs/Arc~%Point center ~%float64 radius ~%float64 start_angle ~%float64 end_angle ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spiral~%float64 curv_start ~%float64 curv_end ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spline~%int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Poly3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CurveSegment>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'line_segment))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'arc))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'spiral))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'spline))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'poly3))
     8
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'start_position))
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CurveSegment>))
  "Converts a ROS message object to a list"
  (cl:list 'CurveSegment
    (cl:cons ':line_segment (line_segment msg))
    (cl:cons ':arc (arc msg))
    (cl:cons ':spiral (spiral msg))
    (cl:cons ':spline (spline msg))
    (cl:cons ':poly3 (poly3 msg))
    (cl:cons ':s (s msg))
    (cl:cons ':start_position (start_position msg))
    (cl:cons ':heading (heading msg))
    (cl:cons ':length (length msg))
))
