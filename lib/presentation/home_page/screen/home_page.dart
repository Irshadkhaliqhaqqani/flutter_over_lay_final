import 'package:figma_overlay_clean/core/constants/app_colors.dart';
import 'package:figma_overlay_clean/core/constants/glass_card.dart';
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
    return Column(
      children: [
        // First Section
        const Expanded(
          child: Row(
            children: [
              Expanded(flex: 3, child: HeroSec1()),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: GlassCard(opacity: 0.1, child: HeroSec2()),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Second Section
        const Expanded(
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
        const SizedBox(height: 10),

        // Updated Review Row
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Row(
            children: [
              // Fixed width for the Stack to prevent infinite width errors
              SizedBox(
                height: 50,
                width: 120,
                child: Stack(
                  children: [
                    Positioned(left: 0, child: _buildReviewContainer()),
                    Positioned(left: 25, child: _buildReviewContainer()),
                    Positioned(left: 50, child: _buildReviewContainer()),
                    Positioned(left: 75, child: _buildReviewContainer()),
                  ],
                ),
              ),

              // Added a label for context using your Poppins/Inter
              // style
              SizedBox(
                height: 35,
                child: VerticalDivider(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              Text(
                "Trusted by 50+ Teams",
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Optimized Helper Widget for review circles
  Widget _buildReviewContainer() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          // Ensure ternitaryColor is defined in your AppColors
          color: AppColors.ternitaryColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.person, size: 20, color: Colors.grey),
      ),
    );
  }
}
