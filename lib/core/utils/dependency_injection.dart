import 'package:get/get.dart';
import '../../data/repositories/file_repository_impl.dart';
import '../../data/repositories/window_repository_impl.dart';
import '../../domain/repositories/file_repository.dart';
import '../../domain/repositories/window_repository.dart';
import '../../domain/usecases/open_overlay_window_usecase.dart';
import '../../domain/usecases/pick_image_usecase.dart';
import '../../presentation/controllers/main_controller.dart';
import '../../presentation/controllers/overlay_controller.dart';

class DependencyInjection {
  static void init() {
    // Repositories
    Get.lazyPut<FileRepository>(() => FileRepositoryImpl());
    Get.lazyPut<WindowRepository>(() => WindowRepositoryImpl());
    
    // Use Cases
    Get.lazyPut(() => OpenOverlayWindowUseCase(Get.find()));
    Get.lazyPut(() => PickImageUseCase(Get.find()));
    
    // Controllers
    Get.lazyPut(() => MainController(Get.find()));
    Get.lazyPut(() => OverlayController(Get.find()));
  }
}
