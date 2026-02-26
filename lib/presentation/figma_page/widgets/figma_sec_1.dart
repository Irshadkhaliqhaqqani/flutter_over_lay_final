import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:figma_overlay_clean/presentation/figma_page/controller/figma_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class FigmaSec1 extends StatelessWidget {
  final controller = Get.find<FigmaController>();
  FigmaSec1({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Obx(() {
          if (controller.designUrl.isEmpty) {
            return const Text("Nothing Found");
          }
          return GlassCard(
              opacity: 0.1,
              child: Center(
                  child: Image.network(
                controller.designUrl.value,
                fit: BoxFit.contain,
              )));
        }));
  }
}
