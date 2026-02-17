import 'package:figma_overlay_clean/presentation/main_page/controller/main_controller.dart';
import 'package:figma_overlay_clean/presentation/main_page/widgets/main_page_hero_section.dart';
import 'package:figma_overlay_clean/presentation/main_page/widgets/main_screen_drag_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainControlPanelPage extends StatelessWidget {
  MainControlPanelPage({super.key});
  final MainController controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: const Column(
          children: [
            MainScreenDragBar(),
            Expanded(
              child: Center(child: MainPageHeroSection()),
            )
          ],
        ),
      ),
    );
  }
}
