import 'package:get/get.dart';
import 'package:som_spot/features/profile/service/influencer_profile_service.dart';

import '../../../core/di/repo_service_injection.dart';
import '../edit_profile/controller/edit_influencer_controller.dart';
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

// make binding for edit influencer + merchant

class EditInfluencerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditInfluencerController>(
      () => EditInfluencerController(sl<InfluencerProfileService>()),
    );
  }
}
