import 'dart:convert';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile/core/services/api_service.dart';
import 'package:mobile/data/models/user_model.dart';

class HomeController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final userName = 'Marie'.obs; 
  final anonMode = true.obs;
  final emergencyContact = RxnString(); // Le fameux "Lien"

  @override
  void onInit() {
    super.onInit();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      final response = await _api.get('/users/profile');
      if (response.statusCode == 200) {
        final user = UserModel.fromJson(jsonDecode(response.body));
        userName.value = user.pseudo;
        emergencyContact.value = user.emergencyContact;
      }
    } catch (e) {
      // Ignorer silencieusement pour le dashboard
    }
  }
  
  void toggleAnonMode() {
    anonMode.value = !anonMode.value;
  }

  Future<void> triggerSOS() async {
    if (emergencyContact.value == null || emergencyContact.value!.isEmpty) {
      Get.snackbar(
        'Attention', 
        'Veuillez configurer un numéro de contact "Lien" dans vos paramètres pour utiliser le SOS.',
        snackPosition: SnackPosition.BOTTOM
      );
      return;
    }

    // WhatsApp URL format: https://wa.me/<number>
    // Clean numeric values
    final cleanPhone = emergencyContact.value!.replaceAll(RegExp(r'\D'), '');
    final url = Uri.parse('https://wa.me/$cleanPhone?text=URGENCE : J\'ai besoin d\'aide immédiatement !');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Erreur', 'Impossible de lancer WhatsApp');
    }
  }
}
