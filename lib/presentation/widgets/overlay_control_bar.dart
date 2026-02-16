import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import '../controllers/overlay_controller.dart';

class OverlayControlBar extends StatelessWidget {
  OverlayControlBar({Key? key}) : super(key: key);

  final OverlayController controller = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            // Drag handle (takes up most of the space)
            Expanded(
              child: GestureDetector(
                onPanStart: (details) async {
                  await windowManager.startDragging();
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.move,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.drag_indicator,
                          color: Colors.white.withOpacity(0.7),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Overlay',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Opacity slider
            Obx(() => SizedBox(
                  width: 130,
                  child: Row(
                    children: [
                      Icon(
                        Icons.opacity,
                        color: Colors.white.withOpacity(0.7),
                        size: 16,
                      ),
                      Expanded(
                        child: Slider(
                          value: controller.opacity.value,
                          min: 0.1,
                          max: 1.0,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white.withOpacity(0.3),
                          onChanged: (value) {
                            controller.adjustOpacity(value);
                          },
                        ),
                      ),
                    ],
                  ),
                )),

            // Reset button
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
              tooltip: 'Reset Image',
              onPressed: () {
                controller.resetOverlay();
              },
            ),

            // Close button
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 20),
              tooltip: 'Close Overlay',
              onPressed: () async {
                await windowManager.close();
              },
            ),
          ],
        ),
      ),
    );
  }
}
