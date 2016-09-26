; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Curve.msg.html

(cl:defclass <Curve> (roslisp-msg-protocol:ros-message)
  ((segment
    :reader segment
    :initarg :segment
    :type (cl:vector hdmap_pb_msgs-msg:CurveSegment)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:CurveSegment :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:CurveSegment))))
)

(cl:defclass Curve (<Curve>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Curve>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Curve)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Curve> is deprecated: use hdmap_pb_msgs-msg:Curve instead.")))

(cl:ensure-generic-function 'segment-val :lambda-list '(m))
(cl:defmethod segment-val ((m <Curve>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:segment-val is deprecated.  Use hdmap_pb_msgs-msg:segment instead.")
  (segment m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Curve>) ostream)
  "Serializes a message object of type '<Curve>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'segment))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'segment))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Curve>) istream)
  "Deserializes a message object of type '<Curve>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'segment) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'segment)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:CurveSegment))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Curve>)))
  "Returns string type for a message object of type '<Curve>"
  "hdmap_pb_msgs/Curve")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Curve)))
  "Returns string type for a message object of type 'Curve"
  "hdmap_pb_msgs/Curve")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Curve>)))
  "Returns md5sum for a message object of type '<Curve>"
  "93ce92d809f0dd55169b5975cb379624")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Curve)))
  "Returns md5sum for a message object of type 'Curve"
  "93ce92d809f0dd55169b5975cb379624")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Curve>)))
  "Returns full string definition for message of type '<Curve>"
  (cl:format cl:nil "CurveSegment[] segment ~%~%================================================================================~%MSG: hdmap_pb_msgs/CurveSegment~%LineSegment line_segment ~%Arc arc ~%Spiral spiral ~%Spline spline ~%Poly3 poly3 ~%float64 s ~%Point start_position ~%float64 heading ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LineSegment~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: hdmap_pb_msgs/Arc~%Point center ~%float64 radius ~%float64 start_angle ~%float64 end_angle ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spiral~%float64 curv_start ~%float64 curv_end ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spline~%int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Poly3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Curve)))
  "Returns full string definition for message of type 'Curve"
  (cl:format cl:nil "CurveSegment[] segment ~%~%================================================================================~%MSG: hdmap_pb_msgs/CurveSegment~%LineSegment line_segment ~%Arc arc ~%Spiral spiral ~%Spline spline ~%Poly3 poly3 ~%float64 s ~%Point start_position ~%float64 heading ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LineSegment~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: hdmap_pb_msgs/Arc~%Point center ~%float64 radius ~%float64 start_angle ~%float64 end_angle ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spiral~%float64 curv_start ~%float64 curv_end ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spline~%int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Poly3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Curve>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'segment) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Curve>))
  "Converts a ROS message object to a list"
  (cl:list 'Curve
    (cl:cons ':segment (segment msg))
))
