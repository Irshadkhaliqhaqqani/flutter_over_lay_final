import 'dart:io';
import '../../domain/entities/figma_image.dart';

class FigmaImageModel extends FigmaImage {
  const FigmaImageModel({
    required super.path,
    required super.fileName,
    required super.loadedAt,
  });

  factory FigmaImageModel.fromFilePath(String path) {
    File(path);
    final fileName = path.split(Platform.pathSeparator).last;

    return FigmaImageModel(
      path: path,
      fileName: fileName,
      loadedAt: DateTime.now(),
    );
  }

  FigmaImage toEntity() {
    return FigmaImage(
      path: path,
      fileName: fileName,
      loadedAt: loadedAt,
    );
  }
}
