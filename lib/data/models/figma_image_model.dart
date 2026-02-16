import 'dart:io';
import '../../domain/entities/figma_image.dart';

class FigmaImageModel extends FigmaImage {
  const FigmaImageModel({
    required String path,
    required String fileName,
    required DateTime loadedAt,
  }) : super(
          path: path,
          fileName: fileName,
          loadedAt: loadedAt,
        );
  
  factory FigmaImageModel.fromFilePath(String path) {
    final file = File(path);
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
