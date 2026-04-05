import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/services/api_service.dart';
import 'package:mobile/data/models/post_model.dart';

class CommunityController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final posts = <PostModel>[].obs;
  final isLoading = false.obs;
  final selectedCategory = 'TESTIMONY'.obs;

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final categories = [
    {'id': 'NEWS', 'label': 'Justice'},
    {'id': 'TESTIMONY', 'label': 'Témoignages'},
    {'id': 'COMFORT', 'label': 'Soutien'},
    {'id': 'HELP', 'label': 'Aide'},
  ];

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    try {
      // Assuming endpoint handles category as query param
      final response = await _api.get('/community/posts?category=${selectedCategory.value}');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        posts.assignAll(data.map((p) => PostModel.fromJson(p)).toList());
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger le forum');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createPost(String category) async {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      Get.snackbar('Attention', 'Veuillez remplir tous les champs');
      return;
    }

    isLoading.value = true;
    try {
      final response = await _api.post('/community/posts', {
        'title': titleController.text,
        'content': contentController.text,
        'category': category,
        'topicId': '65fd5a9d2f4a1c1d8c1c1c1c', // Placeholder for a default topic
      });

      if (response.statusCode == 201) {
        titleController.clear();
        contentController.clear();
        Get.back();
        fetchPosts();
        Get.snackbar('Succès', 'Votre message a été publié', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de publier');
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    fetchPosts();
  }
}
