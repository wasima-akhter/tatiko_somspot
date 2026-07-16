import 'package:get/get.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../controller/complete_business_profile_controller.dart';
import '../service/complete_business_profile_service.dart';

class CompleteBusinessProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteBusinessProfileController>(
      () => CompleteBusinessProfileController(
        sl<CompleteBusinessProfileService>(),
      ),
    );
  }
}
