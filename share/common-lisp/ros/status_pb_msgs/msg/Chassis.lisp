; Auto-generated. Do not edit!


(cl:in-package status_pb_msgs-msg)


;//! \htmlinclude Chassis.msg.html

(cl:defclass <Chassis> (roslisp-msg-protocol:ros-message)
  ((driving_mode
    :reader driving_mode
    :initarg :driving_mode
    :type cl:integer
    :initform 0)
   (error_code
    :reader error_code
    :initarg :error_code
    :type cl:integer
    :initform 0)
   (engine_started
    :reader engine_started
    :initarg :engine_started
    :type cl:boolean
    :initform cl:nil)
   (engine_rpm
    :reader engine_rpm
    :initarg :engine_rpm
    :type cl:float
    :initform 0.0)
   (speed_mps
    :reader speed_mps
    :initarg :speed_mps
    :type cl:float
    :initform 0.0)
   (odometer_m
    :reader odometer_m
    :initarg :odometer_m
    :type cl:float
    :initform 0.0)
   (fuel_range_m
    :reader fuel_range_m
    :initarg :fuel_range_m
    :type cl:integer
    :initform 0)
   (throttle_percentage
    :reader throttle_percentage
    :initarg :throttle_percentage
    :type cl:float
    :initform 0.0)
   (brake_percentage
    :reader brake_percentage
    :initarg :brake_percentage
    :type cl:float
    :initform 0.0)
   (gear_location
    :reader gear_location
    :initarg :gear_location
    :type cl:integer
    :initform 0)
   (steering_percentage
    :reader steering_percentage
    :initarg :steering_percentage
    :type cl:float
    :initform 0.0)
   (steering_torque_nm
    :reader steering_torque_nm
    :initarg :steering_torque_nm
    :type cl:float
    :initform 0.0)
   (parking_brake
    :reader parking_brake
    :initarg :parking_brake
    :type cl:boolean
    :initform cl:nil)
   (high_beam_signal
    :reader high_beam_signal
    :initarg :high_beam_signal
    :type cl:boolean
    :initform cl:nil)
   (low_beam_signal
    :reader low_beam_signal
    :initarg :low_beam_signal
    :type cl:boolean
    :initform cl:nil)
   (left_turn_signal
    :reader left_turn_signal
    :initarg :left_turn_signal
    :type cl:boolean
    :initform cl:nil)
   (right_turn_signal
    :reader right_turn_signal
    :initarg :right_turn_signal
    :type cl:boolean
    :initform cl:nil)
   (horn
    :reader horn
    :initarg :horn
    :type cl:boolean
    :initform cl:nil)
   (wiper
    :reader wiper
    :initarg :wiper
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Chassis (<Chassis>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Chassis>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Chassis)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name status_pb_msgs-msg:<Chassis> is deprecated: use status_pb_msgs-msg:Chassis instead.")))

(cl:ensure-generic-function 'driving_mode-val :lambda-list '(m))
(cl:defmethod driving_mode-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:driving_mode-val is deprecated.  Use status_pb_msgs-msg:driving_mode instead.")
  (driving_mode m))

(cl:ensure-generic-function 'error_code-val :lambda-list '(m))
(cl:defmethod error_code-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:error_code-val is deprecated.  Use status_pb_msgs-msg:error_code instead.")
  (error_code m))

(cl:ensure-generic-function 'engine_started-val :lambda-list '(m))
(cl:defmethod engine_started-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:engine_started-val is deprecated.  Use status_pb_msgs-msg:engine_started instead.")
  (engine_started m))

(cl:ensure-generic-function 'engine_rpm-val :lambda-list '(m))
(cl:defmethod engine_rpm-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:engine_rpm-val is deprecated.  Use status_pb_msgs-msg:engine_rpm instead.")
  (engine_rpm m))

(cl:ensure-generic-function 'speed_mps-val :lambda-list '(m))
(cl:defmethod speed_mps-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:speed_mps-val is deprecated.  Use status_pb_msgs-msg:speed_mps instead.")
  (speed_mps m))

(cl:ensure-generic-function 'odometer_m-val :lambda-list '(m))
(cl:defmethod odometer_m-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:odometer_m-val is deprecated.  Use status_pb_msgs-msg:odometer_m instead.")
  (odometer_m m))

(cl:ensure-generic-function 'fuel_range_m-val :lambda-list '(m))
(cl:defmethod fuel_range_m-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:fuel_range_m-val is deprecated.  Use status_pb_msgs-msg:fuel_range_m instead.")
  (fuel_range_m m))

(cl:ensure-generic-function 'throttle_percentage-val :lambda-list '(m))
(cl:defmethod throttle_percentage-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:throttle_percentage-val is deprecated.  Use status_pb_msgs-msg:throttle_percentage instead.")
  (throttle_percentage m))

(cl:ensure-generic-function 'brake_percentage-val :lambda-list '(m))
(cl:defmethod brake_percentage-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:brake_percentage-val is deprecated.  Use status_pb_msgs-msg:brake_percentage instead.")
  (brake_percentage m))

(cl:ensure-generic-function 'gear_location-val :lambda-list '(m))
(cl:defmethod gear_location-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:gear_location-val is deprecated.  Use status_pb_msgs-msg:gear_location instead.")
  (gear_location m))

(cl:ensure-generic-function 'steering_percentage-val :lambda-list '(m))
(cl:defmethod steering_percentage-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:steering_percentage-val is deprecated.  Use status_pb_msgs-msg:steering_percentage instead.")
  (steering_percentage m))

(cl:ensure-generic-function 'steering_torque_nm-val :lambda-list '(m))
(cl:defmethod steering_torque_nm-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:steering_torque_nm-val is deprecated.  Use status_pb_msgs-msg:steering_torque_nm instead.")
  (steering_torque_nm m))

(cl:ensure-generic-function 'parking_brake-val :lambda-list '(m))
(cl:defmethod parking_brake-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:parking_brake-val is deprecated.  Use status_pb_msgs-msg:parking_brake instead.")
  (parking_brake m))

(cl:ensure-generic-function 'high_beam_signal-val :lambda-list '(m))
(cl:defmethod high_beam_signal-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:high_beam_signal-val is deprecated.  Use status_pb_msgs-msg:high_beam_signal instead.")
  (high_beam_signal m))

(cl:ensure-generic-function 'low_beam_signal-val :lambda-list '(m))
(cl:defmethod low_beam_signal-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:low_beam_signal-val is deprecated.  Use status_pb_msgs-msg:low_beam_signal instead.")
  (low_beam_signal m))

(cl:ensure-generic-function 'left_turn_signal-val :lambda-list '(m))
(cl:defmethod left_turn_signal-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:left_turn_signal-val is deprecated.  Use status_pb_msgs-msg:left_turn_signal instead.")
  (left_turn_signal m))

(cl:ensure-generic-function 'right_turn_signal-val :lambda-list '(m))
(cl:defmethod right_turn_signal-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:right_turn_signal-val is deprecated.  Use status_pb_msgs-msg:right_turn_signal instead.")
  (right_turn_signal m))

(cl:ensure-generic-function 'horn-val :lambda-list '(m))
(cl:defmethod horn-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:horn-val is deprecated.  Use status_pb_msgs-msg:horn instead.")
  (horn m))

(cl:ensure-generic-function 'wiper-val :lambda-list '(m))
(cl:defmethod wiper-val ((m <Chassis>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader status_pb_msgs-msg:wiper-val is deprecated.  Use status_pb_msgs-msg:wiper instead.")
  (wiper m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Chassis>) ostream)
  "Serializes a message object of type '<Chassis>"
  (cl:let* ((signed (cl:slot-value msg 'driving_mode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'error_code)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'engine_started) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'engine_rpm))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'speed_mps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'odometer_m))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'fuel_range_m)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'throttle_percentage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'brake_percentage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'gear_location)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steering_percentage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'steering_torque_nm))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'parking_brake) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'high_beam_signal) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'low_beam_signal) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'left_turn_signal) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'right_turn_signal) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'horn) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'wiper) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Chassis>) istream)
  "Deserializes a message object of type '<Chassis>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'driving_mode) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'error_code) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'engine_started) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'engine_rpm) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'speed_mps) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'odometer_m) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'fuel_range_m) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'throttle_percentage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'brake_percentage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gear_location) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steering_percentage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'steering_torque_nm) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'parking_brake) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'high_beam_signal) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'low_beam_signal) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'left_turn_signal) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'right_turn_signal) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'horn) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'wiper) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Chassis>)))
  "Returns string type for a message object of type '<Chassis>"
  "status_pb_msgs/Chassis")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Chassis)))
  "Returns string type for a message object of type 'Chassis"
  "status_pb_msgs/Chassis")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Chassis>)))
  "Returns md5sum for a message object of type '<Chassis>"
  "f2d8ec377a6a1aeabfb0e7ae112bbef4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Chassis)))
  "Returns md5sum for a message object of type 'Chassis"
  "f2d8ec377a6a1aeabfb0e7ae112bbef4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Chassis>)))
  "Returns full string definition for message of type '<Chassis>"
  (cl:format cl:nil "int32 driving_mode ~%int32 error_code ~%bool engine_started ~%float32 engine_rpm ~%float32 speed_mps ~%float32 odometer_m ~%int32 fuel_range_m ~%float32 throttle_percentage ~%float32 brake_percentage ~%int32 gear_location ~%float32 steering_percentage ~%float32 steering_torque_nm ~%bool parking_brake ~%bool high_beam_signal ~%bool low_beam_signal ~%bool left_turn_signal ~%bool right_turn_signal ~%bool horn ~%bool wiper ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Chassis)))
  "Returns full string definition for message of type 'Chassis"
  (cl:format cl:nil "int32 driving_mode ~%int32 error_code ~%bool engine_started ~%float32 engine_rpm ~%float32 speed_mps ~%float32 odometer_m ~%int32 fuel_range_m ~%float32 throttle_percentage ~%float32 brake_percentage ~%int32 gear_location ~%float32 steering_percentage ~%float32 steering_torque_nm ~%bool parking_brake ~%bool high_beam_signal ~%bool low_beam_signal ~%bool left_turn_signal ~%bool right_turn_signal ~%bool horn ~%bool wiper ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Chassis>))
  (cl:+ 0
     4
     4
     1
     4
     4
     4
     4
     4
     4
     4
     4
     4
     1
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Chassis>))
  "Converts a ROS message object to a list"
  (cl:list 'Chassis
    (cl:cons ':driving_mode (driving_mode msg))
    (cl:cons ':error_code (error_code msg))
    (cl:cons ':engine_started (engine_started msg))
    (cl:cons ':engine_rpm (engine_rpm msg))
    (cl:cons ':speed_mps (speed_mps msg))
    (cl:cons ':odometer_m (odometer_m msg))
    (cl:cons ':fuel_range_m (fuel_range_m msg))
    (cl:cons ':throttle_percentage (throttle_percentage msg))
    (cl:cons ':brake_percentage (brake_percentage msg))
    (cl:cons ':gear_location (gear_location msg))
    (cl:cons ':steering_percentage (steering_percentage msg))
    (cl:cons ':steering_torque_nm (steering_torque_nm msg))
    (cl:cons ':parking_brake (parking_brake msg))
    (cl:cons ':high_beam_signal (high_beam_signal msg))
    (cl:cons ':low_beam_signal (low_beam_signal msg))
    (cl:cons ':left_turn_signal (left_turn_signal msg))
    (cl:cons ':right_turn_signal (right_turn_signal msg))
    (cl:cons ':horn (horn msg))
    (cl:cons ':wiper (wiper msg))
))
