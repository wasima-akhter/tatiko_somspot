import 'package:get/get.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/features/profile/main_profile/controller/profile_controller.dart';

import '../../../core/di/repo_service_injection.dart';
import '../../alerts/controller/alerts_controller.dart';
import '../../dashboard/dashboard_merchant/controller/dashboard_merchant_controller.dart';
import '../../dashboard/dashboard_merchant/service/dashboard_merchant_service.dart';
import '../../home/binding/home_binding.dart';
import '../../home/controller/home_controller.dart';
import '../../influencer_all/influencer_discover/controller/influencer_discover_controller.dart';
import '../../influencer_all/influencer_task_screen/controller/influencer_task_controller.dart';
import '../../influencer_all/influencer_wallet/controller/influencer_wallet_controller.dart';
import '../../offers/binding/offers_binding.dart';
import '../../profile/service/profile_service.dart';
import '../../saved/controller/saved_controller.dart';
import '../../search/controller/search_controller.dart';

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
      () => InfluencerTaskController(),
      fenix: true,
    );
    Get.lazyPut<InfluencerWalletController>(
      () => InfluencerWalletController(),
      fenix: true,
    );

    //Merchant Dashboard
    Get.lazyPut<DashboardMerchantController>(
      () => DashboardMerchantController(sl<DashboardMerchantService>()),
      fenix: true,
    );
    // customer

    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);

    HomeBinding().dependencies();

    Get.lazyPut<SearchScreenController>(
      () => SearchScreenController(),
      fenix: true,
    );
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
