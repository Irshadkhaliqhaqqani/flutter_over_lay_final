class FigmaFileEntity {
  final String name;
  final String lastModified;
  final String thumbnailUrl;
  String? imageUrl; // Stores the high-resolution PNG render

  FigmaFileEntity({
    required this.name,
    required this.lastModified,
    required this.thumbnailUrl,
    this.imageUrl,
  });
}
