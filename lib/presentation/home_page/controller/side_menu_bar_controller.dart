import 'package:figma_overlay_clean/presentation/figma_page/screen/figma_page.dart';
import 'package:figma_overlay_clean/presentation/home_page/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class SideMenuBarController extends GetxController {
  var selectedIndex = 0.obs;
  void changePage(int index) {
    selectedIndex.value = index;
  }

  Widget get currentPage {
    switch (selectedIndex.value) {
      case 0:
        return const Center(
          child: HomePage(),
        );
      case 1:
        return const Center(
          child: FigmaPage(),
        );
      case 2:
        return const Center(
          child: Text("review"),
        );
      case 3:
        return const Center(
          child: Text("List"),
        );
      case 4:
        return const Center(
          child: Text("image"),
        );
      default:
        return const Center(
          child: Text("Page Not Found"),
        );
    }
  }
}
