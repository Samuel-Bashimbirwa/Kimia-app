import 'dart:convert';
import 'package:get/get.dart';
import 'package:mobile/core/services/api_service.dart';
import 'package:mobile/data/models/lawyer_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CabinetController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final lawyers = <LawyerModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLawyers();
  }

  Future<void> fetchLawyers() async {
    isLoading.value = true;
    try {
      final response = await _api.get('/cabinet');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        lawyers.assignAll(data.map((l) => LawyerModel.fromJson(l)).toList());
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger la liste des cabinets');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> contactLawyer(String phone) async {
    final url = Uri.parse('tel:$phone');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar('Erreur', 'Impossible de lancer l\'appel');
    }
  }

  Future<void> emailLawyer(String email) async {
    final url = Uri.parse('mailto:$email');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar('Erreur', 'Impossible de lancer l\'email');
    }
  }
}
