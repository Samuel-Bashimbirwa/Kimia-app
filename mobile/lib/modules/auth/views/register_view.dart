import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/modules/auth/controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un compte'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Bienvenue chez Kimia',
              style: Get.textTheme.displayLarge?.copyWith(fontSize: 24, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 10),
            const Text(
              'Inscrivez-vous pour bénéficier d\'un accompagnement personnalisé et sécurisé.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 40),
            Obx(() => Column(
                  children: [
                    TextField(
                      controller: controller.pseudoController,
                      decoration: const InputDecoration(
                        hintText: 'Pseudo (Pour rester anonyme)',
                        prefixIcon: Icon(Icons.face_unlock_rounded, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email (Facultatif)',
                        prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
                      ),
                      keyboardType: TextInputType.emailAddress,
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
                            onPressed: controller.register,
                            child: const Text('CRÉER MON COMPTE'),
                          ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
