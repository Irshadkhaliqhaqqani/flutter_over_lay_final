import 'package:figma_overlay_clean/core/constants/app_colors.dart';
import 'package:figma_overlay_clean/core/constants/button_1.dart';
import 'package:figma_overlay_clean/core/constants/button_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSec3 extends StatelessWidget {
  const HeroSec3({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size.width * 0.07;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Active Projects',
          style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),

        // Images
        Expanded(
          child: Row(
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.ternitaryColor.withOpacity(0.2))),
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.ternitaryColor.withOpacity(0.2))),
              )),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.ternitaryColor.withOpacity(0.2))),
              )),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              filled: true,
              hintText: 'Select Your Emulator',
              hintStyle: const TextStyle(fontSize: 14),
              fillColor: Colors.white.withOpacity(0.1),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none)),
        ),
        const SizedBox(
          height: 10,
        ),

        SizedBox(
            height: 48,
            child: Button1(
              buttonText: "Start Overlay Mode",
              space: media,
            ))
      ],
    );
  }
}
