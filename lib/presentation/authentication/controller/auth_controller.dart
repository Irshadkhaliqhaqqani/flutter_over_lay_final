import 'dart:io';
import 'package:figma_overlay_clean/domain/repositories/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final AuthRepo _repo;
  AuthController(this._repo);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final loadingProgress = 0.0.obs;

  HttpServer? _oauthServer;
  var isLoading = false.obs;
  Rx<User?> currentUser = Rx<User?>(null);

  // ================= INIT =================

  @override
  void onInit() {
    super.onInit();

    debugPrint('🔔 AUTH CONTROLLER INITIALIZED');

    currentUser.value = _repo.currentUser;

    _repo.onAuthStateChange().listen((user) {
      debugPrint('🔄 AUTH STATE CHANGED → ${user?.email}');

      currentUser.value = user;

      if (user != null && Get.currentRoute != '/home') {
        Get.offAllNamed('/home');
      }
    });
  }

  // ================= OAUTH SERVER =================

  Future<void> _startOAuthServer() async {
    if (_oauthServer != null) return; // prevent multiple binds

    _oauthServer = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      3000,
    );

    debugPrint("✅ OAuth server running at http://localhost:3000");

    _oauthServer!.listen((HttpRequest request) async {
      final uri = request.uri;

      if (uri.path == '/callback') {
        debugPrint("🔔 OAuth callback: $uri");

        try {
          await Supabase.instance.client.auth.getSessionFromUrl(uri);

          request.response
            ..statusCode = 200
            ..write("Login successful! You can close this tab.")
            ..close();

          await _oauthServer?.close();
          _oauthServer = null;

          debugPrint("✅ OAuth completed & server closed");
        } catch (e) {
          debugPrint("❌ OAuth processing error: $e");
        }
      }
    });
  }

  // ================= EMAIL LOGIN =================

  Future<void> login() async {
    try {
      isLoading.value = true;
      await _repo.signIn(emailController.text, passwordController.text);
      _clearTextFields();
      Get.snackbar('Success', 'Welcome back!');
    } on AuthException catch (e) {
      Get.snackbar('Login Failed', e.message);
    } finally {
      isLoading.value = false;
    }
  }

  // ================= REGISTER =================

  Future<void> register() async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar('Error', 'Passwords do not match');
        return;
      }

      isLoading.value = true;
      await _repo.signUp(emailController.text, passwordController.text);
      _clearTextFields();
      Get.snackbar('Success', 'Check your email to confirm.');
    } on AuthException catch (e) {
      Get.snackbar('Failed', e.message);
    } finally {
      isLoading.value = false;
    }
  }

  // ================= LOGOUT =================

  Future<void> logout() async {
    await _repo.signOut();
    Get.offAllNamed('/register');
  }

  void _clearTextFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
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

      debugPrint("🚀 OAuth flow started for $provider");
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
}
