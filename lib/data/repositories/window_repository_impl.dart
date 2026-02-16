import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/errors/failures.dart';
import '../../domain/repositories/window_repository.dart';
import '../../core/constants/app_constants.dart';

class WindowRepositoryImpl implements WindowRepository {
  @override
  Future<Either<Failure, void>> openOverlayWindow() async {
    try {
      // Get the executable path
      final executablePath = Platform.resolvedExecutable;

      // Launch a new instance of the app with 'overlay' argument
      await Process.start(
        executablePath,
        ['overlay'],
        mode: ProcessStartMode.detached,
      );

      return const Right(null);
    } catch (e) {
      return Left(
          WindowCreationFailure('Failed to open overlay: ${e.toString()}'));
    }
  }
}
