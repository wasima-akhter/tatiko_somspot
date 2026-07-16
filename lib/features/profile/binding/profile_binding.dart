import 'package:get/get.dart';

import '../../../core/di/repo_service_injection.dart';
import '../edit_profile/controller/edit_profile_controller.dart';
import '../service/profile_service.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {


    Get.lazyPut<EditProfileController>(
      () => EditProfileController(sl<ProfileService>()),
    );
  }
}
