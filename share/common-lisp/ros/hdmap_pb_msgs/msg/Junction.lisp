; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Junction.msg.html

(cl:defclass <Junction> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type hdmap_pb_msgs-msg:Id
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Id))
   (polygon
    :reader polygon
    :initarg :polygon
    :type hdmap_pb_msgs-msg:Polygon
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Polygon))
   (crosswalk_id
    :reader crosswalk_id
    :initarg :crosswalk_id
    :type (cl:vector hdmap_pb_msgs-msg:Id)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Id :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Id)))
   (overlap_id
    :reader overlap_id
    :initarg :overlap_id
    :type (cl:vector hdmap_pb_msgs-msg:Id)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Id :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Id)))
   (num_road_segments
    :reader num_road_segments
    :initarg :num_road_segments
    :type cl:integer
    :initform 0)
   (lane_id
    :reader lane_id
    :initarg :lane_id
    :type (cl:vector hdmap_pb_msgs-msg:Id)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Id :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Id))))
)

(cl:defclass Junction (<Junction>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Junction>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Junction)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Junction> is deprecated: use hdmap_pb_msgs-msg:Junction instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Junction>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:id-val is deprecated.  Use hdmap_pb_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'polygon-val :lambda-list '(m))
(cl:defmethod polygon-val ((m <Junction>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:polygon-val is deprecated.  Use hdmap_pb_msgs-msg:polygon instead.")
  (polygon m))

(cl:ensure-generic-function 'crosswalk_id-val :lambda-list '(m))
(cl:defmethod crosswalk_id-val ((m <Junction>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:crosswalk_id-val is deprecated.  Use hdmap_pb_msgs-msg:crosswalk_id instead.")
  (crosswalk_id m))

(cl:ensure-generic-function 'overlap_id-val :lambda-list '(m))
(cl:defmethod overlap_id-val ((m <Junction>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:overlap_id-val is deprecated.  Use hdmap_pb_msgs-msg:overlap_id instead.")
  (overlap_id m))

(cl:ensure-generic-function 'num_road_segments-val :lambda-list '(m))
(cl:defmethod num_road_segments-val ((m <Junction>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:num_road_segments-val is deprecated.  Use hdmap_pb_msgs-msg:num_road_segments instead.")
  (num_road_segments m))

(cl:ensure-generic-function 'lane_id-val :lambda-list '(m))
(cl:defmethod lane_id-val ((m <Junction>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:lane_id-val is deprecated.  Use hdmap_pb_msgs-msg:lane_id instead.")
  (lane_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Junction>) ostream)
  "Serializes a message object of type '<Junction>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'id) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'polygon) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'crosswalk_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'crosswalk_id))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'overlap_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'overlap_id))
  (cl:let* ((signed (cl:slot-value msg 'num_road_segments)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lane_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lane_id))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Junction>) istream)
  "Deserializes a message object of type '<Junction>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'id) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'polygon) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'crosswalk_id) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'crosswalk_id)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Id))
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
      (cl:setf (cl:slot-value msg 'num_road_segments) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lane_id) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lane_id)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Id))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Junction>)))
  "Returns string type for a message object of type '<Junction>"
  "hdmap_pb_msgs/Junction")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Junction)))
  "Returns string type for a message object of type 'Junction"
  "hdmap_pb_msgs/Junction")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Junction>)))
  "Returns md5sum for a message object of type '<Junction>"
  "117dc5a04a9ea1f4dd5ed713688ed3b4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Junction)))
  "Returns md5sum for a message object of type 'Junction"
  "117dc5a04a9ea1f4dd5ed713688ed3b4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Junction>)))
  "Returns full string definition for message of type '<Junction>"
  (cl:format cl:nil "Id id ~%Polygon polygon ~%Id[] crosswalk_id ~%Id[] overlap_id ~%int32 num_road_segments ~%Id[] lane_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Polygon~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Junction)))
  "Returns full string definition for message of type 'Junction"
  (cl:format cl:nil "Id id ~%Polygon polygon ~%Id[] crosswalk_id ~%Id[] overlap_id ~%int32 num_road_segments ~%Id[] lane_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Polygon~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Junction>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'id))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'polygon))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'crosswalk_id) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'overlap_id) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lane_id) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Junction>))
  "Converts a ROS message object to a list"
  (cl:list 'Junction
    (cl:cons ':id (id msg))
    (cl:cons ':polygon (polygon msg))
    (cl:cons ':crosswalk_id (crosswalk_id msg))
    (cl:cons ':overlap_id (overlap_id msg))
    (cl:cons ':num_road_segments (num_road_segments msg))
    (cl:cons ':lane_id (lane_id msg))
))
