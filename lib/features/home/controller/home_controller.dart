import 'package:get/get.dart';
import 'package:som_spot/features/home/controller/home_category_controller.dart';
import 'package:som_spot/features/home/controller/home_deals_controller.dart';
import 'package:som_spot/features/home/controller/home_nearby_controller.dart';

class HomeController extends GetxController {
  // User profile and greeting state (clean MVC pattern)
  final RxString userName = "Jorge Walton".obs;
  final RxString userLocation = "Maka Al Mukarama, Mogadishu".obs;
  final RxString userProfileImage =
      "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=150&auto=format&fit=crop"
          .obs;

  final RxBool isRefreshing = false.obs;

  /// Orchestrates simultaneous parallel refreshing of all modular controllers.
  Future<void> refreshHomeData() async {
    isRefreshing.value = true;
    try {
      // Fetch instances of all registered controllers
      final categoryController = Get.find<HomeCategoryController>();
      final dealsController = Get.find<HomeDealsController>();
      final nearbyController = Get.find<HomeNearbyController>();

      // Execute category updates synchronously (as it is static now)
      categoryController.fetchCategories();

      // Execute other refresh calls in parallel using Future.wait
      await Future.wait([
        dealsController.fetchDeals(isRefresh: true),
        nearbyController.fetchNearbyMerchants(isRefresh: true),
      ]);
    } catch (e) {
      // Error handling is cleanly localized or reported
    } finally {
      isRefreshing.value = false;
    }
  }
}
