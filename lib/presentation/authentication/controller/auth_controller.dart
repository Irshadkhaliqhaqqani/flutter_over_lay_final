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
  var loadingProgress = 0.0.obs;

  // obsevables

  var isLoading = false.obs;
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    currentUser.value = _repo.currentUser;
    _repo.onAuthStateChange().listen((user) {
      debugPrint('AuthController: Auth state changed - User: ${user?.email ?? 'null'}');
      currentUser.value = user;
      // Navigate to home when user auth state changes (OAuth completion)
      // Only navigate if we're not already on home page
      if (user != null && Get.currentRoute != '/home') {
        debugPrint('AuthController: Navigating to home page');
        Get.offAllNamed('/home');
      }
    });
    _startAppLogic();
  }

  // Splash

  Future<void> _startAppLogic() async {
    // 1. Fill the progress bar over 3 seconds
    const totalSteps = 30; // Update every 100ms for smoothness
    for (int i = 1; i <= totalSteps; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      loadingProgress.value = i / totalSteps;
    }

    // 2. Check the initial session from your repository
    final user = _repo.currentUser;

    if (user != null) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/register');
    }
  }

  // Login Method
  Future<void> login() async {
    try {
      isLoading.value = true;
      await _repo.signIn(emailController.text, passwordController.text);

      _clearTextFields();

      // Success
      Get.toNamed('/home');
      Get.snackbar('Success', 'Well back');
    } on AuthException catch (e) {
      if (e.message.contains("Email not confirmed")) {
        Get.snackbar(
          'Action Required',
          'Please check your email and confirm your account before logging in.',
          backgroundColor: Colors.orangeAccent,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar('Login Failed', e.message);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Register in

  Future<void> register() async {
    try {
      if (passwordController.text != confirmPasswordController.text) {
        Get.snackbar('Error', 'Password do not match');
      }
      isLoading.value = true;

      await _repo.signUp(emailController.text, passwordController.text);

      _clearTextFields();
      // success
      Get.toNamed('/home');
      Get.snackbar('Sucess', 'Account Created');
    } on AuthException catch (e) {
      Get.snackbar('Failed', 'Account are not  Created');
    } finally {
      isLoading.value = false;
    }
  }

  // Logout

  Future<void> logout() async {
    await _repo.signOut();
    Get.toNamed('/register');
  }

  // Helper for  clear textediting controllers

  void _clearTextFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // Social authentication

  // Git hub authentication method

  Future<void> loginWithGitHub() async {
    try {
      debugPrint('AuthController: Starting GitHub login');
      isLoading.value = true;
      await _repo.signInWithGitHub();
      debugPrint('AuthController: GitHub login initiated successfully');
    } catch (e) {
      debugPrint('AuthController: GitHub login error: $e');
      Get.snackbar(
        "GitHub Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Git hub authentication method

  Future<void> loginWithFigma() async {
    try {
      debugPrint('AuthController: Starting Figma login');
      isLoading.value = true;
      await _repo.signInWithFigma();
      debugPrint('AuthController: Figma login initiated successfully');
    } catch (e) {
      debugPrint('AuthController: Figma login error: $e');
      Get.snackbar(
        "Figma Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
