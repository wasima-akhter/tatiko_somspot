import 'package:get/get.dart';
import 'package:som_spot/features/alerts/controller/alerts_controller.dart';
import 'package:som_spot/features/auth/controller/auth_controller.dart';
import 'package:som_spot/features/home/controller/home_category_controller.dart';
// Home Feature Controllers
import 'package:som_spot/features/home/controller/home_controller.dart';
import 'package:som_spot/features/home/controller/home_deals_controller.dart';
import 'package:som_spot/features/home/controller/home_nearby_controller.dart';
import 'package:som_spot/features/onboarding/controller/onboarding_controller.dart';
import 'package:som_spot/features/profile/main_profile/controller/profile_controller.dart';
import 'package:som_spot/features/saved/controller/saved_controller.dart';
// Other Bottom Nav Feature Controllers
import 'package:som_spot/features/search/controller/search_controller.dart';
import 'package:som_spot/share/controller/language_controller.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../features/choose_role/controller/choose_role_controller.dart';
import '../../features/influencer_all/influencer_discover/controller/influencer_discover_controller.dart';

void initGetx() {
  // Global & Common Controllers
  Get.lazyPut(() => LanguageController(), fenix: true);
  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => OnboardingController(), fenix: true);
  Get.lazyPut(() => CommonController(), fenix: true);

  // Home Feature Controllers
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => HomeCategoryController(), fenix: true);
  Get.lazyPut(() => HomeDealsController(), fenix: true);
  Get.lazyPut(() => HomeNearbyController(), fenix: true);

  // Other Bottom Nav Controllers
  Get.lazyPut(() => SearchScreenController(), fenix: true);
  Get.lazyPut(() => SavedScreenController(), fenix: true);
  Get.lazyPut(() => AlertsScreenController(), fenix: true);
  Get.lazyPut(() => ProfileScreenController(), fenix: true);
  Get.lazyPut(() => ProfileScreenController(), fenix: true);

  // influencer
  Get.lazyPut(() => ChooseRoleController(), fenix: true);
  Get.lazyPut(() => InfluencerDiscoverController(), fenix: true);
}
