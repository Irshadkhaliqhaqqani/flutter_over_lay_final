import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appTitle = 'Overlay.io';
  static const String appName = 'Figma Design Overlay Tool';
  static const String appSubtitle =
      'is a lightweight, always-on-top desktop overlay that puts your assets, design tokens, and checklists directly onto your Figma canvas. Built for speed and precision, it streamlines your workflow by keeping your essential tools visible—even while you design.';

  // Window Sizes
  static const Size mainWindowSize = Size(1000, 700);
  static const Size overlayWindowSize = Size(350, 700);

  // Overlay Settings
  static const double defaultOpacity = 0.8;
  static const double minOpacity = 0.1;
  static const double maxOpacity = 1.0;

  // Messages
  static const String overlayInstruction =
      'Position the overlay window over your emulator/simulator';
  static const String dropZoneMessage = 'Here we Add or Drop the\nFigma Design';
  static const String clickToAddMessage = 'Click to Add Figma Design';

  // File Types
  static const List<String> supportedImageExtensions = [
    'png',
    'jpg',
    'jpeg',
    'svg'
  ];
}
