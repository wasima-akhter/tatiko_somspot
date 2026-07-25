import 'package:get/get.dart';

import '../../../../utils/enum/app_enum.dart';
import '../../../profile/main_profile/controller/profile_controller.dart';
import '../response/dashboard_merchant_response.dart';
import '../service/dashboard_merchant_service.dart';

class DashboardMerchantController extends GetxController {
  final DashboardMerchantService _service;

  DashboardMerchantController(this._service);

  static DashboardMerchantController get to => Get.find();

  ProfileScreenController get profileController => ProfileScreenController.to;

  RxString get userName => profileController.userName;
  RxString get userProfileImage => profileController.userAvatar;
  RxString get userAddress => profileController.userLocationString;

  String get displayName {
    return userName.value.isEmpty ? "User" : userName.value;
  }

  String get displayAvatar {
    return userProfileImage.value;
  }

  final RxBool isRefreshing = false.obs;

  Future<void> refreshHomeData() async {
    isRefreshing.value = true;

    try {
      await getDashboardOverview();
      await profileController.getProfile();
      // final categoryController = HomeCategoryController.to;
      // final dealsController = Get.find<HomeDealsController>();
      // final nearbyController = Get.find<HomeNearbyController>();

      // await Future.wait([
      //   Future(() => profileController.getProfile()),
      //   Future(() => categoryController.fetchCategories()),
      //   Future(() => dealsController.fetchDeals(isRefresh: true)),
      //   Future(() => nearbyController.fetchNearbyMerchants(isRefresh: true)),
      // ]);
    } catch (e) {
      // handle error if required
    } finally {
      isRefreshing.value = false;
    }
  }

  ////

  // Dashboard API Status

  final Rx<ApiStatus> dashboardStatus = ApiStatus.completed.obs;

  final Rx<String?> errorMessage = Rx<String?>(null);

  MerchantDashboardModel? dashboardData;

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
      final result = await _service.getMerchantDashboard();

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

  //
}
