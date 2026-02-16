import 'package:figma_overlay_clean/core/constants/my_buttons.dart';
import 'package:flutter/material.dart';

class MainPageAppBar extends StatelessWidget {
  const MainPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return // App Bar
        Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Overlay.io",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        const Row(
          children: [
            Text(
              "Use case",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              "Pricing",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              "Features",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              "Contact",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
        MyButtons(
          text: 'Get Started',
          buttonColor: const Color(0xFF6A6677),
          onTap: () {},
        )
      ],
    );
  }
}
