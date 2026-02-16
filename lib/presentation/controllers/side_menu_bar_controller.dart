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
          child: Text("Home"),
        );
      case 1:
        return const Center(
          child: Text("figma"),
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
