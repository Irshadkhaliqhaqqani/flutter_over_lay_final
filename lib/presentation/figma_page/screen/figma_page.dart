import 'package:figma_overlay_clean/core/constants/review_section.dart';
import 'package:figma_overlay_clean/presentation/figma_page/widgets/figma_app_bar.dart';
import 'package:figma_overlay_clean/presentation/figma_page/widgets/figma_sec_1.dart';
import 'package:figma_overlay_clean/presentation/figma_page/widgets/figma_sec_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FigmaPage extends StatelessWidget {
  const FigmaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FigmaAppBar(),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FigmaSec1(),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    FigmaSec2(),
                    SizedBox(
                      height: 10,
                    ),
                    ReviewSection(),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
