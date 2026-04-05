import 'package:get/get.dart';
import 'package:mobile/modules/submissions/controllers/submission_controller.dart';

class SubmissionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmissionController>(() => SubmissionController());
  }
}
