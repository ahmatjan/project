
(cl:in-package :asdf)

(defsystem "header_pb_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Header" :depends-on ("_package_Header"))
    (:file "_package_Header" :depends-on ("_package"))
  ))