
(cl:in-package :asdf)

(defsystem "traffic_light_pb_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :header_pb_msgs-msg
)
  :components ((:file "_package")
    (:file "TrafficLightDetection" :depends-on ("_package_TrafficLightDetection"))
    (:file "_package_TrafficLightDetection" :depends-on ("_package"))
    (:file "TrafficLight" :depends-on ("_package_TrafficLight"))
    (:file "_package_TrafficLight" :depends-on ("_package"))
  ))