
(cl:in-package :asdf)

(defsystem "perception_pb_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :header_pb_msgs-msg
)
  :components ((:file "_package")
    (:file "Point" :depends-on ("_package_Point"))
    (:file "_package_Point" :depends-on ("_package"))
    (:file "PerceptionObstacles" :depends-on ("_package_PerceptionObstacles"))
    (:file "_package_PerceptionObstacles" :depends-on ("_package"))
    (:file "PerceptionObstacle" :depends-on ("_package_PerceptionObstacle"))
    (:file "_package_PerceptionObstacle" :depends-on ("_package"))
  ))