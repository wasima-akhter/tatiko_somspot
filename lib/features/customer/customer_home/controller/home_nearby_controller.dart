import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/customer/customer_home/model/merchant_model.dart';

class HomeNearbyController extends GetxController {
  static HomeNearbyController get to => Get.find();

  final RxList<MerchantModel> merchants = <MerchantModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNearbyMerchants();
  }

  /// Fetches nearby merchants with simulated API delay
  Future<void> fetchNearbyMerchants({bool isRefresh = false}) async {
    if (!isRefresh) {
      isLoading.value = true;
    }

    try {
      // Mock network latency for stunning shimmer loading experience
      await Future.delayed(const Duration(milliseconds: 2000));

      final List<MerchantModel> loadedMerchants = [
        MerchantModel(
          id: 'nearby_1',
          imageUrl:
              "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=600&auto=format&fit=crop",
          title: "Hilib Macaan Restaurant",
          category: "Restaurant",
          distance: "1.2 km",
          isOpen: true,
          rating: "4.8",
        ),
        MerchantModel(
          id: 'nearby_2',
          imageUrl:
              "https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=600&auto=format&fit=crop",
          title: "Suuqa Bakaaraha Grocery",
          category: "Grocery",
          distance: "1.2 km",
          isOpen: true,
          rating: "4.8",
        ),
        MerchantModel(
          id: 'nearby_3',
          imageUrl:
              "https://images.unsplash.com/photo-1586015555751-63bb77f4322a?q=80&w=600&auto=format&fit=crop",
          title: "Banadir Pharmacy",
          category: "Pharmacy",
          distance: "1.2 km",
          isOpen: false,
          rating: "4.8",
        ),
      ];

      merchants.assignAll(loadedMerchants);
    } catch (e) {
      debugPrint("Error fetching merchants: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
