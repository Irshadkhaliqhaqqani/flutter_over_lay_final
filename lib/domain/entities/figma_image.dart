import 'package:flutter/foundation.dart';

@immutable
class FigmaImage {
  final String path;
  final String fileName;
  final DateTime loadedAt;
  
  const FigmaImage({
    required this.path,
    required this.fileName,
    required this.loadedAt,
  });
  
  FigmaImage copyWith({
    String? path,
    String? fileName,
    DateTime? loadedAt,
  }) {
    return FigmaImage(
      path: path ?? this.path,
      fileName: fileName ?? this.fileName,
      loadedAt: loadedAt ?? this.loadedAt,
    );
  }
}
