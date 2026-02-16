import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/overlay_controller.dart';
import '../widgets/overlay_body.dart';

class OverlayPage extends StatefulWidget {
  OverlayPage({Key? key}) : super(key: key);

  @override
  State<OverlayPage> createState() => _OverlayPageState();
}

class _OverlayPageState extends State<OverlayPage> {
  final OverlayController controller = Get.find<OverlayController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Expanded(
        child: OverlayBody(),
      ),
    );
  }
}
