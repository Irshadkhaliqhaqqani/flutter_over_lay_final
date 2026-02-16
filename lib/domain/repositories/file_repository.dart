import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/figma_image.dart';

abstract class FileRepository {
  Future<Either<Failure, FigmaImage>> pickImage();
}
