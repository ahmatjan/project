
(cl:in-package :asdf)

(defsystem "common_pb_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Quaternion" :depends-on ("_package_Quaternion"))
    (:file "_package_Quaternion" :depends-on ("_package"))
    (:file "PointENU" :depends-on ("_package_PointENU"))
    (:file "_package_PointENU" :depends-on ("_package"))
    (:file "PointLLH" :depends-on ("_package_PointLLH"))
    (:file "_package_PointLLH" :depends-on ("_package"))
    (:file "Point3D" :depends-on ("_package_Point3D"))
    (:file "_package_Point3D" :depends-on ("_package"))
  ))