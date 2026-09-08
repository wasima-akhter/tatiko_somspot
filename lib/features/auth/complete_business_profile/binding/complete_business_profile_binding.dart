import 'package:get/get.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../../../core/category/binding/category_binding.dart';
import '../../../core/category/repository/category_repository.dart';
import '../controller/complete_business_profile_controller.dart';
import '../service/complete_business_profile_service.dart';

class CompleteBusinessProfileBinding extends Bindings {
  @override
  void dependencies() {
    CategoryBinding(
      categoryUsage: CategoryUsage.businessProfile,
      tag: 'businessProfileCategory',
    ).dependencies();

    Get.lazyPut<CompleteBusinessProfileController>(
      () => CompleteBusinessProfileController(
        sl<CompleteBusinessProfileService>(),
      ),
    );
  }
}
