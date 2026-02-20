import 'dart:convert';
import 'package:figma_overlay_clean/domain/entities/figma_file_entit.dart';
import 'package:http/http.dart' as http;
import '../../domain/repositories/figma_repository.dart';
import '../models/figma_file_model.dart';

class FigmaRepositoryImpl implements FigmaRepository {
  final String personalAccessToken = "YOUR_FIGMA_TOKEN_HERE";

  @override
  Future<FigmaFileEntity> getFigmaFile(String fileKey) async {
    final response = await http.get(
      Uri.parse('https://api.figma.com/v1/files/$fileKey'),
      headers: {'X-Figma-Token': personalAccessToken},
    );

    if (response.statusCode == 200) {
      return FigmaFileModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Figma design');
    }
  }
}
