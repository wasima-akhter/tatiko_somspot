import 'package:get/get.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../controller/business-controller.dart';
import '../service/business-service.dart';

class BusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BusinessController(sl<BusinessService>()), fenix: true);
  }
}
