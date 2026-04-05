import 'package:get/get.dart';
import 'package:mobile/modules/cabinet/controllers/cabinet_controller.dart';

class CabinetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CabinetController>(() => CabinetController());
  }
}
