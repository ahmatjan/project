; Auto-generated. Do not edit!


(cl:in-package hdmap_pb_msgs-msg)


;//! \htmlinclude Map.msg.html

(cl:defclass <Map> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type hdmap_pb_msgs-msg:Header
    :initform (cl:make-instance 'hdmap_pb_msgs-msg:Header))
   (crosswalk
    :reader crosswalk
    :initarg :crosswalk
    :type (cl:vector hdmap_pb_msgs-msg:Crosswalk)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Crosswalk :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Crosswalk)))
   (junction
    :reader junction
    :initarg :junction
    :type (cl:vector hdmap_pb_msgs-msg:Junction)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Junction :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Junction)))
   (lane
    :reader lane
    :initarg :lane
    :type (cl:vector hdmap_pb_msgs-msg:Lane)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Lane :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Lane)))
   (stop_sign
    :reader stop_sign
    :initarg :stop_sign
    :type (cl:vector hdmap_pb_msgs-msg:StopSign)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:StopSign :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:StopSign)))
   (signal
    :reader signal
    :initarg :signal
    :type (cl:vector hdmap_pb_msgs-msg:Signal)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Signal :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Signal)))
   (yieldX
    :reader yieldX
    :initarg :yieldX
    :type (cl:vector hdmap_pb_msgs-msg:YieldSign)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:YieldSign :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:YieldSign)))
   (overlap
    :reader overlap
    :initarg :overlap
    :type (cl:vector hdmap_pb_msgs-msg:Overlap)
   :initform (cl:make-array 0 :element-type 'hdmap_pb_msgs-msg:Overlap :initial-element (cl:make-instance 'hdmap_pb_msgs-msg:Overlap))))
)

(cl:defclass Map (<Map>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Map>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Map)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name hdmap_pb_msgs-msg:<Map> is deprecated: use hdmap_pb_msgs-msg:Map instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <Map>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:header-val is deprecated.  Use hdmap_pb_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'crosswalk-val :lambda-list '(m))
(cl:defmethod crosswalk-val ((m <Map>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:crosswalk-val is deprecated.  Use hdmap_pb_msgs-msg:crosswalk instead.")
  (crosswalk m))

(cl:ensure-generic-function 'junction-val :lambda-list '(m))
(cl:defmethod junction-val ((m <Map>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:junction-val is deprecated.  Use hdmap_pb_msgs-msg:junction instead.")
  (junction m))

(cl:ensure-generic-function 'lane-val :lambda-list '(m))
(cl:defmethod lane-val ((m <Map>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:lane-val is deprecated.  Use hdmap_pb_msgs-msg:lane instead.")
  (lane m))

(cl:ensure-generic-function 'stop_sign-val :lambda-list '(m))
(cl:defmethod stop_sign-val ((m <Map>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:stop_sign-val is deprecated.  Use hdmap_pb_msgs-msg:stop_sign instead.")
  (stop_sign m))

(cl:ensure-generic-function 'signal-val :lambda-list '(m))
(cl:defmethod signal-val ((m <Map>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:signal-val is deprecated.  Use hdmap_pb_msgs-msg:signal instead.")
  (signal m))

(cl:ensure-generic-function 'yieldX-val :lambda-list '(m))
(cl:defmethod yieldX-val ((m <Map>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:yieldX-val is deprecated.  Use hdmap_pb_msgs-msg:yieldX instead.")
  (yieldX m))

(cl:ensure-generic-function 'overlap-val :lambda-list '(m))
(cl:defmethod overlap-val ((m <Map>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader hdmap_pb_msgs-msg:overlap-val is deprecated.  Use hdmap_pb_msgs-msg:overlap instead.")
  (overlap m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Map>) ostream)
  "Serializes a message object of type '<Map>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'crosswalk))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'crosswalk))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'junction))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'junction))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lane))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'lane))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'stop_sign))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'stop_sign))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'signal))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'signal))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'yieldX))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'yieldX))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'overlap))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'overlap))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Map>) istream)
  "Deserializes a message object of type '<Map>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'crosswalk) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'crosswalk)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Crosswalk))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'junction) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'junction)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Junction))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lane) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lane)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Lane))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'stop_sign) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'stop_sign)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:StopSign))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'signal) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'signal)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Signal))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'yieldX) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'yieldX)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:YieldSign))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'overlap) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'overlap)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'hdmap_pb_msgs-msg:Overlap))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Map>)))
  "Returns string type for a message object of type '<Map>"
  "hdmap_pb_msgs/Map")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Map)))
  "Returns string type for a message object of type 'Map"
  "hdmap_pb_msgs/Map")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Map>)))
  "Returns md5sum for a message object of type '<Map>"
  "83626360938f309d85beab03f51d0bb3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Map)))
  "Returns md5sum for a message object of type 'Map"
  "83626360938f309d85beab03f51d0bb3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Map>)))
  "Returns full string definition for message of type '<Map>"
  (cl:format cl:nil "hdmap_pb_msgs/Header header ~%Crosswalk[] crosswalk ~%Junction[] junction ~%Lane[] lane ~%StopSign[] stop_sign ~%Signal[] signal ~%YieldSign[] yieldX ~%Overlap[] overlap ~%~%================================================================================~%MSG: hdmap_pb_msgs/Header~%int8 version ~%int8 date ~%~%================================================================================~%MSG: hdmap_pb_msgs/Crosswalk~%Id id ~%Polygon polygon ~%Id[] overlap_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Polygon~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: hdmap_pb_msgs/Junction~%Id id ~%Polygon polygon ~%Id[] crosswalk_id ~%Id[] overlap_id ~%int32 num_road_segments ~%Id[] lane_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Lane~%Id id ~%int32 type ~%int32 turn ~%Curve central_curve ~%LaneBoundary left_boundary ~%LaneBoundary right_boundary ~%float64 width ~%float64 length ~%float64 speed_limit ~%Id[] overlap_id ~%Id[] predecessor_id ~%Id[] successor_id ~%Id[] left_neighbor_forward_lane_id ~%Id[] right_neighbor_forward_lane_id ~%Id[] left_neighbor_reverse_lane_id ~%Id[] right_neighbor_reverse_lane_id ~%Id[] stop_sign_id ~%Id junction_id ~%Id[] crosswalk_id ~%Id[] yield_sign_id ~%LaneSampleAssociation[] left_sample ~%LaneSampleAssociation[] right_sample ~%~%================================================================================~%MSG: hdmap_pb_msgs/Curve~%CurveSegment[] segment ~%~%================================================================================~%MSG: hdmap_pb_msgs/CurveSegment~%LineSegment line_segment ~%Arc arc ~%Spiral spiral ~%Spline spline ~%Poly3 poly3 ~%float64 s ~%Point start_position ~%float64 heading ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LineSegment~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Arc~%Point center ~%float64 radius ~%float64 start_angle ~%float64 end_angle ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spiral~%float64 curv_start ~%float64 curv_end ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spline~%int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Poly3~%~%================================================================================~%MSG: hdmap_pb_msgs/LaneBoundary~%Curve curve ~%int32 type ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LaneSampleAssociation~%float64 s ~%float64 width ~%~%================================================================================~%MSG: hdmap_pb_msgs/StopSign~%Id id ~%Curve stop_line ~%Point location ~%Id[] overlap_id ~%Id signal_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Signal~%Id id ~%Polygon boundary ~%Subsignal[] subsignal ~%Id[] overlap_id ~%int32 type ~%Curve[] stop_line ~%~%================================================================================~%MSG: hdmap_pb_msgs/Subsignal~%Id id ~%int32 type ~%Point location ~%~%================================================================================~%MSG: hdmap_pb_msgs/YieldSign~%Id id ~%Curve stop_line ~%Point location ~%Id[] overlap_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Overlap~%Id id ~%ObjectOverlapInfo[] object ~%~%================================================================================~%MSG: hdmap_pb_msgs/ObjectOverlapInfo~%Id id ~%LaneOverlapInfo lane_overlap_info ~%SignalOverlapInfo signal_overlap_info ~%StopSignOverlapInfo stop_sign_overlap_info ~%CrosswalkOverlapInfo crosswalk_overlap_info ~%JunctionOverlapInfo junction_overlap_info ~%~%================================================================================~%MSG: hdmap_pb_msgs/LaneOverlapInfo~%float64 start_s ~%float64 end_s ~%bool is_merge ~%bool has_precedence ~%~%================================================================================~%MSG: hdmap_pb_msgs/SignalOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/StopSignOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/CrosswalkOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/JunctionOverlapInfo~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Map)))
  "Returns full string definition for message of type 'Map"
  (cl:format cl:nil "hdmap_pb_msgs/Header header ~%Crosswalk[] crosswalk ~%Junction[] junction ~%Lane[] lane ~%StopSign[] stop_sign ~%Signal[] signal ~%YieldSign[] yieldX ~%Overlap[] overlap ~%~%================================================================================~%MSG: hdmap_pb_msgs/Header~%int8 version ~%int8 date ~%~%================================================================================~%MSG: hdmap_pb_msgs/Crosswalk~%Id id ~%Polygon polygon ~%Id[] overlap_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Id~%int8 id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Polygon~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Point~%float64 x ~%float64 y ~%float64 z ~%~%================================================================================~%MSG: hdmap_pb_msgs/Junction~%Id id ~%Polygon polygon ~%Id[] crosswalk_id ~%Id[] overlap_id ~%int32 num_road_segments ~%Id[] lane_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Lane~%Id id ~%int32 type ~%int32 turn ~%Curve central_curve ~%LaneBoundary left_boundary ~%LaneBoundary right_boundary ~%float64 width ~%float64 length ~%float64 speed_limit ~%Id[] overlap_id ~%Id[] predecessor_id ~%Id[] successor_id ~%Id[] left_neighbor_forward_lane_id ~%Id[] right_neighbor_forward_lane_id ~%Id[] left_neighbor_reverse_lane_id ~%Id[] right_neighbor_reverse_lane_id ~%Id[] stop_sign_id ~%Id junction_id ~%Id[] crosswalk_id ~%Id[] yield_sign_id ~%LaneSampleAssociation[] left_sample ~%LaneSampleAssociation[] right_sample ~%~%================================================================================~%MSG: hdmap_pb_msgs/Curve~%CurveSegment[] segment ~%~%================================================================================~%MSG: hdmap_pb_msgs/CurveSegment~%LineSegment line_segment ~%Arc arc ~%Spiral spiral ~%Spline spline ~%Poly3 poly3 ~%float64 s ~%Point start_position ~%float64 heading ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LineSegment~%Point[] point ~%~%================================================================================~%MSG: hdmap_pb_msgs/Arc~%Point center ~%float64 radius ~%float64 start_angle ~%float64 end_angle ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spiral~%float64 curv_start ~%float64 curv_end ~%~%================================================================================~%MSG: hdmap_pb_msgs/Spline~%int32 dimension ~%int32 degree ~%float64[] knot ~%Point[] control ~%~%================================================================================~%MSG: hdmap_pb_msgs/Poly3~%~%================================================================================~%MSG: hdmap_pb_msgs/LaneBoundary~%Curve curve ~%int32 type ~%float64 length ~%~%================================================================================~%MSG: hdmap_pb_msgs/LaneSampleAssociation~%float64 s ~%float64 width ~%~%================================================================================~%MSG: hdmap_pb_msgs/StopSign~%Id id ~%Curve stop_line ~%Point location ~%Id[] overlap_id ~%Id signal_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Signal~%Id id ~%Polygon boundary ~%Subsignal[] subsignal ~%Id[] overlap_id ~%int32 type ~%Curve[] stop_line ~%~%================================================================================~%MSG: hdmap_pb_msgs/Subsignal~%Id id ~%int32 type ~%Point location ~%~%================================================================================~%MSG: hdmap_pb_msgs/YieldSign~%Id id ~%Curve stop_line ~%Point location ~%Id[] overlap_id ~%~%================================================================================~%MSG: hdmap_pb_msgs/Overlap~%Id id ~%ObjectOverlapInfo[] object ~%~%================================================================================~%MSG: hdmap_pb_msgs/ObjectOverlapInfo~%Id id ~%LaneOverlapInfo lane_overlap_info ~%SignalOverlapInfo signal_overlap_info ~%StopSignOverlapInfo stop_sign_overlap_info ~%CrosswalkOverlapInfo crosswalk_overlap_info ~%JunctionOverlapInfo junction_overlap_info ~%~%================================================================================~%MSG: hdmap_pb_msgs/LaneOverlapInfo~%float64 start_s ~%float64 end_s ~%bool is_merge ~%bool has_precedence ~%~%================================================================================~%MSG: hdmap_pb_msgs/SignalOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/StopSignOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/CrosswalkOverlapInfo~%~%================================================================================~%MSG: hdmap_pb_msgs/JunctionOverlapInfo~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Map>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'crosswalk) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'junction) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lane) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'stop_sign) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'signal) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'yieldX) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'overlap) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Map>))
  "Converts a ROS message object to a list"
  (cl:list 'Map
    (cl:cons ':header (header msg))
    (cl:cons ':crosswalk (crosswalk msg))
    (cl:cons ':junction (junction msg))
    (cl:cons ':lane (lane msg))
    (cl:cons ':stop_sign (stop_sign msg))
    (cl:cons ':signal (signal msg))
    (cl:cons ':yieldX (yieldX msg))
    (cl:cons ':overlap (overlap msg))
))
