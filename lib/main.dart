import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';
import 'core/constants/app_constants.dart';
import 'presentation/pages/main_control_panel_page.dart';
import 'presentation/pages/overlay_page.dart';
import 'core/utils/dependency_injection.dart';

void main(List<String> args) async {
  // Ensure the Flutter framework is ready before native calls
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialize Window Manager
  await windowManager.ensureInitialized();

  // Initialize your GetX dependencies
  DependencyInjection.init();

  // Check for the 'overlay' command-line argument
  final isOverlayWindow = args.isNotEmpty && args.first == 'overlay';

  if (isOverlayWindow) {
    // === OVERLAY WINDOW CONFIGURATION ===
    const windowOptions = WindowOptions(
      size: AppConstants.overlayWindowSize,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      alwaysOnTop: true, // Crucial for a figma-style overlay
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAsFrameless();
      await windowManager.show();
      await windowManager.setBackgroundColor(Colors.transparent);
    });

    runApp(const OverlayApp());
  } else {
    // === MAIN WINDOW CONFIGURATION ===
    const windowOptions = WindowOptions(
      size: AppConstants.mainWindowSize,
      center: true,
      backgroundColor: Colors.transparent,
      title: AppConstants.appTitle,
      titleBarStyle: TitleBarStyle.hidden,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAsFrameless(); // Removes the standard Win32 frame
      await windowManager.show();
      await windowManager.setBackgroundColor(Colors.transparent);
    });

    runApp(const MainApp());
  }
}

// ============================================
// MAIN APP - Glassmorphism Container
// ============================================
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Ensure the very base layer of the app is transparent
      builder: (context, child) {
        return Container(
          color: Colors.transparent,
          child: child,
        );
      },
      title: AppConstants.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness:
            Brightness.dark, // Reference image uses dark-mode aesthetics
      ),
      home: MainControlPanelPage(),
    );
  }
}

// ============================================
// OVERLAY APP
// ============================================
class OverlayApp extends StatelessWidget {
  const OverlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) =>
          Container(color: Colors.transparent, child: child),
      title: 'Overlay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: OverlayPage(),
    );
  }
}
