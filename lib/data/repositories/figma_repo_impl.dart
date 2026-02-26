import 'dart:convert';
import 'package:figma_overlay_clean/domain/entities/figma_file_entit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/figma_repository.dart';
import '../models/figma_file_model.dart';

class FigmaRepositoryImpl implements FigmaRepository {
  final _client = Supabase.instance.client;

  @override
  Future<String> getFigmaImageUrl(String fileKey, String nodeId) async {
    final token = _client.auth.currentSession?.providerToken; // OAuth token
    if (token == null) throw Exception("Please login with Figma.");

    final response = await http.get(
      Uri.parse(
          'https://api.figma.com/v1/images/$fileKey?ids=$nodeId&format=png&scale=2'),
      headers: {'Authorization': 'Bearer $token'}, // Bearer auth
    );

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
    final response = await http.get(
      Uri.parse('https://api.figma.com/v1/files/$fileKey'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return FigmaFileModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Failed to load file metadata");
  }
}
