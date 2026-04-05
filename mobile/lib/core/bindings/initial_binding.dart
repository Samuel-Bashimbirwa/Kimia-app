import 'package:get/get.dart';
import 'package:mobile/core/services/api_service.dart';
import 'package:mobile/core/services/storage_service.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<ApiService>(ApiService(), permanent: true);
  }
}
