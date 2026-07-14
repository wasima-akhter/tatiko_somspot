import 'package:get/get.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/features/profile/main_profile/controller/profile_controller.dart';

import '../../../core/di/injection.dart';
import '../../alerts/controller/alerts_controller.dart';
import '../../home/controller/home_controller.dart';
import '../../influencer_all/influencer_discover/controller/influencer_discover_controller.dart';
import '../../influencer_all/influencer_task_screen/controller/influencer_task_controller.dart';
import '../../influencer_all/influencer_wallet/controller/influencer_wallet_controller.dart';
import '../../offers/controller/offer_controller.dart';
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

    // Get.lazyPut<ListingController>(() => ListingController(), fenix: true);
    Get.lazyPut<OfferController>(() => OfferController(), fenix: true);
    // Get.lazyPut<StatsController>(() => StatsController(), fenix: true);

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

    // customer
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);

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
  }
}
