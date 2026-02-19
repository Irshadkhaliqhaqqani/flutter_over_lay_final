import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:figma_overlay_clean/presentation/home_page/controller/side_menu_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class TabBarSection extends StatelessWidget {
  const TabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final SideMenuBarController menuBarController =
        Get.put(SideMenuBarController());
    return SizedBox(
      height: double.infinity,
      child: GlassCard(
        padding: const EdgeInsetsGeometry.all(5),
        borderRadius: 16,
        opacity: 0.1,
        width: 80,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              height: 70,
              width: 70,
              child: SvgPicture.asset(
                'assets/svgs/layer-group-solid-full (1).svg',
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _buildSideItem(menuBarController, 0,
                "assets/svgs/house-regular-full.svg", 'Home'),
            const SizedBox(
              height: 10,
            ),
            _buildSideItem(menuBarController, 1,
                "assets/svgs/figma-brands-solid-full.svg", 'Figma Page'),
            const SizedBox(
              height: 10,
            ),
            _buildSideItem(menuBarController, 2,
                "assets/svgs/thumbs-up-regular-full.svg", 'Review'),
            const SizedBox(
              height: 10,
            ),
            _buildSideItem(menuBarController, 3,
                "assets/svgs/image-regular-full.svg", 'Image'),
            const SizedBox(
              height: 10,
            ),
            _buildSideItem(menuBarController, 4,
                "assets/svgs/list-solid-full.svg", 'Guide'),
          ],
        ),
      ),
    );
  }

  Widget _buildSideItem(SideMenuBarController controller, int index,
      String svgPth, String title) {
    return Obx(() {
      bool isSelected = controller.selectedIndex.value == index;
      return Tooltip(
        message: title,
        verticalOffset: 0,
        margin: const EdgeInsets.only(left: 55),
        preferBelow: false,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
        child: InkWell(
            onTap: () => controller.changePage(index),
            child: isSelected
                ? GlassCard(
                    padding: const EdgeInsets.all(18),
                    height: 70,
                    width: 70,
                    borderRadius: 12,
                    child: SvgPicture.asset(
                      svgPth,
                      colorFilter: ColorFilter.mode(
                          isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          BlendMode.srcIn),
                    ))
                : Container(
                    padding: const EdgeInsets.all(18),
                    height: 70,
                    width: 70,
                    child: SvgPicture.asset(
                      svgPth,
                      colorFilter: ColorFilter.mode(
                          isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          BlendMode.srcIn),
                    ),
                  )),
      );
    });
  }
}
