import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/entities/figma_image.dart';
import '../../domain/usecases/pick_image_usecase.dart';

class OverlayController extends GetxController {
  final PickImageUseCase pickImageUseCase;

  OverlayController(this.pickImageUseCase);

  // Observable state
  final opacity = AppConstants.defaultOpacity.obs;
  final figmaImage = Rx<FigmaImage?>(null);
  final isLoading = false.obs;
  final showControls = true.obs;
  final errorMessage = Rx<String?>(null);

  // Actions
  void adjustOpacity(double value) {
    opacity.value = value;
  }

  void toggleControls() {
    showControls.value = !showControls.value;
  }

  Future<void> pickFigmaImage() async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await pickImageUseCase(NoParams());

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        Get.snackbar(
          'Error',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (image) {
        figmaImage.value = image;
      },
    );

    isLoading.value = false;
  }

  void resetOverlay() {
    figmaImage.value = null;
    opacity.value = AppConstants.defaultOpacity;
  }

  Future<void> loadImageFromPath(String path) async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      // Create a FigmaImage from the dropped file
      final fileName = path.split('/').last.split('\\').last;
      final image = FigmaImage(
        path: path,
        fileName: fileName,
        loadedAt: DateTime.now(),
      );

      figmaImage.value = image;

      Get.snackbar(
        'Success',
        'Image loaded: $fileName',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      errorMessage.value = 'Failed to load image: ${e.toString()}';
      Get.snackbar(
        'Error',
        errorMessage.value!,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
