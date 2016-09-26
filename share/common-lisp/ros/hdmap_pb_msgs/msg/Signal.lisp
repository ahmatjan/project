; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Signal.msg.html

(cl:defclass <Signal> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type hdmap_pb_msgs-msg:Id
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Id))
   (boundary
    :reader boundary
    :initarg :boundary
    :type hdmap_pb_msgs-msg:Polygon
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Polygon))
   (subsignal
    :reader subsignal
    :initarg :subsignal
    :type (cl:vector hdmap_pb_msgs-msg:Subsignal)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Subsignal :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Subsignal)))
   (overlap_id
    :reader overlap_id
    :initarg :overlap_id
    :type (cl:vector hdmap_pb_msgs-msg:Id)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Id :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Id)))
   (type
    :reader type
    :initarg :type
    :type cl:integer
    :initform 0)
   (stop_line
    :reader stop_line
    :initarg :stop_line
    :type (cl:vector hdmap_pb_msgs-msg:Curve)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Curve :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Curve))))
)

(cl:defclass Signal (<Signal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Signal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Signal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Signal> is deprecated: use hdmap_pb_msgs-msg:Signal instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Signal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:id-val is deprecated.  Use hdmap_pb_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'boundary-val :lambda-list '(m))
(cl:defmethod boundary-val ((m <Signal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:boundary-val is deprecated.  Use hdmap_pb_msgs-msg:boundary instead.")
  (boundary m))

(cl:ensure-generic-function 'subsignal-val :lambda-list '(m))
(cl:defmethod subsignal-val ((m <Signal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:subsignal-val is deprecated.  Use hdmap_pb_msgs-msg:subsignal instead.")
  (subsignal m))

(cl:ensure-generic-function 'overlap_id-val :lambda-list '(m))
(cl:defmethod overlap_id-val ((m <Signal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:overlap_id-val is deprecated.  Use hdmap_pb_msgs-msg:overlap_id instead.")
  (overlap_id m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <Signal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:type-val is deprecated.  Use hdmap_pb_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'stop_line-val :lambda-list '(m))
(cl:defmethod stop_line-val ((m <Signal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:stop_line-val is deprecated.  Use hdmap_pb_msgs-msg:stop_line instead.")
  (stop_line m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Signal>) ostream)
  "Serializes a message object of type '<Signal>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'id) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'boundary) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'subsignal))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'subsignal))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'overlap_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'overlap_id))
  (cl:let* ((signed (cl:slot-value msg 'type)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'stop_line))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'stop_line))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Signal>) istream)
  "Deserializes a message object of type '<Signal>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'id) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'boundary) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'subsignal) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'subsignal)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Subsignal))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'overlap_id) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'overlap_id)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Id))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'stop_line) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'stop_line)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Curve))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Signal>)))
  "Returns string type for a message object of type '<Signal>"
  "hdmap_pb_msgs/Signal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Signal)))
  "Returns string type for a message object of type 'Signal"
  "hdmap_pb_msgs/Signal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Signal>)))
  "Returns md5sum for a message object of type '<Signal>"
  "aa6df01c6aad20d364660ddf75a2c1c5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Signal)))
  "Returns md5sum for a message object of type 'Signal"
  "aa6df01c6aad20d364660ddf75a2c1c5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Signal>)))
  "Returns full string definition for message of type '<Signal>"
  (cl:format cl:nil "Id id ~%Polygon boundary ~%Subsignal[] subsignal ~%Id[] overlap_id ~%int32 type ~%Curve[] stop_line ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Polygon~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: hdmap_pb_msgs/Subsignal~%Id id ~%int32 type ~%Point location ~%~%================================================================================~%MSG: hdmap_pb_msgs/Curve~%CurveSegment[] segment ~%~%================================================================================~%MSG: hdmap_pb_msgs/CurveSegment~%LineSegment line_segment ~%Arc arc ~%Spiral spiral ~%Spline spline ~%Poly3 poly3 ~%float64 s ~%Point start_position ~%float64 heading ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LineSegment~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Arc~%Point center ~%float64 radius ~%float64 start_angle ~%float64 end_angle ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spiral~%float64 curv_start ~%float64 curv_end ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spline~%int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Poly3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Signal)))
  "Returns full string definition for message of type 'Signal"
  (cl:format cl:nil "Id id ~%Polygon boundary ~%Subsignal[] subsignal ~%Id[] overlap_id ~%int32 type ~%Curve[] stop_line ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Polygon~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: hdmap_pb_msgs/Subsignal~%Id id ~%int32 type ~%Point location ~%~%================================================================================~%MSG: hdmap_pb_msgs/Curve~%CurveSegment[] segment ~%~%================================================================================~%MSG: hdmap_pb_msgs/CurveSegment~%LineSegment line_segment ~%Arc arc ~%Spiral spiral ~%Spline spline ~%Poly3 poly3 ~%float64 s ~%Point start_position ~%float64 heading ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LineSegment~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Arc~%Point center ~%float64 radius ~%float64 start_angle ~%float64 end_angle ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spiral~%float64 curv_start ~%float64 curv_end ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spline~%int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Poly3~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Signal>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'id))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'boundary))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'subsignal) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'overlap_id) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'stop_line) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Signal>))
  "Converts a ROS message object to a list"
  (cl:list 'Signal
    (cl:cons ':id (id msg))
    (cl:cons ':boundary (boundary msg))
    (cl:cons ':subsignal (subsignal msg))
    (cl:cons ':overlap_id (overlap_id msg))
    (cl:cons ':type (type msg))
    (cl:cons ':stop_line (stop_line msg))
))
