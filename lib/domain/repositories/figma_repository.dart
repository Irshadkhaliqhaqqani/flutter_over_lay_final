import '../entities/figma_file_entit.dart';

abstract class FigmaRepository {
  // Fetches file metadata (name, thumbnail, etc.)
  Future<FigmaFileEntity> getFigmaFile(String fileKey);

  // Fetches the temporary S3 URL for a rendered PNG
  Future<String> getFigmaImageUrl(String fileKey, String nodeId);
}
