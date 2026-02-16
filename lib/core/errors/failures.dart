abstract class Failure {
  final String message;
  
  const Failure(this.message);
}

class FilePickerFailure extends Failure {
  const FilePickerFailure(String message) : super(message);
}

class WindowCreationFailure extends Failure {
  const WindowCreationFailure(String message) : super(message);
}

class ImageLoadFailure extends Failure {
  const ImageLoadFailure(String message) : super(message);
}
