import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FigmaAppBar extends StatelessWidget {
  const FigmaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Figma Imported UI",
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              SvgPicture.asset(
                height: 24,
                width: 24,
                "assets/svgs/check-solid-full.svg",
                colorFilter:
                    const ColorFilter.mode(Colors.green, BlendMode.srcIn),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text('Status Up to Date'),
              const SizedBox(
                width: 10,
              ),
              const Icon(Icons.refresh_rounded)
            ],
          ),
        ],
      ),
    );
  }
}
