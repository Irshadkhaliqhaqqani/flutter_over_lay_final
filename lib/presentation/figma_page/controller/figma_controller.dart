import 'package:figma_overlay_clean/domain/entities/figma_file_entit.dart';
import 'package:get/get.dart';
import '../../../domain/repositories/figma_repository.dart';

class FigmaController extends GetxController {
  final FigmaRepository repository;
  FigmaController({required this.repository});

  var isLoading = false.obs;
  var figmaFile = Rxn<FigmaFileEntity>();

  Future<void> fetchDesign(String url) async {
    // Basic regex to extract file key from Figma URL
    final RegExp regExp = RegExp(r"file/([^/?]+)");
    final match = regExp.firstMatch(url);

    if (match != null) {
      String fileKey = match.group(1)!;
      try {
        isLoading.value = true;
        final result = await repository.getFigmaFile(fileKey);
        figmaFile.value = result;
      } finally {
        isLoading.value = false;
      }
    }
  }
}
