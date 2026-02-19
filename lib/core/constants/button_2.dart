import 'package:figma_overlay_clean/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Button2 extends StatelessWidget {
  final String buttonText;
  final double? buttonHieght;
  final Color? buttonColor;
  const Button2(
      {super.key,
      required this.buttonText,
      this.buttonHieght,
      this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: buttonHieght,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.ternitaryColor.withOpacity(0.1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
