import 'package:get/get.dart';
import 'package:som_spot/features/customer/customer_home/service/home_content_service.dart';
import 'package:som_spot/features/influencer_all/core/influencer_tasks/service/influencer_tasks_service.dart';
import 'package:som_spot/features/influencer_all/influencer_dashboard/service/influencer_dashboard_service.dart';
import 'package:som_spot/features/merchant/stats/binding/stats_binding.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/features/profile/main_profile/controller/profile_controller.dart';

import '../../../core/di/repo_service_injection.dart';
import '../../alerts/controller/alerts_controller.dart';
import '../../customer/customer_home/binding/home_binding.dart';
import '../../customer/customer_home/controller/home_controller.dart';
import '../../customer/saved/controller/saved_controller.dart';
import '../../customer/search/binding/search_binding.dart';
import '../../influencer_all/influencer_dashboard/controller/influencer_dashboard_controller.dart';
import '../../influencer_all/influencer_discover/controller/influencer_discover_controller.dart';
import '../../influencer_all/influencer_task_screen/controller/influencer_task_controller.dart';
import '../../influencer_all/influencer_wallet/controller/influencer_wallet_controller.dart';
import '../../influencer_all/influencer_wallet/service/influencer_wallet_service.dart';
import '../../merchant/dashboard_merchant/controller/dashboard_merchant_controller.dart';
import '../../merchant/dashboard_merchant/service/dashboard_merchant_service.dart';
import '../../merchant/listings/binding/merchant_listing_binding.dart';
import '../../offers/shared/binding/offers_binding.dart';
import '../../profile/service/profile_service.dart';

// import other controllers here

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

    //Influencer Dashboard
    Get.lazyPut<InfluencerDashboardController>(
      () => InfluencerDashboardController(sl<InfluencerDashboardService>()),
      fenix: true,
    );
    // customer

    Get.lazyPut<HomeController>(
      () => HomeController(sl<HomeContentService>()),
      fenix: true,
    );

    HomeBinding().dependencies();

    SearchBinding().dependencies();

    Get.lazyPut<SavedScreenController>(
      () => SavedScreenController(),
      fenix: true,
    );
    Get.lazyPut<AlertsScreenController>(
      () => AlertsScreenController(),
      fenix: true,
    );

    //
    // Offers
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
