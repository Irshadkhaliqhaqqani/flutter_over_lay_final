import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/figma_image.dart';
import '../../domain/repositories/file_repository.dart';
import '../models/figma_image_model.dart';

class FileRepositoryImpl implements FileRepository {
  @override
  Future<Either<Failure, FigmaImage>> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      
      if (result == null || result.files.single.path == null) {
        return const Left(FilePickerFailure('No file selected'));
      }
      
      final filePath = result.files.single.path!;
      final imageModel = FigmaImageModel.fromFilePath(filePath);
      
      return Right(imageModel.toEntity());
    } catch (e) {
      return Left(FilePickerFailure('Failed to pick image: ${e.toString()}'));
    }
  }
}
