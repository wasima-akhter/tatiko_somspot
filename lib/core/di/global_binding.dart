import 'package:get/get.dart';
import 'package:som_spot/share/language/controller/language_controller.dart';
import 'package:som_spot/share/language/service/language_service.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../features/auth/controller/auth_controller.dart';
import '../../features/auth/core/service/auth_service.dart';
import '../../features/core/business/binding/business_binding.dart';
import '../../features/core/location/controller/business_location_controller.dart';
import '../../features/core/location/current_location/current_location_controller.dart';
import '../../features/nav/controller/navigation_controller.dart';
import '../../features/other/controller/other_binding.dart';
import 'repo_service_injection.dart';

void initGlobalBinding() {
  Get.put(LanguageController(sl<LanguageService>()), permanent: true);
  Get.put(CommonController(), permanent: true);
  Get.put(NavigationControllerMain(), permanent: true);

  // main.dart

  // ── after AppStorage, before runApp ──
  print('🔧 [main] registering AuthController...');
  Get.put<AuthController>(AuthController(sl<AuthService>()), permanent: true);
  print('✅ [main] AuthController registered');

  OtherBinding().dependencies();

  BusinessBinding().dependencies();

  Get.lazyPut(() => BusinessLocationController(), fenix: true);

  Get.put<LocationController>(LocationController(), permanent: true);
}
