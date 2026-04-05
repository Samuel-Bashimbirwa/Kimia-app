import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/services/api_service.dart';
import 'package:mobile/core/services/storage_service.dart';
import 'package:mobile/routes/app_routes.dart';

class AuthController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final StorageService _storage = Get.find<StorageService>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final pseudoController = TextEditingController(); // For registration

  final isLoading = false.obs;

  Future<void> login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _api.postForm('/auth/login', {
        'username': emailController.text, // OAuth2PasswordRequestForm expects username
        'password': passwordController.text,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];
        if (token != null) {
          await _storage.saveToken(token);
          Get.snackbar('Success', 'Logged in successfully', snackPosition: SnackPosition.BOTTOM);
          Get.offAllNamed(AppRoutes.HOME);
        }
      } else {
        Get.snackbar('Login Failed', jsonDecode(response.body)['detail'] ?? 'Unknown error', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error occurred', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty || pseudoController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _api.post('/auth/register', {
        'email': emailController.text,
        'password': passwordController.text,
        'pseudo': pseudoController.text,
      });

      if (response.statusCode == 200) {
        Get.snackbar('Registration Success', 'Please login now.', snackPosition: SnackPosition.BOTTOM);
        Get.offNamed(AppRoutes.LOGIN);
      } else {
        Get.snackbar('Registration Failed', jsonDecode(response.body)['detail'] ?? 'Unknown error', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error occurred', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    await _storage.removeToken();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    pseudoController.dispose();
    super.onClose();
  }
}
