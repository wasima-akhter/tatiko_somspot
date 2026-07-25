import 'package:get/get.dart';

class SavedBusinessModel {
  final String name;
  final String category;
  final String distance;
  final bool isOpen;
  final double rating;
  final String imageUrl;

  SavedBusinessModel({
    required this.name,
    required this.category,
    required this.distance,
    required this.isOpen,
    required this.rating,
    required this.imageUrl,
  });
}

class SavedOfferModel {
  final String title;
  final String businessName;
  final String tag;
  final String timeLeft;
  final RxBool isClaimed;
  final String imageUrl;

  SavedOfferModel({
    required this.title,
    required this.businessName,
    required this.tag,
    required this.timeLeft,
    required bool isClaimed,
    required this.imageUrl,
  }) : isClaimed = isClaimed.obs;
}

class SavedScreenController extends GetxController {
  // Selected tab index: 0 = Businesses, 1 = Offers
  final rxSelectedTab = 0.obs;

  // Loading state
  final rxIsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate loading for 1.5 seconds to showcase shimmer
    rxIsLoading.value = true;
    Future.delayed(const Duration(milliseconds: 1500), () {
      rxIsLoading.value = false;
    });
  }

  // Saved Businesses List
  final rxSavedBusinesses = <SavedBusinessModel>[
    SavedBusinessModel(
      name: "Hilib Macaan Restaurant",
      category: "Restaurant",
      distance: "1.2 km",
      isOpen: true,
      rating: 4.8,
      imageUrl: "https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=300&auto=format&fit=crop",
    ),
    SavedBusinessModel(
      name: "Suuqa Bakaaraha Grocery",
      category: "Grocery",
      distance: "1.2 km",
      isOpen: true,
      rating: 4.8,
      imageUrl: "https://images.unsplash.com/photo-1578916171728-46686eac8d58?q=80&w=300&auto=format&fit=crop",
    ),
    SavedBusinessModel(
      name: "Banadir Pharmacy",
      category: "Pharmacy",
      distance: "1.2 km",
      isOpen: false,
      rating: 4.8,
      imageUrl: "https://images.unsplash.com/photo-1586015555751-63bb77f4322a?q=80&w=300&auto=format&fit=crop",
    ),
  ].obs;

  // Saved Offers List
  final rxSavedOffers = <SavedOfferModel>[
    SavedOfferModel(
      title: "20% Off Family Platter",
      businessName: "Hilib Macaan Restaurant",
      tag: "20%",
      timeLeft: "2 days",
      isClaimed: false,
      imageUrl: "https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=200&auto=format&fit=crop",
    ),
    SavedOfferModel(
      title: "Buy 1 Get 1 Free - Fresh Juices",
      businessName: "Hayat Supermarket",
      tag: "BOGO",
      timeLeft: "5 hours",
      isClaimed: true,
      imageUrl: "https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?q=80&w=200&auto=format&fit=crop",
    ),
    SavedOfferModel(
      title: "20% Off Family Platter",
      businessName: "Hilib Macaan Restaurant",
      tag: "\$5 Deal",
      timeLeft: "1 week",
      isClaimed: false,
      imageUrl: "https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=200&auto=format&fit=crop",
    ),
    SavedOfferModel(
      title: "Buy 1 Get 1 Free - Fresh Juices",
      businessName: "Hayat Supermarket",
      tag: "BOGO",
      timeLeft: "5 hours",
      isClaimed: true,
      imageUrl: "https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?q=80&w=200&auto=format&fit=crop",
    ),
  ].obs;

  void selectTab(int index) {
    rxSelectedTab.value = index;
  }

  void toggleClaim(int index) {
    rxSavedOffers[index].isClaimed.toggle();
  }
}
