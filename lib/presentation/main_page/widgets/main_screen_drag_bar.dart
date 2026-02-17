import 'package:figma_overlay_clean/presentation/main_page/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:window_manager/window_manager.dart';

class MainScreenDragBar extends GetView<MainController> {
  const MainScreenDragBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) async {
        await windowManager.startDragging();
      },
      child: Container(
        height: 40,
        color: const Color(0xFF14073D),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.layers,
                  color: Colors.white.withOpacity(0.7),
                  size: 16,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Overlay.io',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.7), fontSize: 12),
                ),
              ],
            ),

            // windoes , Controll

            Row(
              children: [
                IconButton(
                    onPressed: () => windowManager.minimize(),
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 18,
                    )),
                Obx(() => IconButton(
                      onPressed: () => controller.toggleMaximize(),
                      icon: Icon(
                        controller.isMaximixed.value
                            ? Icons.filter_none
                            : Icons.crop_square,
                        color: Colors.white,
                        size: 16,
                      ),
                    )),
                IconButton(
                    onPressed: () => windowManager.close(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
