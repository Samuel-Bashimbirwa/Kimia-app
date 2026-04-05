import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/models/forms/violence_forms.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/modules/submissions/controllers/submission_controller.dart';

class SubmissionsView extends GetView<SubmissionController> {
  const SubmissionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signaler une violence')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          _buildTypeCard(
            'Violence au travail',
            Icons.work_history_rounded,
            'Harcèlement, discrimination, abus de pouvoir...',
            () => _showWorkForm(context),
          ),
          const SizedBox(height: 16),
          _buildTypeCard(
            'Violence à la maison',
            Icons.home_rounded,
            'Violences conjugales, familiales, maltraitance...',
            () => _showHomeForm(context),
          ),
          const SizedBox(height: 16),
          _buildTypeCard(
            'Violence dans les transports',
            Icons.directions_bus_rounded,
            'Agressions de rue, harcèlement dans les bus...',
            () => _showTransportForm(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeCard(String title, IconData icon, String subtitle, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 28, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(fontSize: 12, color: AppColors.textPrimary.withOpacity(0.7))),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textPrimary),
            ],
          ),
        ),
      ),
    );
  }

  // Example Dialog for Work Form. In a scalable app, these would be separate files/routes.
  void _showWorkForm(BuildContext context) {
    final companyController = TextEditingController();
    final relationController = TextEditingController();
    final detailsController = TextEditingController();

    Get.defaultDialog(
      title: 'Violence au travail',
      content: Column(
        children: [
          TextField(controller: companyController, decoration: const InputDecoration(labelText: 'Nom de l\'entreprise')),
          TextField(controller: relationController, decoration: const InputDecoration(labelText: 'Lien (Ex: Manager, Collègue)')),
          TextField(controller: detailsController, maxLines: 3, decoration: const InputDecoration(labelText: 'Détails')),
        ],
      ),
      textConfirm: 'Envoyer',
      onConfirm: () {
        final form = WorkViolenceForm(
          companyName: companyController.text,
          relationToAggressor: relationController.text,
          details: detailsController.text,
        );
        controller.submitViolenceReport(form);
      },
    );
  }

  void _showHomeForm(BuildContext context) {
    final relationController = TextEditingController();
    final detailsController = TextEditingController();
    bool childrenPresent = false;

    Get.defaultDialog(
      title: 'Violence à la maison',
      content: Column(
        children: [
          TextField(controller: relationController, decoration: const InputDecoration(labelText: 'Lien (Ex: Conjoint, Parent)')),
          TextField(controller: detailsController, maxLines: 3, decoration: const InputDecoration(labelText: 'Détails')),
          // Checkbox for children could be added using StatefulBuilder
        ],
      ),
      textConfirm: 'Envoyer',
      onConfirm: () {
        final form = HomeViolenceForm(
          relationToAggressor: relationController.text,
          childrenPresent: childrenPresent,
          details: detailsController.text,
        );
        controller.submitViolenceReport(form);
      },
    );
  }

  void _showTransportForm(BuildContext context) {
    final transportController = TextEditingController();
    final locationController = TextEditingController();
    final detailsController = TextEditingController();

    Get.defaultDialog(
      title: 'Violence transport',
      content: Column(
        children: [
          TextField(controller: transportController, decoration: const InputDecoration(labelText: 'Type (Bus, Taxi...)')),
          TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Lieu / Ligne')),
          TextField(controller: detailsController, maxLines: 3, decoration: const InputDecoration(labelText: 'Détails')),
        ],
      ),
      textConfirm: 'Envoyer',
      onConfirm: () {
        final form = TransportViolenceForm(
          transportType: transportController.text,
          location: locationController.text,
          details: detailsController.text,
        );
        controller.submitViolenceReport(form);
      },
    );
  }
}
