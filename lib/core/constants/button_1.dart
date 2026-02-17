import 'package:figma_overlay_clean/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final String buttonText;
  final double? space;
  const Button1({super.key, required this.buttonText, this.space});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.ternitaryColor.withOpacity(0.1))),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/button_icon.png',
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: space,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Center(
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }
}
