import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import '../controllers/overlay_controller.dart';
import 'overlay_control_bar.dart';
import 'overlay_drop_zone.dart';
import 'overlay_image_preview.dart';

class OverlayBody extends StatelessWidget {
  OverlayBody({Key? key}) : super(key: key);

  final OverlayController controller = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => MouseRegion(
          onEnter: (_) => controller.showControls.value = true,
          child: Stack(
            children: [
              // Main overlay canvas - NOW FULLY TRANSPARENT WITH OPACITY
              Opacity(
                opacity: controller.opacity.value,
                child: GestureDetector(
                  // Double-tap to toggle controls
                  onDoubleTap: controller.toggleControls,
                  // Right-click or long-press to drag window
                  onSecondaryTapDown: (details) async {
                    await windowManager.startDragging();
                  },
                  onLongPressStart: (details) async {
                    await windowManager.startDragging();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: controller.figmaImage.value == null
                        ? OverlayDropZone()
                        : OverlayImagePreview(),
                  ),
                ),
              ),

              // Top control bar (always visible or on hover)
              if (controller.showControls.value) OverlayControlBar(),
            ],
          ),
        ));
  }
}
