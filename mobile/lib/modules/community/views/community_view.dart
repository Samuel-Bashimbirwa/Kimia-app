import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/modules/community/controllers/community_controller.dart';

class CommunityView extends GetView<CommunityController> {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communauté & Forum'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary),
            onPressed: () => _showCreatePostBottomSheet(context),
          )
        ],
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.posts.isEmpty) {
                return const Center(child: Text('Aucun message dans cette catégorie.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  final post = controller.posts[index];
                  return _buildPostCard(post);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostBottomSheet(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.edit_note_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = controller.categories[index];
          return Obx(() {
            final isSelected = controller.selectedCategory.value == cat['id'];
            return ChoiceChip(
              label: Text(cat['label']!),
              selected: isSelected,
              onSelected: (_) => controller.changeCategory(cat['id']!),
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary),
            );
          });
        },
      ),
    );
  }

  Widget _buildPostCard(dynamic post) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: const Icon(Icons.person, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Utilisatrice Anonyme', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(post.createdAt),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(post.title, style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(post.content, style: const TextStyle(height: 1.4)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite_border_rounded, size: 20, color: Colors.pink),
                    const SizedBox(width: 5),
                    Text('${post.likes}'),
                    const SizedBox(width: 20),
                    const Icon(Icons.chat_bubble_outline_rounded, size: 20, color: AppColors.primary),
                    const SizedBox(width: 5),
                    const Text('Commenter'),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    post.category,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCreatePostBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Partager avec la communauté', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('Sélectionnez une catégorie :'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: controller.categories.map((cat) {
                  return ChoiceChip(
                    label: Text(cat['label']!),
                    selected: controller.selectedCategory.value == cat['id'],
                    onSelected: (_) => controller.selectedCategory.value = cat['id']!,
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.titleController,
                decoration: const InputDecoration(labelText: 'Titre de votre post'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Contenu du message',
                  hintText: 'Exprimez-vous ici...',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 30),
              Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () => controller.createPost(controller.selectedCategory.value),
                      child: const Text('PUBLIER'),
                    )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
