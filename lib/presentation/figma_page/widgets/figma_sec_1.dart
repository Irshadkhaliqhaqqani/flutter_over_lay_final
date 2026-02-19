import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:flutter/material.dart';

class FigmaSec1 extends StatelessWidget {
  const FigmaSec1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        flex: 2,
        child: GlassCard(
            opacity: 0.1,
            child: Center(
              child: Text("Please Fetch the Design"),
            )));
  }
}
