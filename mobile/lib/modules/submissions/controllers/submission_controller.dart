import 'dart:convert';
import 'package:get/get.dart';
import 'package:mobile/core/services/api_service.dart';
import 'package:mobile/data/models/forms/violence_forms.dart';

class SubmissionController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final isLoading = false.obs;

  Future<void> submitViolenceReport(ViolenceForm form) async {
    isLoading.value = true;
    try {
      final String contentStr = jsonEncode(form.toJson());

      // Prepare payload for FastAPI model: SubmissionCreate
      // { "submission_type": "text", "content": "{...}", "tags": [] }
      final payload = {
        "submission_type": "questionnaire",
        "content": contentStr,
        "tags": [form.toJson()['context']]
      };

      final response = await _api.post('/submissions/', payload);

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Submission saved successfully', snackPosition: SnackPosition.BOTTOM);
        Get.back(); // Go back to Home
      } else {
        Get.snackbar('Error', 'Failed to submit data', snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error occurred', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
