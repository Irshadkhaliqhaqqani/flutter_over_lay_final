import 'package:figma_overlay_clean/presentation/authentication/controller/auth_controller.dart';
import 'package:figma_overlay_clean/presentation/authentication/sign_in/screen/sign_in_page.dart';
import 'package:figma_overlay_clean/presentation/main_page/screen/main_control_panel_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Obx(() {
      final user = controller.currentUser.value;

      if (user == null) {
        return const SignInPage();
      } else {
        return MainControlPanelPage();
      }
    });
  }
}
