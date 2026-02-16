import 'dart:ui';

import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:figma_overlay_clean/presentation/widgets/main_page_app_bar.dart';
import 'package:figma_overlay_clean/presentation/widgets/main_page_hero_section.dart';
import 'package:figma_overlay_clean/presentation/widgets/main_screen_drag_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

import 'dart:ui';
// ... other imports

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
