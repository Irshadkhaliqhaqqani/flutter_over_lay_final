import 'package:figma_overlay_clean/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Button2 extends StatelessWidget {
  final String buttonText;
  const Button2({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.ternitaryColor.withOpacity(0.1))),
      child: Row(
        children: [
          Text(
            buttonText,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
