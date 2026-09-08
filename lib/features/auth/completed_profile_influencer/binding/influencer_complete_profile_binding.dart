import 'package:get/get.dart';
import 'package:som_spot/features/auth/completed_profile_influencer/service/influencer_complete_profile_service.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../../../core/category/binding/category_binding.dart';
import '../../../core/category/repository/category_repository.dart';
import '../controller/completed_profile_influencer_controller.dart';

class InfluencerCompleteProfileBinding extends Bindings {
  @override
  void dependencies() {
    CategoryBinding(
      categoryUsage: CategoryUsage.none,
      tag: 'influencerCategory',
    ).dependencies();
    Get.lazyPut<CompletedProfileInfluencerController>(
      () => CompletedProfileInfluencerController(
        sl<InfluencerCompleteProfileService>(),
      ),
      fenix: true,
    );
  }
}
