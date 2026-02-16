import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/figma_image.dart';
import '../repositories/file_repository.dart';

class PickImageUseCase implements UseCase<FigmaImage, NoParams> {
  final FileRepository repository;
  
  PickImageUseCase(this.repository);
  
  @override
  Future<Either<Failure, FigmaImage>> call(NoParams params) async {
    return await repository.pickImage();
  }
}
