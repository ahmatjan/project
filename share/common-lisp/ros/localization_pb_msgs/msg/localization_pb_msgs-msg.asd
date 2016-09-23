
(cl:in-package :asdf)

(defsystem "localization_pb_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :common_pb_msgs-msg
               :header_pb_msgs-msg
)
  :components ((:file "_package")
    (:file "Uncertainty" :depends-on ("_package_Uncertainty"))
    (:file "_package_Uncertainty" :depends-on ("_package"))
    (:file "Pose" :depends-on ("_package_Pose"))
    (:file "_package_Pose" :depends-on ("_package"))
    (:file "LocalizationEstimate" :depends-on ("_package_LocalizationEstimate"))
    (:file "_package_LocalizationEstimate" :depends-on ("_package"))
  ))