import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:figma_overlay_clean/presentation/controllers/main_controller.dart';
import 'package:figma_overlay_clean/presentation/controllers/side_menu_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MainPageHeroSection extends GetView<MainController> {
  const MainPageHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final SideMenuBarController menuBarController =
        Get.put(SideMenuBarController());
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/hero_image2.jfif',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              GlassCard(
                padding: const EdgeInsetsGeometry.all(5),
                borderRadius: 16,
                opacity: 0.1,
                height: double.infinity,
                width: 80,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 70,
                      width: 70,
                      child: SvgPicture.asset(
                        'assets/svgs/layer-group-solid-full (1).svg',
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildSideItem(menuBarController, 0,
                        "assets/svgs/house-regular-full.svg"),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildSideItem(menuBarController, 1,
                        "assets/svgs/figma-brands-solid-full.svg"),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildSideItem(menuBarController, 2,
                        "assets/svgs/thumbs-up-regular-full.svg"),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildSideItem(menuBarController, 3,
                        "assets/svgs/image-regular-full.svg"),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildSideItem(menuBarController, 4,
                        "assets/svgs/list-solid-full.svg"),
                  ],
                ),
              ),
              Expanded(
                  child: Obx(() => Container(
                        padding: const EdgeInsets.all(20),
                        child: menuBarController.currentPage,
                      )))
            ],
          ),
        )
      ]),
    );
  }

  Widget _buildSideItem(
      SideMenuBarController controller, int index, String svgPth) {
    return Obx(() {
      bool isSelected = controller.selectedIndex.value == index;
      return InkWell(
          onTap: () => controller.changePage(index),
          child: isSelected
              ? GlassCard(
                  padding: EdgeInsets.all(18),
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
                  padding: EdgeInsets.all(18),
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
                ));
    });
  }
}
