import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:desktop_drop/desktop_drop.dart';
import '../../../core/constants/app_constants.dart';
import '../controller/overlay_controller.dart';

class OverlayDropZone extends StatefulWidget {
  OverlayDropZone({Key? key}) : super(key: key);

  @override
  State<OverlayDropZone> createState() => _OverlayDropZoneState();
}

class _OverlayDropZoneState extends State<OverlayDropZone> {
  final OverlayController controller = Get.find<OverlayController>();
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragEntered: (details) {
        setState(() {
          _isDragging = true;
        });
      },
      onDragExited: (details) {
        setState(() {
          _isDragging = false;
        });
      },
      onDragDone: (details) async {
        setState(() {
          _isDragging = false;
        });

        // Handle dropped files
        if (details.files.isNotEmpty) {
          final file = details.files.first;
          final extension = file.path.split('.').last.toLowerCase();

          // Check if it's a supported image format
          if (AppConstants.supportedImageExtensions.contains(extension)) {
            controller.loadImageFromPath(file.path);
          } else {
            Get.snackbar(
              'Invalid File',
              'Please drop a PNG, JPG, JPEG, or SVG file',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withOpacity(0.8),
              colorText: Colors.white,
            );
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: _isDragging
              ? Border.all(
                  color: Colors.blue,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignInside,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Drop indicator when dragging
              if (_isDragging)
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_download,
                        size: 60,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Drop Image Here',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              // Normal UI when not dragging
              if (!_isDragging)
                Obx(() => GestureDetector(
                      onTap: controller.isLoading.value
                          ? null
                          : controller.pickFigmaImage,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.8),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: controller.isLoading.value
                            ? const Padding(
                                padding: EdgeInsets.all(20),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Icon(
                                Icons.add,
                                size: 50,
                                color: Colors.white,
                              ),
                      ),
                    )),

              if (!_isDragging) const SizedBox(height: 20),

              if (!_isDragging)
                const Text(
                  AppConstants.dropZoneMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),

              if (!_isDragging) const SizedBox(height: 10),

              if (!_isDragging)
                Text(
                  'or drag & drop an image here',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
