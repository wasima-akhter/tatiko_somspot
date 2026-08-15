import 'package:get/get.dart';
import 'package:som_spot/features/customer/claims/controller/claims_controller.dart';
import 'package:som_spot/features/customer/claims/shared/service/claims_service.dart';

import '../../../../../core/di/repo_service_injection.dart';

class ClaimsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClaimsController>(() => ClaimsController(sl<ClaimsService>()));
  }
}
