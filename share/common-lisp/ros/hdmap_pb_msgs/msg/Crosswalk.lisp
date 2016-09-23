; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Crosswalk.msg.html

(cl:defclass <Crosswalk> (roslisp-msg-protocol:ros-message)
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
   (overlap_id
    :reader overlap_id
    :initarg :overlap_id
    :type (cl:vector hdmap_pb_msgs-msg:Id)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Id :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Id))))
)

(cl:defclass Crosswalk (<Crosswalk>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Crosswalk>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Crosswalk)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Crosswalk> is deprecated: use hdmap_pb_msgs-msg:Crosswalk instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Crosswalk>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:id-val is deprecated.  Use hdmap_pb_msgs-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'polygon-val :lambda-list '(m))
(cl:defmethod polygon-val ((m <Crosswalk>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:polygon-val is deprecated.  Use hdmap_pb_msgs-msg:polygon instead.")
  (polygon m))

(cl:ensure-generic-function 'overlap_id-val :lambda-list '(m))
(cl:defmethod overlap_id-val ((m <Crosswalk>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:overlap_id-val is deprecated.  Use hdmap_pb_msgs-msg:overlap_id instead.")
  (overlap_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Crosswalk>) ostream)
  "Serializes a message object of type '<Crosswalk>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'id) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'polygon) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'overlap_id))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'overlap_id))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Crosswalk>) istream)
  "Deserializes a message object of type '<Crosswalk>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'id) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'polygon) istream)
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Crosswalk>)))
  "Returns string type for a message object of type '<Crosswalk>"
  "hdmap_pb_msgs/Crosswalk")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Crosswalk)))
  "Returns string type for a message object of type 'Crosswalk"
  "hdmap_pb_msgs/Crosswalk")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Crosswalk>)))
  "Returns md5sum for a message object of type '<Crosswalk>"
  "cc456d1a80542d5196e5f5ad7f880b7d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Crosswalk)))
  "Returns md5sum for a message object of type 'Crosswalk"
  "cc456d1a80542d5196e5f5ad7f880b7d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Crosswalk>)))
  "Returns full string definition for message of type '<Crosswalk>"
  (cl:format cl:nil "Id id ~%Polygon polygon ~%Id[] overlap_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Polygon~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Crosswalk)))
  "Returns full string definition for message of type 'Crosswalk"
  (cl:format cl:nil "Id id ~%Polygon polygon ~%Id[] overlap_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Polygon~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Crosswalk>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'id))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'polygon))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'overlap_id) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Crosswalk>))
  "Converts a ROS message object to a list"
  (cl:list 'Crosswalk
    (cl:cons ':id (id msg))
    (cl:cons ':polygon (polygon msg))
    (cl:cons ':overlap_id (overlap_id msg))
))
