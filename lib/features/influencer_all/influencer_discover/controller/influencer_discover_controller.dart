import 'package:get/get.dart';

class InfluencerDiscoverController extends GetxController {
  final RxBool isLoading = true.obs;

  final RxInt selectedTab = 0.obs;

  final List<String> categories = ["All", "Restaurant", "Grocery", "Pharmacy"];

  final List<Map<String, dynamic>> campaigns = [
    {
      "image": "https://images.unsplash.com/photo-1555939594-58d7cb561ad1",
      "merchant": "Hilib Macaan Restaurant",
      "title": "Create food review content",
      "campaign": "Offer Campaign",
      "reward": "\$5 / Claim",
      "days": "14 Days Left",
    },
    {
      "image": "https://images.unsplash.com/photo-1542838132-92c53300491e",
      "merchant": "Weekend Grocery Haul",
      "title": "Promote weekly groceries",
      "campaign": "Awareness Campaign",
      "reward": "\$50 Fixed",
      "days": "5 Days Left",
    },
    {
      "image": "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae",
      "merchant": "Skincare Essentials",
      "title": "Create pharmacy product content",
      "campaign": "Traffic Campaign",
      "reward": "\$5 / Click",
      "days": "30 Days Left",
    },
  ];

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(milliseconds: 1500), () {
      isLoading.value = false;
    });
  }
}
