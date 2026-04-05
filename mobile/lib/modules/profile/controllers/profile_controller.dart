import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/services/api_service.dart';
import 'package:mobile/data/models/user_model.dart';

class ProfileController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final user = Rxn<UserModel>();
  final isLoading = false.obs;

  final pseudoController = TextEditingController();
  final phoneController = TextEditingController(); // Le "Lien" SOS

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;
    try {
      final response = await _api.get('/users/profile');
      if (response.statusCode == 200) {
        user.value = UserModel.fromJson(jsonDecode(response.body));
        pseudoController.text = user.value?.pseudo ?? '';
        phoneController.text = user.value?.emergencyContact ?? '';
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger le profil');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile() async {
    if (pseudoController.text.isEmpty) {
      Get.snackbar('Erreur', 'Le pseudo est obligatoire');
      return;
    }

    isLoading.value = true;
    try {
      final response = await _api.patch('/users/profile', {
        'pseudo': pseudoController.text,
        'emergencyContact': phoneController.text,
      });

      if (response.statusCode == 200) {
        user.value = UserModel.fromJson(jsonDecode(response.body));
        Get.snackbar('Succès', 'Profil mis à jour avec succès', snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Erreur', 'Échec de la mise à jour');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur réseau');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    pseudoController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
