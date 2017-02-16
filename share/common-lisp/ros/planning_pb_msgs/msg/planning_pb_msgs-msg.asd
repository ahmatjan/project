
(cl:in-package :asdf)

(defsystem "planning_pb_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :header_pb_msgs-msg
)
  :components ((:file "_package")
    (:file "EStop" :depends-on ("_package_EStop"))
    (:file "_package_EStop" :depends-on ("_package"))
    (:file "ADCTrajectory" :depends-on ("_package_ADCTrajectory"))
    (:file "_package_ADCTrajectory" :depends-on ("_package"))
    (:file "ADCTrajectoryPoint" :depends-on ("_package_ADCTrajectoryPoint"))
    (:file "_package_ADCTrajectoryPoint" :depends-on ("_package"))
    (:file "ADCSignals" :depends-on ("_package_ADCSignals"))
    (:file "_package_ADCSignals" :depends-on ("_package"))
  ))