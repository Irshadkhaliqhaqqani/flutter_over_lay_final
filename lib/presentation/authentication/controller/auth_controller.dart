import 'dart:async';
import 'dart:io';
import 'package:figma_overlay_clean/domain/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final AuthRepo _repo;
  AuthController(this._repo);

  // ================= STATE =================

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final currentUser = Rx<User?>(null);
  final loadingProgress = 0.0.obs;

  HttpServer? _oauthServer;
  StreamSubscription? _authSubscription;

  // ================= INIT =================

  @override
  void onInit() {
    super.onInit();

    debugPrint("🔔 AuthController initialized");

    // Restore existing session (important for desktop)
    currentUser.value = Supabase.instance.client.auth.currentUser;

    // Listen to auth state changes
    _authSubscription =
        Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      currentUser.value = session?.user;

      debugPrint(
          "🔄 Auth state changed → ${session?.user?.email ?? "No user"}");
    });
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // ================= EMAIL LOGIN =================

  Future<void> login() async {
    try {
      isLoading.value = true;

      await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      _clearTextFields();
      Get.snackbar("Success", "Welcome back!");
    } on AuthException catch (e) {
      Get.snackbar("Login Failed", e.message);
    } finally {
      isLoading.value = false;
    }
  }

  // ================= REGISTER =================

  Future<void> register() async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar("Error", "Passwords do not match");
        return;
      }

      isLoading.value = true;

      await Supabase.instance.client.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      _clearTextFields();
      Get.snackbar("Success", "Check your email to confirm.");
    } on AuthException catch (e) {
      Get.snackbar("Register Failed", e.message);
    } finally {
      isLoading.value = false;
    }
  }

  // ================= LOGOUT =================

  Future<void> logout() async {
    try {
      isLoading.value = true;

      if (_oauthServer != null) {
        await _oauthServer!.close(force: true);
        _oauthServer = null;
      }

      await Supabase.instance.client.auth.signOut();

      currentUser.value = null;

      debugPrint("✅ Logged out successfully");
    } catch (e) {
      debugPrint("❌ Logout error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _clearTextFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // ================= OAUTH SERVER (DESKTOP) =================

  Future<void> _startOAuthServer() async {
    if (_oauthServer != null) return;

    _oauthServer = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);

    debugPrint("✅ OAuth server running on http://localhost:3000");

    _oauthServer!.listen((HttpRequest request) async {
      final uri = request.uri;

      if (uri.path == '/callback') {
        try {
          await Supabase.instance.client.auth.getSessionFromUrl(uri);

          request.response
            ..statusCode = 200
            ..write("Login successful! You can close this tab.")
            ..close();

          await _oauthServer?.close();
          _oauthServer = null;

          debugPrint("✅ OAuth completed");
        } catch (e) {
          debugPrint("❌ OAuth error: $e");
        }
      }
    });
  }

  // ================= OAUTH LOGIN =================

  Future<void> _loginWithOAuth(OAuthProvider provider) async {
    try {
      isLoading.value = true;

      await _startOAuthServer();

      await Supabase.instance.client.auth.signInWithOAuth(
        provider,
        redirectTo: 'http://localhost:3000/callback',
        authScreenLaunchMode: LaunchMode.externalApplication,
      );

      debugPrint("🚀 OAuth started for $provider");
    } catch (e) {
      Get.snackbar("OAuth Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginWithGitHub() async {
    await _loginWithOAuth(OAuthProvider.github);
  }

  Future<void> loginWithFigma() async {
    await _loginWithOAuth(OAuthProvider.figma);
  }

  // ================= HELPERS =================

  String get displayName {
    final user = currentUser.value;
    return user?.userMetadata?['full_name'] ??
        user?.userMetadata?['name'] ??
        user?.email ??
        "User";
  }

  String get provider {
    return currentUser.value?.appMetadata?['provider'] ?? "email";
  }
}
