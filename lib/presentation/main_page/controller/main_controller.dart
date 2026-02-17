import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/open_overlay_window_usecase.dart';

class MainController extends GetxController {
  var isMaximixed = false.obs;
  final OpenOverlayWindowUseCase openOverlayWindowUseCase;

  MainController(this.openOverlayWindowUseCase);

  // Observable state
  final isLoading = false.obs;
  final errorMessage = Rx<String?>(null);

  Future<void> openOverlayWindow() async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await openOverlayWindowUseCase(NoParams());

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (_) {
        Get.snackbar(
            'Success', 'Overlay window opened (multi-window coming soon!)',
            snackPosition: SnackPosition.BOTTOM, overlayColor: Colors.white);
      },
    );

    isLoading.value = false;
  }

  void toggleMaximize() async {
    if (await windowManager.isMaximized()) {
      windowManager.unmaximize();
      isMaximixed.value = false;
    } else {
      windowManager.maximize();
      isMaximixed.value = true;
    }
  }
}
