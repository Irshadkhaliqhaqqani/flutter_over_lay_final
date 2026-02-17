import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/overlay_controller.dart';

class OverlayImagePreview extends StatelessWidget {
  OverlayImagePreview({Key? key}) : super(key: key);

  final OverlayController controller = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final image = controller.figmaImage.value;

      if (image == null) {
        return const SizedBox.shrink();
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Image
            Center(
              child: Image.file(
                File(image.path),
                fit: BoxFit.contain,
              ),
            ),
            // File info overlay
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.image, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            image.fileName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Loaded: ${_formatTime(image.loadedAt)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 20),
                      onPressed: controller.resetOverlay,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}
