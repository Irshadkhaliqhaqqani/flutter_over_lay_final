import 'package:figma_overlay_clean/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          SizedBox(
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
          VerticalDivider(
            color: Colors.white.withOpacity(0.3),
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
    );
  }

  // Widget for review circles
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
