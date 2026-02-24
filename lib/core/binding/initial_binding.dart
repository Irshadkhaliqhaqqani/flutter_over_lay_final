import 'package:figma_overlay_clean/data/repositories/auth_repo_impl.dart';
import 'package:figma_overlay_clean/data/repositories/figma_repo_impl.dart';
import 'package:figma_overlay_clean/data/repositories/file_repository_impl.dart';
import 'package:figma_overlay_clean/data/repositories/window_repository_impl.dart';
import 'package:figma_overlay_clean/domain/repositories/auth_repo.dart';
import 'package:figma_overlay_clean/domain/repositories/figma_repository.dart';
import 'package:figma_overlay_clean/domain/repositories/file_repository.dart';
import 'package:figma_overlay_clean/domain/repositories/window_repository.dart';
import 'package:figma_overlay_clean/domain/usecases/pick_image_usecase.dart';
import 'package:figma_overlay_clean/domain/usecases/open_overlay_window_usecase.dart';
import 'package:figma_overlay_clean/presentation/authentication/controller/auth_controller.dart';
import 'package:figma_overlay_clean/presentation/figma_page/controller/figma_controller.dart';
import 'package:figma_overlay_clean/presentation/figma_page/controller/figma_page_controller.dart';
import 'package:figma_overlay_clean/presentation/home_page/controller/side_menu_bar_controller.dart';
import 'package:figma_overlay_clean/presentation/main_page/controller/main_controller.dart';
import 'package:figma_overlay_clean/presentation/overlay_page/controller/overlay_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Repositories and UseCases (Dependencies for Controllers)
    Get.lazyPut<FileRepository>(() => FileRepositoryImpl());
    Get.lazyPut<WindowRepository>(() => WindowRepositoryImpl());
    Get.lazyPut<FigmaRepository>(() => FigmaRepositoryImpl(), fenix: true);
    Get.lazyPut<AuthRepo>(() => AuthRepoImpl());
    
    // Use Cases
    Get.lazyPut(() => PickImageUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => OpenOverlayWindowUseCase(Get.find()));

    // 2. Persistent Controllers (Stay in memory for the whole session)
    Get.put(SideMenuBarController(), permanent: true);
    Get.put(AuthController(Get.find<AuthRepo>()), permanent: true);
    Get.put(MainController(Get.find()), permanent: true);

    // 3. Feature Controllers (Loaded when needed)
    // fenix: true allows them to be recreated if the user navigates back to the page
    Get.lazyPut(() => FigmaController(repository: Get.find()), fenix: true);
    Get.lazyPut(() => FigmaPageController(), fenix: true);
    Get.lazyPut(() => OverlayController(Get.find()), fenix: true);
  }
}
