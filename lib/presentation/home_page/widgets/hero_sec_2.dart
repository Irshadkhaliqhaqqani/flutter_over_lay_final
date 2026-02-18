import 'package:figma_overlay_clean/core/constants/button_2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSec2 extends StatelessWidget {
  const HeroSec2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Imported Desgin Figma',
            style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                filled: true,
                hintText: 'Paste Fimga URL . (http.design/home)',
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
          Row(
            children: [
              SvgPicture.asset(
                height: 24,
                width: 24,
                "assets/svgs/circle-dot-regular-full.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.green, BlendMode.srcIn),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text("Figma API Connected"),
              const Spacer(),
              const Button2(buttonText: 'Fetch Desgin'),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
              text: const TextSpan(children: [
            TextSpan(
                text: 'Note:', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    ' Go to your Figma design and copy the URL of project then paste here'),
          ]))
        ],
      ),
    );
  }
}
