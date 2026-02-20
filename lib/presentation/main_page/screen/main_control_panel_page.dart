import 'package:figma_overlay_clean/presentation/home_page/controller/side_menu_bar_controller.dart';
import 'package:figma_overlay_clean/presentation/main_page/controller/main_controller.dart';
import 'package:figma_overlay_clean/presentation/main_page/widgets/main_screen_drag_bar.dart';
import 'package:figma_overlay_clean/presentation/main_page/widgets/tab_bar_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainControlPanelPage extends StatelessWidget {
  MainControlPanelPage({super.key});
  final MainController controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    final SideMenuBarController menuBarController =
        Get.put(SideMenuBarController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'assets/hero_image2.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Check your assets');
              },
            ),
          ),
          Column(
            children: [
              const MainScreenDragBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const TabBarSection(),
                      Expanded(
                          child: Obx(() => Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: menuBarController.currentPage,
                              )))
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
