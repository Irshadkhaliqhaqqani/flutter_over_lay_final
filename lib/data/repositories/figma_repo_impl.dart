import 'dart:convert';
import 'package:figma_overlay_clean/domain/entities/figma_file_entit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/figma_repository.dart';
import '../models/figma_file_model.dart';

class FigmaRepositoryImpl implements FigmaRepository {
  final _client = Supabase.instance.client;
  final _storage = const FlutterSecureStorage();

  @override
  Future<String> getFigmaImageUrl(String fileKey, String nodeId) async {
    // 1. Try to get the token from the current session
    String? token = _client.auth.currentSession?.providerToken;
    debugPrint('🔍 Figma token from session: ${token != null ? "Found" : "Not found"}');

    // 2. If session is null (after restart), read it from secure storage
    if (token == null) {
      token = await _storage.read(key: 'figma_token');
      debugPrint('🔍 Figma token from storage: ${token != null ? "Found" : "Not found"}');
    }

    // 3. Only throw if both are missing
    if (token == null) throw Exception("Please login with Figma.");

    debugPrint('🔍 Using Figma token: ${token.substring(0, 10)}...');
    debugPrint('🔍 Requesting: https://api.figma.com/v1/images/$fileKey?ids=$nodeId&format=png&scale=2');

    final response = await http.get(
      Uri.parse(
          'https://api.figma.com/v1/images/$fileKey?ids=$nodeId&format=png&scale=2'),
      headers: {'Authorization': 'Bearer $token'},
    );

    debugPrint('🔍 Figma API Response Status: ${response.statusCode}');
    debugPrint('🔍 Figma API Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['images'][nodeId];
    } else {
      debugPrint("FIGMA API ERROR: ${response.body}");
      throw Exception(
          "Figma Error ${response.statusCode}: ${jsonDecode(response.body)['err']}");
    }
  }

  @override
  Future<FigmaFileEntity> getFigmaFile(String fileKey) async {
    final token = _client.auth.currentSession?.providerToken;
    debugPrint('🔍 Figma token for file access: ${token != null ? "Found" : "Not found"}');
    debugPrint('🔍 Requesting file: https://api.figma.com/v1/files/$fileKey');
    
    final response = await http.get(
      Uri.parse('https://api.figma.com/v1/files/$fileKey'),
      headers: {'Authorization': 'Bearer $token'},
    );

    debugPrint('🔍 Figma File API Status: ${response.statusCode}');
    debugPrint('🔍 Figma File API Body: ${response.body}');

    if (response.statusCode == 200) {
      return FigmaFileModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load file metadata");
  }
}
