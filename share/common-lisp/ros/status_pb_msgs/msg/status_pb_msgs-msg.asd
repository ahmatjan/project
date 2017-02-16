
(cl:in-package :asdf)

(defsystem "status_pb_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :header_pb_msgs-msg
               :localization_pb_msgs-msg
)
  :components ((:file "_package")
    (:file "Status" :depends-on ("_package_Status"))
    (:file "_package_Status" :depends-on ("_package"))
    (:file "Chassis" :depends-on ("_package_Chassis"))
    (:file "_package_Chassis" :depends-on ("_package"))
  ))