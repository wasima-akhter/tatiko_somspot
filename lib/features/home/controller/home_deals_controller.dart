import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/home/model/deal_model.dart';

class HomeDealsController extends GetxController {
  static HomeDealsController get to => Get.find();

  //
  final RxList<DealModel> bestDeals = <DealModel>[].obs;
  final RxList<DealModel> topDeals = <DealModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDeals();
  }

  /// Fetches best deals and top deals with simulated API delay
  Future<void> fetchDeals({bool isRefresh = false}) async {
    if (!isRefresh) {
      isLoading.value = true;
    }

    try {
      // Mock network latency for stunning shimmer loading experience
      await Future.delayed(const Duration(milliseconds: 1800));

      // Today's Best Deals
      final List<DealModel> loadedBestDeals = [
        DealModel(
          id: 'best_1',
          imageUrl:
              "https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=600&auto=format&fit=crop",
          title: "Today's Best Deal",
          merchantName: "Pizza Special",
          discount: "50%",
          timeLeft: "1 day",
          videoUrl: "https://www.w3schools.com/html/mov_bbb.mp4",
        ),
      ];

      // Top Deals
      final List<DealModel> loadedTopDeals = [
        DealModel(
          id: 'top_1',
          imageUrl:
              "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=400&auto=format&fit=crop",
          merchantName: "Hilib Macaan Restaurant",
          title: "20% Off Family Platter",
          discount: "20%",
          timeLeft: "2 days",
          isTopDeal: true,
        ),
        DealModel(
          id: 'top_2',
          imageUrl:
              "https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=400&auto=format&fit=crop",
          merchantName: "Banadir Steakhouse",
          title: "Buy 1 Get 1 Free Ribeye",
          discount: "BOGO",
          timeLeft: "3 days",
          isTopDeal: true,
        ),
      ];

      bestDeals.assignAll(loadedBestDeals);
      topDeals.assignAll(loadedTopDeals);
    } catch (e) {
      debugPrint("Error fetching deals: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
