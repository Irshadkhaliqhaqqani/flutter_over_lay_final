import 'package:figma_overlay_clean/data/repositories/figma_repo_impl.dart';
import 'package:figma_overlay_clean/domain/repositories/figma_repository.dart';
import 'package:figma_overlay_clean/domain/usecases/pick_image_usecase.dart';
import 'package:figma_overlay_clean/presentation/figma_page/controller/figma_controller.dart';
import 'package:figma_overlay_clean/presentation/figma_page/controller/figma_page_controller.dart';
import 'package:figma_overlay_clean/presentation/home_page/controller/side_menu_bar_controller.dart';
import 'package:figma_overlay_clean/presentation/overlay_page/controller/overlay_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Repositories and UseCases (Dependencies for Controllers)
    Get.lazyPut<FigmaRepository>(() => FigmaRepositoryImpl(), fenix: true);
    // Note: Ensure your PickImageUseCase implementation is available
    Get.lazyPut(() => PickImageUseCase(Get.find()), fenix: true);

    // 2. Persistent Controllers (Stay in memory for the whole session)
    Get.put(SideMenuBarController(), permanent: true);

    // 3. Feature Controllers (Loaded when needed)
    // fenix: true allows them to be recreated if the user navigates back to the page
    Get.lazyPut(() => FigmaController(repository: Get.find()), fenix: true);
    Get.lazyPut(() => FigmaPageController(), fenix: true);
    Get.lazyPut(() => OverlayController(Get.find()), fenix: true);
  }
}
