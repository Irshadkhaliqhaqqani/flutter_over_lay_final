import 'package:figma_overlay_clean/domain/entities/figma_file_entit.dart';

abstract class FigmaRepository {
  Future<FigmaFileEntity> getFigmaFile(String fileKey);
}
