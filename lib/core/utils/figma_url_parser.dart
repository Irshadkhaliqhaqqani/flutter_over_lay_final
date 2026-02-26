class FigmaUrlParser {
  static Map<String, String>? parse(String url) {
    // Regex to find the key and node ID
    final fileKeyMatch = RegExp(r"design/([^/]+)").firstMatch(url);
    final nodeIdMatch = RegExp(r"node-id=([^&]+)").firstMatch(url);

    if (fileKeyMatch != null && nodeIdMatch != null) {
      return {
        'fileKey': fileKeyMatch.group(1)!,
        // Figma uses colons (1:2) but URLs encode them as %3A
        'nodeId': nodeIdMatch.group(1)!.replaceAll('%3A', ':'),
      };
    }
    return null;
  }
}
