import '../../domain/entities/figma_file_entit.dart';

class FigmaFileModel extends FigmaFileEntity {
  FigmaFileModel({
    required super.name,
    required super.lastModified,
    required super.thumbnailUrl,
    super.imageUrl,
  });

  factory FigmaFileModel.fromJson(Map<String, dynamic> json,
      {String? highResUrl}) {
    return FigmaFileModel(
      name: json['name'] ?? 'Unknown',
      lastModified: json['lastModified'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      imageUrl: highResUrl,
    );
  }
}
