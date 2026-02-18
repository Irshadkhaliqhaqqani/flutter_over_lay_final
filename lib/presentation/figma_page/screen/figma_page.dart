import 'package:figma_overlay_clean/core/constants/glass_card.dart';
import 'package:figma_overlay_clean/presentation/figma_page/controller/figma_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class FigmaPage extends StatelessWidget {
  const FigmaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FigmaPageController controller = Get.put(FigmaPageController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Figma Imported UI",
              style:
                  GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold),
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

        // Below section
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: Row(
            children: [
              const Expanded(
                  flex: 2,
                  child: GlassCard(
                      opacity: 0.1,
                      child: Center(
                        child: Text("Please Fetch the Design"),
                      ))),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: GlassCard(
                      opacity: 0.1,
                      height: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Overlay Settings",
                            style: GoogleFonts.inter(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Opacity", style: TextStyle(fontSize: 12)),
                          const SizedBox(
                            height: 10,
                          ),
                          buildOverlaySlider(0.4, context),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Zoom Opacity",
                                  style: TextStyle(fontSize: 14)),
                              Transform.scale(
                                scale: 0.8,
                                child: Obx(
                                  () => CupertinoSwitch(
                                      activeColor: Colors.grey,
                                      value: controller.isToggled.value,
                                      onChanged: (value) =>
                                          controller.toggleSwitch(value)),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    height: 28,
                                    width: 28,
                                    'assets/svgs/lock-solid-full.svg',
                                    fit: BoxFit.contain,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("Lock Position",
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                              SvgPicture.asset(
                                height: 28,
                                width: 28,
                                'assets/svgs/circle-check-regular-full.svg',
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              )
                            ],
                          ),

                          // Screen section
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Top-Left"),
                              Text("Center"),
                              Text("Fill Screen"),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                height: 50,
                                width: 50,
                                'assets/svgs/align-box-top-left-stroke-rounded.svg',
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                              SvgPicture.asset(
                                height: 50,
                                width: 50,
                                'assets/svgs/align-box-middle-center-stroke-rounded.svg',
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                              SvgPicture.asset(
                                height: 50,
                                width: 50,
                                'assets/svgs/align-box-bottom-center-stroke-rounded.svg',
                                colorFilter: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                            ],
                          )
                        ],
                      ))),
            ],
          ),
        )
      ],
    );
  }

  Widget buildOverlaySlider(double currentValue, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Labels Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${(currentValue * 100).toInt()}%",
                style: const TextStyle(color: Colors.white)),
            const Text("2x", style: TextStyle(color: Colors.white)),
          ],
        ),
        // Custom Styled Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
            activeTrackColor: Colors.white,
            inactiveTrackColor: Colors.white24,
            thumbColor: Colors.white,
          ),
          child: Slider(
            value: currentValue,
            onChanged: (value) {
              // Update your controller state here
            },
          ),
        ),
      ],
    );
  }
}
