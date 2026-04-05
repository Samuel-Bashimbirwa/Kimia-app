import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/modules/cabinet/controllers/cabinet_controller.dart';
import 'package:mobile/data/models/lawyer_model.dart';

class CabinetView extends GetView<CabinetController> {
  const CabinetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cabinets & Avocats'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.lawyers.isEmpty) {
          return const Center(child: Text('Aucun cabinet disponible pour le moment.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.lawyers.length,
          itemBuilder: (context, index) {
            final lawyer = controller.lawyers[index];
            return _buildLawyerCard(lawyer);
          },
        );
      }),
    );
  }

  Widget _buildLawyerCard(LawyerModel lawyer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.gavel_rounded, color: AppColors.primary),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lawyer.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(lawyer.specialty, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.phone_rounded,
                  label: 'Appeler',
                  onTap: () => controller.contactLawyer(lawyer.phone),
                ),
                _buildActionButton(
                  icon: Icons.alternate_email_rounded,
                  label: 'Email',
                  onTap: () => controller.emailLawyer(lawyer.contactEmail),
                ),
                _buildActionButton(
                  icon: Icons.bookmark_border_rounded,
                  label: 'Prendre RDV',
                  onTap: () => Get.snackbar('Info', 'Prise de rendez-vous bientôt disponible'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
