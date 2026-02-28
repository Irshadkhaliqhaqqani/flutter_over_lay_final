import 'package:flutter/foundation.dart';

class FigmaUrlParser {
  static Map<String, String?>? parse(String url) {
    debugPrint('🔍 Parsing Figma URL: $url');
    
    // Try design URL first (with node-id parameter)
    final fileKeyMatch = RegExp(r"design/([^/]+)").firstMatch(url);
    final nodeIdMatch = RegExp(r"node-id=([^&]+)").firstMatch(url);
    
    debugPrint('🔍 Design URL - File key match: ${fileKeyMatch?.group(1)}');
    debugPrint('🔍 Design URL - Node ID match: ${nodeIdMatch?.group(1)}');
    
    if (fileKeyMatch != null && nodeIdMatch != null) {
      String nodeId = nodeIdMatch.group(1)!;

      // Clean up the nodeId by replacing URL encoding
      nodeId = Uri.decodeComponent(nodeId);
      
      debugPrint('🔍 Cleaned node ID: $nodeId');
      debugPrint('🔍 Final parsed (design): fileKey=${fileKeyMatch.group(1)}, nodeId=$nodeId');

      return {
        'fileKey': fileKeyMatch.group(1)!,
        'nodeId': nodeId,
      };
    }
    
    // Try file URL (without node-id parameter)
    final fileKeyMatch2 = RegExp(r"file/([^/]+)").firstMatch(url);
    debugPrint('🔍 File URL - File key match: ${fileKeyMatch2?.group(1)}');
    
    if (fileKeyMatch2 != null) {
      debugPrint('🔍 Final parsed (file): fileKey=${fileKeyMatch2.group(1)}, nodeId=null');
      return {
        'fileKey': fileKeyMatch2.group(1)!,
        'nodeId': null,
      };
    }
    
    debugPrint('🔍 URL parsing failed - no matches found');
    return null;
  }
}
