import 'package:get/get.dart';
import 'package:som_spot/features/alerts/service/alerts_service.dart';
import 'package:som_spot/features/customer/claims/shared/binding/claims_binding.dart';
import 'package:som_spot/features/customer/customer_home/service/customer_home_service.dart';
import 'package:som_spot/features/customer/saved/shared/service/saved_service.dart';
import 'package:som_spot/features/influencer_all/core/influencer_tasks/service/influencer_tasks_service.dart';
import 'package:som_spot/features/influencer_all/influencer_dashboard/service/influencer_dashboard_service.dart';
import 'package:som_spot/features/merchant/stats/binding/stats_binding.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/features/profile/main_profile/controller/profile_controller.dart';

import '../../../core/di/repo_service_injection.dart';
import '../../../utils/common_controller/common_controller.dart';
import '../../../utils/enum/app_enum.dart';
import '../../alerts/controller/alerts_controller.dart';
import '../../core/category/binding/category_binding_helper.dart';
import '../../customer/customer_home/binding/home_binding.dart';
import '../../customer/customer_home/controller/home_controller.dart';
import '../../customer/saved/controller/saved_controller.dart';
import '../../customer/search/binding/search_binding.dart';
import '../../influencer_all/influencer_dashboard/controller/influencer_dashboard_controller.dart';
import '../../influencer_all/influencer_task_screen/controller/influencer_task_controller.dart';
import '../../influencer_all/influencer_wallet/controller/influencer_wallet_controller.dart';
import '../../influencer_all/influencer_wallet/service/influencer_wallet_service.dart';
import '../../merchant/dashboard_merchant/controller/dashboard_merchant_controller.dart';
import '../../merchant/dashboard_merchant/service/dashboard_merchant_service.dart';
import '../../merchant/listings/binding/merchant_listing_binding.dart';
import '../../offers/shared/binding/offers_binding.dart';
import '../../profile/service/profile_service.dart';

// import other controllers here

/*
class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    // Bottom navigation controller
    Get.lazyPut<NavigationControllerMain>(
      () => NavigationControllerMain(),
      fenix: true,
    );

    // Profile tab controller
    Get.lazyPut<ProfileScreenController>(
      () => ProfileScreenController(sl<ProfileService>()),
      fenix: true,
    );

    // Add other tab controllers here
    //

    // influencer
    Get.lazyPut<InfluencerDiscoverController>(
      () => InfluencerDiscoverController(),
      fenix: true,
    );
    Get.lazyPut<InfluencerTaskController>(
      () => InfluencerTaskController(sl<InfluencerTasksService>()),
      fenix: true,
    );
    Get.lazyPut<InfluencerWalletController>(
      () => InfluencerWalletController(sl<InfluencerWalletService>()),
      fenix: true,
    );

    //Merchant Dashboard
    Get.lazyPut<DashboardMerchantController>(
      () => DashboardMerchantController(sl<DashboardMerchantService>()),
      fenix: true,
    );

    MerchantListingBinding().dependencies();

    StatsBinding().dependencies();

    // customer
    CategoryBindings.customerBinding.dependencies();
    Get.lazyPut<HomeController>(
      () => HomeController(sl<CustromerHomeService>()),
      fenix: true,
    );

    HomeBinding().dependencies();

    SearchBinding().dependencies();

    Get.lazyPut<SavedScreenController>(
      () => SavedScreenController(sl<SavedService>()),
      fenix: true,
    );
    Get.lazyPut<AlertsScreenController>(
      () => AlertsScreenController(sl<AlertsService>()),
      fenix: true,
    );

    //
    // Offers
    OffersBinding().dependencies();
    ClaimsBinding().dependencies();

    //Influencer Dashboard
    Get.lazyPut<InfluencerDashboardController>(
      () => InfluencerDashboardController(sl<InfluencerDashboardService>()),
      fenix: true,
    );
  }
}
*/

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationControllerMain>(
      () => NavigationControllerMain(),
      fenix: true,
    );

    // Shared across all roles
    Get.lazyPut<ProfileScreenController>(
      () => ProfileScreenController(sl<ProfileService>()),
      fenix: true,
    );

    // Category
    CategoryBindings.customerBinding.dependencies();

    // Offers
    OffersBinding().dependencies();

    switch (CommonController.to.role.value) {
      case UserRole.customer:
        _bindCustomer();
        break;

      case UserRole.influencer:
        _bindInfluencer();
        break;

      case UserRole.merchandiser:
        _bindMerchant();
        break;
    }
  }

  void _bindCustomer() {
    // Home
    Get.lazyPut<HomeController>(
      () => HomeController(sl<CustromerHomeService>()),
      fenix: true,
    );

    HomeBinding().dependencies();

    // Search
    SearchBinding().dependencies();

    // Saved
    Get.lazyPut<SavedScreenController>(
      () => SavedScreenController(sl<SavedService>()),
      fenix: true,
    );

    // Alerts
    Get.lazyPut<AlertsScreenController>(
      () => AlertsScreenController(sl<AlertsService>()),
      fenix: true,
    );

    // Claims
    ClaimsBinding().dependencies();
  }

  void _bindInfluencer() {
    Get.lazyPut<InfluencerDashboardController>(
      () => InfluencerDashboardController(sl<InfluencerDashboardService>()),
      fenix: true,
    );

    Get.lazyPut<InfluencerTaskController>(
      () => InfluencerTaskController(sl<InfluencerTasksService>()),
      fenix: true,
    );

    Get.lazyPut<InfluencerWalletController>(
      () => InfluencerWalletController(sl<InfluencerWalletService>()),
      fenix: true,
    );

    // Only keep this if Discover is actually part of
    // the current influencer navigation.
    //
    // Get.lazyPut<InfluencerDiscoverController>(
    //   () => InfluencerDiscoverController(),
    //   fenix: true,
    // );
  }

  void _bindMerchant() {
    Get.lazyPut<DashboardMerchantController>(
      () => DashboardMerchantController(sl<DashboardMerchantService>()),
      fenix: true,
    );

    MerchantListingBinding().dependencies();

    StatsBinding().dependencies();

    OffersBinding().dependencies();
  }
}

/*
NavigationBinding
      |
      ├── HomeBinding
      |      ├── HomeController
      |      ├── HomeCategoryController
      |      ├── HomeDealsController
      |      └── HomeNearbyController
      |
      ├── ProfileBinding
      |
      ├── SearchBinding
      |
      └── AlertsBinding
      */
