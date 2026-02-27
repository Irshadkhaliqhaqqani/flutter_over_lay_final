class FigmaUrlParser {
  static Map<String, String>? parse(String url) {
    // Finds the file key after 'design/'
    final fileKeyMatch = RegExp(r"design/([^/]+)").firstMatch(url);
    final nodeIdMatch = RegExp(r"node-id=([^&]+)").firstMatch(url);

    if (fileKeyMatch != null && nodeIdMatch != null) {
      String nodeId = nodeIdMatch.group(1)!;

      // Clean up the nodeId by replacing URL encoding
      nodeId = Uri.decodeComponent(nodeId);

      return {
        'fileKey': fileKeyMatch.group(1)!,
        'nodeId': nodeId,
      };
    }
    return null;
  }
}
