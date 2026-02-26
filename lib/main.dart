import 'package:figma_overlay_clean/core/binding/initial_binding.dart';
import 'package:figma_overlay_clean/presentation/authentication/controller/auth_gate.dart';
import 'package:figma_overlay_clean/presentation/authentication/login/screen/login_page.dart';
import 'package:figma_overlay_clean/presentation/authentication/sign_in/screen/sign_in_page.dart';
import 'package:figma_overlay_clean/presentation/main_page/screen/main_control_panel_page.dart';
import 'package:figma_overlay_clean/presentation/splash_screen/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:window_manager/window_manager.dart';
import 'core/constants/app_constants.dart';
import 'presentation/overlay_page/screen/overlay_page.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mieeoyivlkvjcxjiswly.supabase.co',
    anonKey: 'sb_publishable_siSxEBtxgD8Y8i1Go1_aXg_JvS9gLD2',
  );

  await windowManager.ensureInitialized();

  final isOverlayWindow = args.isNotEmpty && args.first == 'overlay';

  if (isOverlayWindow) {
    const windowOptions = WindowOptions(
      size: AppConstants.overlayWindowSize,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
      alwaysOnTop: true,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAsFrameless();
      await windowManager.show();
      await windowManager.setBackgroundColor(Colors.transparent);
    });

    runApp(const OverlayApp());
  } else {
    const windowOptions = WindowOptions(
      size: AppConstants.mainWindowSize,
      center: true,
      backgroundColor: Colors.transparent,
      title: AppConstants.appTitle,
      titleBarStyle: TitleBarStyle.hidden,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.setAsFrameless();
      await windowManager.show();
      await windowManager.setBackgroundColor(Colors.transparent);
    });

    runApp(const MainApp());
  }
}

// Main App
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
        brightness: Brightness.dark,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.grey,
              ),
        ),
      ),
      initialBinding: InitialBinding(),
      defaultTransition: Transition.fade,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/authGate', page: () => const AuthGate()),
        GetPage(name: '/register', page: () => const SignInPage()),
        GetPage(name: '/home', page: () => MainControlPanelPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
      ],
    );
  }
}

// Overlay App
class OverlayApp extends StatelessWidget {
  const OverlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => Container(
        color: Colors.transparent,
        child: child,
      ),
      title: 'Overlay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const OverlayPage(),
    );
  }
}
