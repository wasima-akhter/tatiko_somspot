import 'package:get/get.dart';
import 'package:som_spot/share/controller/language_controller.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../features/nav/controller/navigation_controller.dart';

// void initGetx() {
//   // Global & Common Controllers
//   Get.lazyPut(() => LanguageController(), fenix: true);
//   Get.lazyPut(() => AuthController(), fenix: true);
//   Get.lazyPut(() => OnboardingController(), fenix: true);
//   Get.lazyPut(() => CommonController(), fenix: true);

//   Get.put(NavigationControllerMain(), permanent: true);

//   // Home Feature Controllers
//   Get.lazyPut(() => HomeController(), fenix: true);
//   Get.lazyPut(() => HomeCategoryController(), fenix: true);
//   Get.lazyPut(() => HomeDealsController(), fenix: true);
//   Get.lazyPut(() => HomeNearbyController(), fenix: true);

//   // Other Bottom Nav Controllers
//   Get.lazyPut(() => SearchScreenController(), fenix: true);
//   Get.lazyPut(() => SavedScreenController(), fenix: true);
//   Get.lazyPut(() => AlertsScreenController(), fenix: true);
//   Get.lazyPut(() => ProfileScreenController(), fenix: true);
//   Get.lazyPut(() => ProfileScreenController(), fenix: true);

//   // influencer
//   Get.lazyPut(() => ChooseRoleController(), fenix: true);
//   Get.lazyPut(() => InfluencerDiscoverController(), fenix: true);
//   Get.lazyPut(() => InfluencerTaskController(), fenix: true);
//   Get.lazyPut(() => InfluencerWalletController(), fenix: true);
//   Get.lazyPut(() => InfluencerMyCampaignsController(), fenix: true);
//   Get.lazyPut(() => OtherController(), fenix: true);
// }

void initGetx() {
  Get.put(LanguageController(), permanent: true);
  Get.put(CommonController(), permanent: true);
  Get.put(NavigationControllerMain(), permanent: true);
}
