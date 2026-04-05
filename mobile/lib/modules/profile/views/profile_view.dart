import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background.withOpacity(0.5),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('MON COMPTE'),
                  _buildSettingsGroup([
                    Obx(
                      () => _buildSettingTile(
                        icon: Icons.person_rounded,
                        title: 'Pseudo',
                        value: controller.user.value?.pseudo ?? 'Chargement...',
                        onTap: () => _showEditBottomSheet(
                          context,
                          'Pseudo',
                          controller.pseudoController,
                        ),
                      ),
                    ),
                    Obx(
                      () => _buildSettingTile(
                        icon: Icons.phone_iphone_rounded,
                        title: 'Lien (Urgence)',
                        value:
                            controller.user.value?.emergencyContact ??
                            'Non configuré',
                        onTap: () => _showEditBottomSheet(
                          context,
                          'Lien SOS WhatsApp',
                          controller.phoneController,
                          hint: '+243',
                        ),
                      ),
                    ),
                  ]),

                  const SizedBox(height: 24),
                  _buildSectionTitle('SÉCURITÉ & ACTIVITÉ'),
                  _buildSettingsGroup([
                    _buildSettingTile(
                      icon: Icons.history_rounded,
                      title: 'Mon Historique',
                      onTap: () => _showHistoryBottomSheet(context),
                    ),
                    _buildSettingTile(
                      icon: Icons.security_rounded,
                      title: 'Confidentialité',
                      onTap: () {},
                    ),
                  ]),

                  const SizedBox(height: 24),
                  _buildSectionTitle('ASSISTANCE'),
                  _buildSettingsGroup([
                    _buildSettingTile(
                      icon: Icons.help_outline_rounded,
                      title: 'Aide & Support',
                      onTap: () {},
                    ),
                    _buildSettingTile(
                      icon: Icons.logout_rounded,
                      title: 'Déconnexion',
                      textColor: AppColors.error,
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 220.0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        background: Container(
          decoration: const BoxDecoration(gradient: AppColors.warmGradient),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              _buildAvatarSection(),
              const SizedBox(height: 12),
              Obx(
                () => Text(
                  controller.user.value?.pseudo ?? 'Bonjour',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                'Membre depuis 2024',
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
            image: const DecorationImage(
              image: NetworkImage('https://via.placeholder.com/150'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 14,
          child: Icon(
            Icons.camera_alt_rounded,
            size: 16,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          final int index = entry.key;
          final Widget child = entry.value;
          return Column(
            children: [
              child,
              if (index < children.length - 1)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 1,
                    thickness: 0.5,
                    color: Color(0xFFEEEEEE),
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? value,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (textColor ?? AppColors.primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: textColor ?? AppColors.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? AppColors.textPrimary,
                ),
              ),
            ),
            if (value != null)
              Text(
                value,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showEditBottomSheet(
    BuildContext context,
    String label,
    TextEditingController textController, {
    String? hint,
  }) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Modifier mon $label',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: label,
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              autofocus: true,
            ),
            const SizedBox(height: 32),
            Obx(
              () => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        controller.updateProfile();
                        Get.back();
                      },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('ENREGISTRER'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showHistoryBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.85,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mon Historique d\'Activité',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  _buildHistoryCard(
                    'Signalement #1234',
                    'Traité - Protection accordée',
                    Icons.security_rounded,
                  ),
                  _buildHistoryCard(
                    'Participation Forum',
                    'Commentaire dans "Témoignages"',
                    Icons.forum_rounded,
                  ),
                  _buildHistoryCard(
                    'Consultation Cabinet',
                    'Me. Sarah Kabange - 02/04/2026',
                    Icons.gavel_rounded,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildHistoryCard(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 13)),
      ),
    );
  }
}
