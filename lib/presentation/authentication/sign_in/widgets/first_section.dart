import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstSection extends StatelessWidget {
  const FirstSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          height: 80,
          width: 80,
          'assets/svgs/layer-group-solid-full (1).svg',
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        Text(
          "Register",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        GlassCard(
            height: 60,
            opacity: 0.1,
            borderRadius: 50,
            child: SizedBox(
              height: 60,
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Username',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ))
      ],
    );
  }
}
