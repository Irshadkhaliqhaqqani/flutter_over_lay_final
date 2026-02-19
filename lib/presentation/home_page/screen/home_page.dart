import 'package:figma_overlay_clean/core/constants/app_colors.dart';
import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:figma_overlay_clean/core/constants/review_section.dart';
import 'package:figma_overlay_clean/presentation/home_page/widgets/hero_sec_1.dart';
import 'package:figma_overlay_clean/presentation/home_page/widgets/hero_sec_2.dart';
import 'package:figma_overlay_clean/presentation/home_page/widgets/hero_sec_3.dart';
import 'package:figma_overlay_clean/presentation/home_page/widgets/hero_sec_4.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // First Section
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 4, child: HeroSec1()),
              SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: GlassCard(opacity: 0.1, child: HeroSec2()),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),

        // Second Section
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: GlassCard(opacity: 0.1, child: HeroSec3()),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 4,
                child: GlassCard(opacity: 0.1, child: HeroSec4()),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),

        // Updated Review Row

        ReviewSection()
      ],
    );
  }
}
