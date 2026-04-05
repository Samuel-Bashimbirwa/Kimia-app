import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/modules/auth/controllers/auth_controller.dart';
import 'package:mobile/routes/app_routes.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 100),
              _buildIllustration(),
              const SizedBox(height: 40),
              Text(
                'Bienvenue sur Kimia',
                style: Get.textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              const Text(
                'Connectez-vous pour accéder à votre espace sécurisé.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 40),
              Obx(() => Column(
                    children: [
                      TextField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          hintText: 'Pseudo ou Email',
                          prefixIcon: Icon(Icons.person_outline, color: AppColors.primary),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controller.passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Mot de passe',
                          prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 40),
                      controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: controller.login,
                              child: const Text('SE CONNECTER'),
                            ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.REGISTER),
                        child: const Text(
                          'Pas encore de compte ? Inscrivez-vous',
                          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.shield_rounded,
          size: 80,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
