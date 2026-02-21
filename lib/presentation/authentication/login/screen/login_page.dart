import 'package:figma_overlay_clean/presentation/authentication/controller/auth_controller.dart';
import 'package:figma_overlay_clean/presentation/authentication/login/widgets/first_section_login.dart';
import 'package:figma_overlay_clean/presentation/authentication/sign_in/widgets/second_section.dart';
import 'package:figma_overlay_clean/presentation/main_page/widgets/main_screen_drag_bar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Column(
            children: [
              MainScreenDragBar(),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    // First Section
                    Expanded(child: FirstSectionLogin()),
                    // Second Section
                    Expanded(child: SecondSection())
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
