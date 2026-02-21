import 'package:figma_overlay_clean/core/constants/app_colors.dart';
import 'package:figma_overlay_clean/core/constants/button_2.dart';
import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:figma_overlay_clean/presentation/authentication/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstSectionSignIn extends StatelessWidget {
  const FirstSectionSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          SvgPicture.asset(
            height: 80,
            width: 80,
            'assets/svgs/layer-group-solid-full (1).svg',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          Text(
            "Register",
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          GlassCard(
              padding: const EdgeInsetsGeometry.all(2),
              opacity: 0.1,
              borderRadius: 50,
              child: TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none)),
              )),
          const SizedBox(
            height: 10,
          ),
          GlassCard(
              padding: const EdgeInsetsGeometry.all(2),
              opacity: 0.1,
              borderRadius: 50,
              child: TextFormField(
                controller: controller.passwordController,
                decoration: const InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none)),
              )),
          const SizedBox(
            height: 10,
          ),
          GlassCard(
              padding: const EdgeInsetsGeometry.all(2),
              opacity: 0.1,
              borderRadius: 50,
              child: TextFormField(
                controller: controller.confirmPasswordController,
                decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none)),
              )),
          const SizedBox(
            height: 10,
          ),

          Obx(
            () => controller.isLoading.value
                ? const CircularProgressIndicator()
                : Button2(
                    onTap: () {
                      controller.register();
                    },
                    buttonText: "Sign In",
                    buttonColor: AppColors.primaryColor,
                    buttonHieght: 55,
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => Get.toNamed('login'),
            child: RichText(
                text: const TextSpan(children: [
              TextSpan(text: 'Already have an account:'),
              TextSpan(
                  text: ' Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ])),
          ),

          const SizedBox(
            height: 20,
          ),

          // Other Sign In Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlassCard(
                  opacity: 0.09,
                  borderRadius: 50,
                  child: Image.asset(
                    'assets/icons/figma.png',
                    height: 25,
                    width: 25,
                  )),
              const SizedBox(
                width: 8,
              ),
              GlassCard(
                  opacity: 0.09,
                  borderRadius: 50,
                  child: Image.asset(
                    'assets/icons/github.png',
                    height: 25,
                    width: 25,
                  )),
              const SizedBox(
                width: 8,
              ),
              GlassCard(
                  opacity: 0.09,
                  borderRadius: 50,
                  child: Image.asset(
                    'assets/icons/logo.png',
                    height: 25,
                    width: 25,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
