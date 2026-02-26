import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:figma_overlay_clean/core/constants/review_section.dart';
import 'package:figma_overlay_clean/presentation/authentication/controller/auth_controller.dart';
import 'package:figma_overlay_clean/presentation/home_page/widgets/hero_sec_1.dart';
import 'package:figma_overlay_clean/presentation/home_page/widgets/hero_sec_2.dart';
import 'package:figma_overlay_clean/presentation/home_page/widgets/hero_sec_3.dart';
import 'package:figma_overlay_clean/presentation/home_page/widgets/hero_sec_4.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Column(
      children: [
        // First Section
        const Expanded(
          child: Row(
            children: [
              Expanded(flex: 4, child: HeroSec1()),
              SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: GlassCard(opacity: 0.1, child: HeroSec2()),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Second Section
        const Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: GlassCard(opacity: 0.1, child: HeroSec3()),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: GlassCard(opacity: 0.1, child: HeroSec4()),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Updated Review Row

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ReviewSection(),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome ${controller.displayName}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text("Account: ${controller.provider.toUpperCase()}"),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: controller.logout,
                    icon: const Icon(Icons.power_off),
                  ),
                ],
              );
            })
          ],
        )
      ],
    );
  }
}
