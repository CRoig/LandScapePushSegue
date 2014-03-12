LandScapePushSegue
==================

Custom Segue that emulates a Right to Left Push Segue in LandScape mode without UINavigatorController.

Create a Right to Left Push Segue si difficult specially if you are not using a UINavigatorController. In addition, some Push Segues emulations using a UIViewController become akward when performed on LandScape mode. In this mode, the view could perform an annoying autoRotatation animation.

This custom segue class emulates this particular Push Segues in UIViewController using an animated snapShot translation in the foreground.
