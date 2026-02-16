import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../repositories/window_repository.dart';

class OpenOverlayWindowUseCase implements UseCase<void, NoParams> {
  final WindowRepository repository;
  
  OpenOverlayWindowUseCase(this.repository);
  
  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.openOverlayWindow();
  }
}
