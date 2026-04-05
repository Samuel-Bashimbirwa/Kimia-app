import 'package:get/get.dart';
import 'package:mobile/modules/community/controllers/community_controller.dart';

class CommunityBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityController>(() => CommunityController());
  }
}
