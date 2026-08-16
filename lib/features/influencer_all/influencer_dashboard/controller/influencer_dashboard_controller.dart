import 'package:get/get.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../utils/enum/app_enum.dart';
import '../../../profile/main_profile/controller/profile_controller.dart';
import '../response/influencer_dashboard_response.dart';
import '../service/influencer_dashboard_service.dart';

class InfluencerDashboardController extends GetxController {
  final InfluencerDashboardService _service;

  InfluencerDashboardController(this._service);

  static InfluencerDashboardController get to => Get.find();

  ProfileScreenController get profileController => ProfileScreenController.to;

  RxString get userName => profileController.userName;
  RxString get userProfileImage => profileController.userAvatar;
  RxString get userAddress => profileController.userLocationString;

  String get displayName =>
      userName.value.isEmpty ? AppStrings.user.tr : userName.value;

  String get displayAvatar => userProfileImage.value;

  final RxBool isRefreshing = false.obs;

  Future<void> refreshHomeData() async {
    isRefreshing.value = true;

    try {
      await getDashboardOverview();
      await profileController.getProfile();
    } finally {
      isRefreshing.value = false;
    }
  }

  // ============================
  // Dashboard
  // ============================

  final Rx<ApiStatus> dashboardStatus = ApiStatus.completed.obs;

  final Rx<String?> errorMessage = Rx<String?>(null);

  InfluencerDashboardModel? dashboardData;

  @override
  void onInit() {
    super.onInit();

    profileController.getProfile();
    getDashboardOverview();
  }

  void dashboardStatusMethod(ApiStatus status) {
    dashboardStatus.value = status;
  }

  Future<void> getDashboardOverview() async {
    dashboardStatusMethod(ApiStatus.loading);

    errorMessage.value = null;

    try {
      final result = await _service.getInfluencerDashboard();

      if (!result.success) {
        errorMessage.value = result.message;

        dashboardStatusMethod(ApiStatus.error);

        return;
      }

      if (result.data == null) {
        dashboardStatusMethod(ApiStatus.noDataFound);

        return;
      }

      dashboardData = result.data;

      dashboardStatusMethod(ApiStatus.completed);
    } catch (e) {
      errorMessage.value = "Something went wrong.";

      dashboardStatusMethod(ApiStatus.error);
    }
  }

  // ============================
  // Convenience Getters
  // ============================

  List<InfluencerActiveTaskModel> get activeTasks =>
      dashboardData?.activeTasks ?? [];

  int get unreadNotifications => dashboardData?.unreadNotifications ?? 0;

  double get totalEarnings => dashboardData?.totalEarnings ?? 0;

  double get pendingPayout => dashboardData?.pendingPayout ?? 0;

  int get claims => dashboardData?.claims ?? 0;
}
