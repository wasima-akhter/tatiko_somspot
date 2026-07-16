import 'package:get/get.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../controller/completed_profile_customer_controller.dart';
import '../service/complete_profile_service.dart';

class CompleteProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedProfileCustomerController>(
      () => CompletedProfileCustomerController(sl<CompleteProfileService>()),
      fenix: true,
    );
  }
}
