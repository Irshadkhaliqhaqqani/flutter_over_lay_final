import 'package:figma_overlay_clean/presentation/authentication/controller/auth_controller.dart';
import 'package:figma_overlay_clean/presentation/splash_screen/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'assets/hero_image2.jpg',
              width: double.infinity,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Check your assets');
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                height: 80,
                width: 80,
                'assets/svgs/layer-group-solid-full (1).svg',
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              Text(
                "Overlay.io",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Obx(() => LinearProgressIndicator(
                    value: controller.loadingProgress.value,
                    backgroundColor: Colors.white10,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(10),
                  )),
              const SizedBox(height: 10),
              const Text("Checking design session...",
                  style: TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ]),
      ),
    );
  }
}
