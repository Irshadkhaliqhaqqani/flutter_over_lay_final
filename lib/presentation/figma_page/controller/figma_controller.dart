import 'package:figma_overlay_clean/core/utils/figma_url_parser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/repositories/figma_repository.dart';

class FigmaController extends GetxController {
  final FigmaRepository _repo;
  FigmaController(this._repo);

  final urlController = TextEditingController();
  var designUrl = "".obs;
  var isLoading = false.obs;

  Future<void> fetchDesign() async {
    if (isLoading.value) return;

    final params = FigmaUrlParser.parse(urlController.text);
    if (params == null || params['nodeId'] == null) {
      Get.snackbar("Error", "Please select a specific frame in Figma first.");
      return;
    }

    try {
      isLoading.value = true;
      // Step 1: Render the image link
      final imageUrl =
          await _repo.getFigmaImageUrl(params['fileKey']!, params['nodeId']!);
      designUrl.value = imageUrl;
      Get.snackbar("Success", "Design Ready!");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
