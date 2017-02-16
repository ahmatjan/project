; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Overlap.msg.html

(cl:defclass <Overlap> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type hdmap_pb_msgs-msg:Id
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Id))
   (object
    :reader object
    :initarg :object
    :type (cl:vector hdmap_pb_msgs-msg:ObjectOverlapInfo)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:ObjectOverlapInfo :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:ObjectOverlapInfo))))
)

(cl:defclass Overlap (<Overlap>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Overlap>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Overlap)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Overlap> is deprecated: use hdmap_pb_msgs-msg:Overlap instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Overlap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:id-val is deprecated.  Use hdmap_pb_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'object-val :lambda-list '(m))
(cl:defmethod object-val ((m <Overlap>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:object-val is deprecated.  Use hdmap_pb_msgs-msg:object instead.")
  (object m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Overlap>) ostream)
  "Serializes a message object of type '<Overlap>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'id) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'object))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'object))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Overlap>) istream)
  "Deserializes a message object of type '<Overlap>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'id) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'object) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'object)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:ObjectOverlapInfo))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Overlap>)))
  "Returns string type for a message object of type '<Overlap>"
  "hdmap_pb_msgs/Overlap")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Overlap)))
  "Returns string type for a message object of type 'Overlap"
  "hdmap_pb_msgs/Overlap")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Overlap>)))
  "Returns md5sum for a message object of type '<Overlap>"
  "d69e2c5f45b1dc96ea1b53d225f986e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Overlap)))
  "Returns md5sum for a message object of type 'Overlap"
  "d69e2c5f45b1dc96ea1b53d225f986e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Overlap>)))
  "Returns full string definition for message of type '<Overlap>"
  (cl:format cl:nil "Id id ~%ObjectOverlapInfo[] object ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/ObjectOverlapInfo~%Id id ~%LaneOverlapInfo lane_overlap_info ~%SignalOverlapInfo signal_overlap_info ~%StopSignOverlapInfo stop_sign_overlap_info ~%CrosswalkOverlapInfo crosswalk_overlap_info ~%JunctionOverlapInfo junction_overlap_info ~%~%================================================================================~%MSG: hdmap_pb_msgs/LaneOverlapInfo~%float64 start_s ~%float64 end_s ~%bool is_merge ~%bool has_precedence ~%~%================================================================================~%MSG: hdmap_pb_msgs/SignalOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/StopSignOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/CrosswalkOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/JunctionOverlapInfo~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Overlap)))
  "Returns full string definition for message of type 'Overlap"
  (cl:format cl:nil "Id id ~%ObjectOverlapInfo[] object ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/ObjectOverlapInfo~%Id id ~%LaneOverlapInfo lane_overlap_info ~%SignalOverlapInfo signal_overlap_info ~%StopSignOverlapInfo stop_sign_overlap_info ~%CrosswalkOverlapInfo crosswalk_overlap_info ~%JunctionOverlapInfo junction_overlap_info ~%~%================================================================================~%MSG: hdmap_pb_msgs/LaneOverlapInfo~%float64 start_s ~%float64 end_s ~%bool is_merge ~%bool has_precedence ~%~%================================================================================~%MSG: hdmap_pb_msgs/SignalOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/StopSignOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/CrosswalkOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/JunctionOverlapInfo~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Overlap>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'id))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'object) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Overlap>))
  "Converts a ROS message object to a list"
  (cl:list 'Overlap
    (cl:cons ':id (id msg))
    (cl:cons ':object (object msg))
))
