
(cl:in-package :asdf)

(defsystem "opencv_apps-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "Size" :depends-on ("_package_Size"))
    (:file "_package_Size" :depends-on ("_package"))
    (:file "MomentArrayStamped" :depends-on ("_package_MomentArrayStamped"))
    (:file "_package_MomentArrayStamped" :depends-on ("_package"))
    (:file "Contour" :depends-on ("_package_Contour"))
    (:file "_package_Contour" :depends-on ("_package"))
    (:file "CircleArray" :depends-on ("_package_CircleArray"))
    (:file "_package_CircleArray" :depends-on ("_package"))
    (:file "RectArrayStamped" :depends-on ("_package_RectArrayStamped"))
    (:file "_package_RectArrayStamped" :depends-on ("_package"))
    (:file "LineArray" :depends-on ("_package_LineArray"))
    (:file "_package_LineArray" :depends-on ("_package"))
    (:file "Point2DArrayStamped" :depends-on ("_package_Point2DArrayStamped"))
    (:file "_package_Point2DArrayStamped" :depends-on ("_package"))
    (:file "FaceArray" :depends-on ("_package_FaceArray"))
    (:file "_package_FaceArray" :depends-on ("_package"))
    (:file "CircleArrayStamped" :depends-on ("_package_CircleArrayStamped"))
    (:file "_package_CircleArrayStamped" :depends-on ("_package"))
    (:file "ContourArrayStamped" :depends-on ("_package_ContourArrayStamped"))
    (:file "_package_ContourArrayStamped" :depends-on ("_package"))
    (:file "FlowArray" :depends-on ("_package_FlowArray"))
    (:file "_package_FlowArray" :depends-on ("_package"))
    (:file "Point2DStamped" :depends-on ("_package_Point2DStamped"))
    (:file "_package_Point2DStamped" :depends-on ("_package"))
    (:file "Line" :depends-on ("_package_Line"))
    (:file "_package_Line" :depends-on ("_package"))
    (:file "FaceArrayStamped" :depends-on ("_package_FaceArrayStamped"))
    (:file "_package_FaceArrayStamped" :depends-on ("_package"))
    (:file "LineArrayStamped" :depends-on ("_package_LineArrayStamped"))
    (:file "_package_LineArrayStamped" :depends-on ("_package"))
    (:file "FlowStamped" :depends-on ("_package_FlowStamped"))
    (:file "_package_FlowStamped" :depends-on ("_package"))
    (:file "Rect" :depends-on ("_package_Rect"))
    (:file "_package_Rect" :depends-on ("_package"))
    (:file "RotatedRectArrayStamped" :depends-on ("_package_RotatedRectArrayStamped"))
    (:file "_package_RotatedRectArrayStamped" :depends-on ("_package"))
    (:file "RotatedRect" :depends-on ("_package_RotatedRect"))
    (:file "_package_RotatedRect" :depends-on ("_package"))
    (:file "MomentArray" :depends-on ("_package_MomentArray"))
    (:file "_package_MomentArray" :depends-on ("_package"))
    (:file "Face" :depends-on ("_package_Face"))
    (:file "_package_Face" :depends-on ("_package"))
    (:file "RotatedRectStamped" :depends-on ("_package_RotatedRectStamped"))
    (:file "_package_RotatedRectStamped" :depends-on ("_package"))
    (:file "RectArray" :depends-on ("_package_RectArray"))
    (:file "_package_RectArray" :depends-on ("_package"))
    (:file "FlowArrayStamped" :depends-on ("_package_FlowArrayStamped"))
    (:file "_package_FlowArrayStamped" :depends-on ("_package"))
    (:file "Flow" :depends-on ("_package_Flow"))
    (:file "_package_Flow" :depends-on ("_package"))
    (:file "Circle" :depends-on ("_package_Circle"))
    (:file "_package_Circle" :depends-on ("_package"))
    (:file "ContourArray" :depends-on ("_package_ContourArray"))
    (:file "_package_ContourArray" :depends-on ("_package"))
    (:file "Moment" :depends-on ("_package_Moment"))
    (:file "_package_Moment" :depends-on ("_package"))
    (:file "RotatedRectArray" :depends-on ("_package_RotatedRectArray"))
    (:file "_package_RotatedRectArray" :depends-on ("_package"))
    (:file "Point2DArray" :depends-on ("_package_Point2DArray"))
    (:file "_package_Point2DArray" :depends-on ("_package"))
    (:file "Point2D" :depends-on ("_package_Point2D"))
    (:file "_package_Point2D" :depends-on ("_package"))
  ))