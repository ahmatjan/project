
(cl:in-package :asdf)

(defsystem "prediction_pb_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :header_pb_msgs-msg
               :perception_pb_msgs-msg
)
  :components ((:file "_package")
    (:file "TrajectoryPoint" :depends-on ("_package_TrajectoryPoint"))
    (:file "_package_TrajectoryPoint" :depends-on ("_package"))
    (:file "PredictionObstacles" :depends-on ("_package_PredictionObstacles"))
    (:file "_package_PredictionObstacles" :depends-on ("_package"))
    (:file "PredictionObstacle" :depends-on ("_package_PredictionObstacle"))
    (:file "_package_PredictionObstacle" :depends-on ("_package"))
    (:file "Trajectory" :depends-on ("_package_Trajectory"))
    (:file "_package_Trajectory" :depends-on ("_package"))
  ))