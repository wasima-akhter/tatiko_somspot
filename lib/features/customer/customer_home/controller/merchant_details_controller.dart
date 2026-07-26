import 'package:get/get.dart';
import 'package:som_spot/features/customer/customer_home/model/deal_model.dart';
import 'package:som_spot/features/customer/customer_home/model/review_model.dart';

class MerchantDetailsController extends GetxController {
  final RxInt activeTabIndex = 0.obs;
  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;
  final RxList<DealModel> merchantOffers = <DealModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMockReviews();
    _loadMockOffers();
  }

  void _loadMockReviews() {
    reviews.assignAll([
      ReviewModel(
        id: 'rev_1',
        userName: 'Mohamed Ali',
        userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=150&auto=format&fit=crop',
        rating: 5.0,
        dateAgo: '2 days ago',
        content: 'The hilib suqaar here is incredible! Best Somali food in Mogadishu. The service is fast and the staff are very friendly.',
        helpfulCount: 12,
        isHelpful: false,
      ),
      ReviewModel(
        id: 'rev_2',
        userName: 'Fatima Hassan',
        userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150&auto=format&fit=crop',
        rating: 4.0,
        dateAgo: '2 days ago',
        content: 'The service is excellent and the place is extremely neat. The camel meat platter was cooked to absolute perfection. High recommended!',
        helpfulCount: 5,
        isHelpful: false,
      ),
      ReviewModel(
        id: 'rev_3',
        userName: 'Yusup Ahmed',
        userAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=150&auto=format&fit=crop',
        rating: 4.0,
        dateAgo: '3 days ago',
        content: 'Authentic Somali cuisine. Very tasty and rich in flavors. Portions are generous.',
        helpfulCount: 2,
        isHelpful: false,
      ),
    ]);
  }

  void _loadMockOffers() {
    merchantOffers.assignAll([
      DealModel(
        id: 'deal_m1',
        imageUrl: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=600&auto=format&fit=crop',
        title: '20% Off Family Platter',
        merchantName: 'Hilib Macaan Restaurant',
        discount: '20%',
        timeLeft: '2 days',
      ),
      DealModel(
        id: 'deal_m2',
        imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?q=80&w=600&auto=format&fit=crop',
        title: 'Free Drink with Camel Steak',
        merchantName: 'Hilib Macaan Restaurant',
        discount: 'Free Drink',
        timeLeft: '4 days',
      ),
    ]);
  }

  void addReview(String name, double rating, String content) {
    final newReview = ReviewModel(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
      userName: name.trim().isEmpty ? 'Anonymous User' : name.trim(),
      userAvatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=150&auto=format&fit=crop',
      rating: rating,
      dateAgo: 'Just now',
      content: content.trim(),
      helpfulCount: 0,
      isHelpful: false,
    );
    reviews.insert(0, newReview);
  }

  void toggleHelpful(String reviewId) {
    final index = reviews.indexWhere((element) => element.id == reviewId);
    if (index != -1) {
      final review = reviews[index];
      if (review.isHelpful) {
        review.helpfulCount--;
        review.isHelpful = false;
      } else {
        review.helpfulCount++;
        review.isHelpful = true;
      }
      reviews[index] = review;
      reviews.refresh();
    }
  }
}
