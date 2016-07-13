
(cl:in-package :asdf)

(defsystem "metric_msgs-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :metric_msgs-msg
)
  :components ((:file "_package")
    (:file "Metric" :depends-on ("_package_Metric"))
    (:file "_package_Metric" :depends-on ("_package"))
  ))