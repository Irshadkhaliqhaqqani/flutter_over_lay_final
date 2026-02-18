abstract class Failure {
  final String message;

  const Failure(this.message);
}

class FilePickerFailure extends Failure {
  const FilePickerFailure(super.message);
}

class WindowCreationFailure extends Failure {
  const WindowCreationFailure(super.message);
}

class ImageLoadFailure extends Failure {
  const ImageLoadFailure(super.message);
}
