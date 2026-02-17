import 'package:figma_overlay_clean/core/constants/app_constants.dart';
import 'package:figma_overlay_clean/core/constants/button_1.dart';
import 'package:figma_overlay_clean/core/constants/button_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSec1 extends StatelessWidget {
  const HeroSec1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppConstants.appName,
            style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            AppConstants.appSubtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              Button1(
                buttonText: 'Start Demo',
                space: 5,
              ),
              SizedBox(
                width: 10,
              ),
              Button2(buttonText: 'Get Started')
            ],
          )
        ],
      ),
    );
  }
}
