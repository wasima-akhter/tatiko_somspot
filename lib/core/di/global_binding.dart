import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/share/controller/language_controller.dart';
import 'package:som_spot/utils/common_controller/common_controller.dart';

import '../../features/auth/controller/auth_controller.dart';
import '../../features/auth/core/service/auth_service.dart';
import '../../features/core/business/binding/business_binding.dart';
import '../../features/core/category/category_binding.dart';
import '../../features/core/location/controller/business_location_controller.dart';
import '../../features/nav/controller/navigation_controller.dart';
import '../../features/other/controller/other_binding.dart';
import 'repo_service_injection.dart';

void initGlobalBinding() {
  Get.put(LanguageController(), permanent: true);
  Get.put(CommonController(), permanent: true);
  Get.put(NavigationControllerMain(), permanent: true);

  // main.dart

  // ── after AppStorage, before runApp ──
  debugPrint('🔧 [main] registering AuthController...');
  Get.put<AuthController>(AuthController(sl<AuthService>()), permanent: true);
  debugPrint('✅ [main] AuthController registered');

  CategoryBinding().dependencies();

  OtherBinding().dependencies();

  BusinessBinding().dependencies();

  Get.lazyPut(() => BusinessLocationController(), fenix: true);
}
