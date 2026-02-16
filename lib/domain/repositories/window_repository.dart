import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';

abstract class WindowRepository {
  Future<Either<Failure, void>> openOverlayWindow();
}
