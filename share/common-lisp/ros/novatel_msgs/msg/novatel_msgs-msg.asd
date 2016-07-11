
(cl:in-package :asdf)

(defsystem "novatel_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "MARK1PVA" :depends-on ("_package_MARK1PVA"))
    (:file "_package_MARK1PVA" :depends-on ("_package"))
    (:file "INSPVA" :depends-on ("_package_INSPVA"))
    (:file "_package_INSPVA" :depends-on ("_package"))
    (:file "BESTXYZ" :depends-on ("_package_BESTXYZ"))
    (:file "_package_BESTXYZ" :depends-on ("_package"))
    (:file "CommonFooter" :depends-on ("_package_CommonFooter"))
    (:file "_package_CommonFooter" :depends-on ("_package"))
    (:file "Ack" :depends-on ("_package_Ack"))
    (:file "_package_Ack" :depends-on ("_package"))
    (:file "RAWIMU" :depends-on ("_package_RAWIMU"))
    (:file "_package_RAWIMU" :depends-on ("_package"))
    (:file "CommonHeader" :depends-on ("_package_CommonHeader"))
    (:file "_package_CommonHeader" :depends-on ("_package"))
    (:file "INSPVAX" :depends-on ("_package_INSPVAX"))
    (:file "_package_INSPVAX" :depends-on ("_package"))
    (:file "CORRIMUDATA" :depends-on ("_package_CORRIMUDATA"))
    (:file "_package_CORRIMUDATA" :depends-on ("_package"))
    (:file "BESTVEL2" :depends-on ("_package_BESTVEL2"))
    (:file "_package_BESTVEL2" :depends-on ("_package"))
    (:file "IMAGETIMESTAMP" :depends-on ("_package_IMAGETIMESTAMP"))
    (:file "_package_IMAGETIMESTAMP" :depends-on ("_package"))
    (:file "INSCOV" :depends-on ("_package_INSCOV"))
    (:file "_package_INSCOV" :depends-on ("_package"))
    (:file "BESTPOS" :depends-on ("_package_BESTPOS"))
    (:file "_package_BESTPOS" :depends-on ("_package"))
    (:file "LOGFILESTATUS" :depends-on ("_package_LOGFILESTATUS"))
    (:file "_package_LOGFILESTATUS" :depends-on ("_package"))
  ))