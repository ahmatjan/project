; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Spline.msg.html

(cl:defclass <Spline> (roslisp-msg-protocol:ros-message)
  ((dimension
    :reader dimension
    :initarg :dimension
    :type cl:integer
    :initform 0)
   (degree
    :reader degree
    :initarg :degree
    :type cl:integer
    :initform 0)
   (knot
    :reader knot
    :initarg :knot
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (control
    :reader control
    :initarg :control
    :type (cl:vector hdmap_pb_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Point :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Point))))
)

(cl:defclass Spline (<Spline>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Spline>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Spline)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Spline> is deprecated: use hdmap_pb_msgs-msg:Spline instead.")))

(cl:ensure-generic-function 'dimension-val :lambda-list '(m))
(cl:defmethod dimension-val ((m <Spline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:dimension-val is deprecated.  Use hdmap_pb_msgs-msg:dimension instead.")
  (dimension m))

(cl:ensure-generic-function 'degree-val :lambda-list '(m))
(cl:defmethod degree-val ((m <Spline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:degree-val is deprecated.  Use hdmap_pb_msgs-msg:degree instead.")
  (degree m))

(cl:ensure-generic-function 'knot-val :lambda-list '(m))
(cl:defmethod knot-val ((m <Spline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:knot-val is deprecated.  Use hdmap_pb_msgs-msg:knot instead.")
  (knot m))

(cl:ensure-generic-function 'control-val :lambda-list '(m))
(cl:defmethod control-val ((m <Spline>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:control-val is deprecated.  Use hdmap_pb_msgs-msg:control instead.")
  (control m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Spline>) ostream)
  "Serializes a message object of type '<Spline>"
  (cl:let* ((signed (cl:slot-value msg 'dimension)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'degree)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'knot))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'knot))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'control))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'control))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Spline>) istream)
  "Deserializes a message object of type '<Spline>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'dimension) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'degree) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'knot) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'knot)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'control) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'control)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Spline>)))
  "Returns string type for a message object of type '<Spline>"
  "hdmap_pb_msgs/Spline")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Spline)))
  "Returns string type for a message object of type 'Spline"
  "hdmap_pb_msgs/Spline")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Spline>)))
  "Returns md5sum for a message object of type '<Spline>"
  "d7093b5f795127af1d1f971334132cd3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Spline)))
  "Returns md5sum for a message object of type 'Spline"
  "d7093b5f795127af1d1f971334132cd3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Spline>)))
  "Returns full string definition for message of type '<Spline>"
  (cl:format cl:nil "int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Spline)))
  "Returns full string definition for message of type 'Spline"
  (cl:format cl:nil "int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Spline>))
  (cl:+ 0
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'knot) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'control) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Spline>))
  "Converts a ROS message object to a list"
  (cl:list 'Spline
    (cl:cons ':dimension (dimension msg))
    (cl:cons ':degree (degree msg))
    (cl:cons ':knot (knot msg))
    (cl:cons ':control (control msg))
))
