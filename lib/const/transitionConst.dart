import 'package:get/get.dart';

class TransitionType {
  static Transition fade = Transition.fade;
  static Transition rightToLeft = Transition.rightToLeft;
  static Transition leftToRight = Transition.leftToRight;
    static Transition BottomToTop = Transition.downToUp;
  // Add more transition types as needed

  // You can add more properties to customize transitions
  static const Duration defaultDuration = Duration(milliseconds: 500);
}
