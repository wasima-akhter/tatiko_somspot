import 'package:get/get.dart';
import 'package:som_spot/features/home/controller/home_category_controller.dart';
import 'package:som_spot/features/home/controller/home_deals_controller.dart';
import 'package:som_spot/features/home/controller/home_nearby_controller.dart';

import '../../profile/main_profile/controller/profile_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  ProfileScreenController get profileController => ProfileScreenController.to;

  @override
  void onInit() {
    super.onInit();
    profileController.getProfile();
  }

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
      final categoryController = HomeCategoryController.to;
      final dealsController = Get.find<HomeDealsController>();
      final nearbyController = Get.find<HomeNearbyController>();

      await Future.wait([
        Future(() => profileController.getProfile()),
        Future(() => categoryController.fetchCategories()),
        Future(() => dealsController.fetchDeals(isRefresh: true)),
        Future(() => nearbyController.fetchNearbyMerchants(isRefresh: true)),
      ]);
    } catch (e) {
      // handle error if required
    } finally {
      isRefreshing.value = false;
    }
  }
}
