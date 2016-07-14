
(cl:in-package :asdf)

(defsystem "metric_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "RosMetric" :depends-on ("_package_RosMetric"))
    (:file "_package_RosMetric" :depends-on ("_package"))
    (:file "MetricStatus" :depends-on ("_package_MetricStatus"))
    (:file "_package_MetricStatus" :depends-on ("_package"))
    (:file "KeyValue" :depends-on ("_package_KeyValue"))
    (:file "_package_KeyValue" :depends-on ("_package"))
  ))