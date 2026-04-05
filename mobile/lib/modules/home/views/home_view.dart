import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/modules/home/controllers/home_controller.dart';
import 'package:mobile/routes/app_routes.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildSloganCard(),
              const SizedBox(height: 30),
              _buildMenuGrid(),
              const SizedBox(height: 30),
              _buildSOSButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
                  'Bonjour ${controller.userName.value},',
                  style: Get.textTheme.headlineMedium,
                )),
            const Text(
              'Vous êtes en sécurité ici.',
              style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
            ),
          ],
        ),
        Obx(() => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: controller.anonMode.value ? AppColors.secondary.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    controller.anonMode.value ? Icons.security_rounded : Icons.person_outline_rounded,
                    size: 20,
                    color: controller.anonMode.value ? AppColors.textPrimary : Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    controller.anonMode.value ? 'Anonyme' : 'Public',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: controller.anonMode.value ? AppColors.textPrimary : Colors.grey,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildSloganCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.warmGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.favorite_rounded, color: Colors.white, size: 30),
          const SizedBox(height: 15),
          Text(
            '"Mieux connaître ses droits c\'est mieux vivre"',
            style: Get.textTheme.displayLarge?.copyWith(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.9,
      children: [
        _buildMenuCard('Signalement', Icons.record_voice_over_rounded, AppRoutes.SUBMISSIONS),
        _buildMenuCard('Diagnostic', Icons.health_and_safety_rounded, AppRoutes.DIAGNOSTICS),
        _buildMenuCard('Lois RDC', Icons.menu_book_rounded, AppRoutes.LAWS),
        _buildMenuCard('Communauté', Icons.forum_rounded, AppRoutes.COMMUNITY),
        _buildMenuCard('Avocats', Icons.gavel_rounded, AppRoutes.CABINET),
        _buildMenuCard('Paramètres', Icons.settings_rounded, AppRoutes.PROFILE),
      ],
    );
  }

  Widget _buildMenuCard(String title, IconData icon, String route) {
    return InkWell(
      onTap: route.isNotEmpty ? () => Get.toNamed(route) : null,
      borderRadius: BorderRadius.circular(24),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.textPrimary,
        padding: const EdgeInsets.symmetric(vertical: 18),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'URGENCE SOS',
            style: TextStyle(letterSpacing: 2),
          ),
        ],
      ),
    );
  }
}
