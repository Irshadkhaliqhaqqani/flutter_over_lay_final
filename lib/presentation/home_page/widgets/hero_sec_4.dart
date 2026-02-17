import 'package:figma_overlay_clean/core/constants/app_colors.dart';
import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSec4 extends StatelessWidget {
  const HeroSec4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Team Presets',
          style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTiles('assets/svgs/house-regular-full.svg'),
                const SizedBox(
                  height: 10,
                ),
                _buildTiles('assets/svgs/figma-brands-solid-full.svg'),
                const SizedBox(
                  height: 10,
                ),
                _buildTiles('assets/svgs/list-solid-full.svg'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // build tiles

  Widget _buildTiles(String svgPath) {
    return GlassCard(
        opacity: 0.1,
        padding: const EdgeInsets.all(5),
        borderRadius: 50,
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                svgPath,
                colorFilter: const ColorFilter.mode(
                    AppColors.secondaryColor, BlendMode.srcIn),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('Home Screen - iOS (85% Opacity)'),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_right_rounded)
          ],
        ));
  }
}
