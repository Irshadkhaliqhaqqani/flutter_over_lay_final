import 'package:get/state_manager.dart';

class FigmaPageController extends GetxController {
  RxBool isToggled = false.obs;

  void toggleSwitch(bool value) {
    isToggled.value = value;
  }
}
