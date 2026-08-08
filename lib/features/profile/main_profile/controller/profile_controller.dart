import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/auth/controller/auth_controller.dart';
import 'package:som_spot/features/profile/models/get_profile_model.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../helper/image/image_helper.dart';
import '../../../../helper/location_converter/location-converter.dart';
import '../../../../utils/common_controller/common_controller.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../service/profile_service.dart';
import '../widgets/profile_statistics_section.dart';

class ProfileScreenController extends GetxController {
  final ProfileService _service;

  ProfileScreenController(this._service);
  static ProfileScreenController get to => Get.find();

  /// ============================= GET Profile =====================================
  final Rx<ApiStatus> profileLoading = ApiStatus.completed.obs;
  void profileLoadingMethod(ApiStatus status) => profileLoading.value = status;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  // User Profile details
  final userName = "".obs;
  final userEmail = "".obs;
  final userPhone = "".obs;
  final userAvatar = "".obs;
  final userLocationCords = LocationCoordinates(
    type: "Point",
    coordinates: [0.0, 0.0],
  ).obs;
  final userLocationString = "".obs;

  // Statistics
  final savedCount = 12.obs;
  final claimsCount = 8.obs;
  final reviewsCount = 5.obs;

  Future<void> setProfileData(GetProfileModel data) async {
    print("PROFILE CONTROLLER: $hashCode");
    userName.value = data.name;
    userEmail.value = data.email;
    userPhone.value = data.phone ?? "";
    userAvatar.value = data.profileImage != null
        ? AppImageHelper.profile(data.profileImage!)
        : "";

    userLocationCords.value = data.locationCoordinates!;
    final coordinates = data.locationCoordinates;
    if (coordinates != null && coordinates.coordinates.length == 2) {
      userLocationString.value = await LocationHelper.getAddressFromCoordinates(
        latitude: coordinates.coordinates[0],
        longitude: coordinates.coordinates[1],
      );
    } else {
      userLocationString.value = LocationHelper.fallbackAddress;
    }

    update();
  }

  void logout() {
    AuthController.to.logout();
    AppToast.success(message: AppStrings.successfullyLoggedOut.tr);
    AppRouter.route.goNamed(RoutePath.loginScreen);
  }

  List<ProfileStatModel> get profileStats {
    if (CommonController.to.isInfluencer) {
      return [
        ProfileStatModel(title: AppStrings.followers.tr, value: "50K"),
        ProfileStatModel(title: AppStrings.engagement.tr, value: "4.2%"),
        ProfileStatModel(title: AppStrings.campaigns.tr, value: "12"),
      ];
    }
    if (CommonController.to.isCustomer) {
      return [
        ProfileStatModel(title: AppStrings.saved.tr, value: "25"),
        ProfileStatModel(title: AppStrings.claims.tr, value: "18"),
        ProfileStatModel(title: AppStrings.reviews.tr, value: "12"),
      ];
    }
    return []; // merchandiser / fallback
  }

  final Rx<String?> errorMessage = Rx<String?>(null);

  Future<void> getProfile() async {
    profileLoadingMethod(ApiStatus.loading);
    errorMessage.value = null;
    try {
      final result = await _service.getProfile();
      if (!result.success) {
        errorMessage.value = result.message;
        profileLoadingMethod(ApiStatus.error);
        return;
      }
      final profile = result.data;
      if (profile == null) {
        profileLoadingMethod(ApiStatus.noDataFound);
        return;
      }
      await setProfileData(profile);
      profileLoadingMethod(ApiStatus.completed);
    } catch (_) {
      errorMessage.value = AppStrings.somethingWentWrong.tr;
      profileLoadingMethod(ApiStatus.error);
    }
  }

  //
}
