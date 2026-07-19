import 'package:get/get.dart';

import '../../../core/di/repo_service_injection.dart';
import '../service/other_service.dart';
import 'other_controller.dart';

class OtherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtherController(sl<OtherService>()));
  }
}
