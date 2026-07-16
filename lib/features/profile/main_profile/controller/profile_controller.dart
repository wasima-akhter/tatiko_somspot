import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/auth/controller/auth_controller.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';

import '../../../../helper/image/image_helper.dart';
import '../../../../utils/common_controller/common_controller.dart';
import '../../models/profile_response.dart';
import '../../service/profile_service.dart';
import '../widgets/profile_statistics_section.dart';

class ProfileScreenController extends GetxController {
  final ProfileService _service;

  ProfileScreenController(this._service);
  static ProfileScreenController get to => Get.find();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    getProfile();
  }

  void setProfileData(ProfileModel data) {
    userName.value = data.name ?? '';
    userEmail.value = data.email ?? '';
    userAvatar.value = data.profileImage ?? '';
  }

  // User Profile details
  final userName = "".obs;
  final userEmail = "".obs;
  final userPhone = "".obs;
  final userAvatar = "".obs;
  // Statistics
  final savedCount = 12.obs;
  final claimsCount = 8.obs;
  final reviewsCount = 5.obs;

  void logout() {
    AuthController.to.logout();
    AppToast.success(message: "You have successfully logged out.");
    AppRouter.route.goNamed(RoutePath.loginScreen);
  }

  List<ProfileStatModel> get profileStats {
    if (CommonController.to.isInfluencer) {
      return [
        ProfileStatModel(title: "Followers", value: "50K"),

        ProfileStatModel(title: "Engagement", value: "4.2%"),

        ProfileStatModel(title: "Campaigns", value: "12"),
      ];
    }

    if (CommonController.to.isCustomer) {
      return [
        ProfileStatModel(title: "Saved", value: "25"),

        ProfileStatModel(title: "Claims", value: "18"),

        ProfileStatModel(title: "Reviews", value: "12"),
      ];
    }

    if (CommonController.to.isMerchandiser) {
      return [];
    }

    return [];
  }

  Future<void> getProfile() async {
    print("PROFILE CONTROLLER: $hashCode");
    try {
      isLoading.value = true;

      final result = await _service.getProfile();

      if (!result.success || result.data == null) {
        AppToast.error(message: result.message);

        return;
      }

      final profile = result.data!;

      userName.value = profile.name;

      userEmail.value = profile.email;

      userPhone.value = profile.phone ?? "";

      if (profile.profileImage != null) {
        userAvatar.value = AppImageHelper.profile(profile.profileImage!);
      }

      print("UPDATED PROFILE:");

      print("result.data: profile: ${result.data!.email}");
      print(userName.value);
      print(userEmail.value);
      print(userAvatar.value);

      update();
    } finally {
      isLoading.value = false;
    }
  }
}
