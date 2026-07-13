import 'package:get/get.dart';

import '../controller/home_category_controller.dart';
import '../controller/home_controller.dart';
import '../controller/home_deals_controller.dart';
import '../controller/home_nearby_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<HomeCategoryController>(() => HomeCategoryController());

    Get.lazyPut<HomeDealsController>(() => HomeDealsController());

    Get.lazyPut<HomeNearbyController>(() => HomeNearbyController());
  }
}
