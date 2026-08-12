import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/customer/customer_business_details/shared/model/deal_model.dart';
import 'package:som_spot/features/customer/customer_home/model/review_model.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/enum/app_enum.dart';
import '../shared/model/customer_buiness_details_model.dart';
import '../shared/service/customer_business_details_service.dart';

class CustomerBusinessDetailsController extends GetxController {
  static CustomerBusinessDetailsController get to => Get.find();

  final CustomerBusinessDetailsService _service;

  /// Business ID passed from the previous screen
  final String businessId;

  CustomerBusinessDetailsController(this._service, {required this.businessId}) {
    debugPrint("CustomerBusinessDetailsController CREATED => $businessId");
  }

  // ============================================================
  // Business Details
  // ============================================================

  final businessStatus = ApiStatus.loading.obs;

  final businessErrorMessage = RxnString();

  final business = Rxn<BusinessDetailsModel>();

  // ============================================================
  // Tabs
  // ============================================================

  final RxInt activeTabIndex = 0.obs;

  // ============================================================
  // Reviews
  // ============================================================

  final RxList<ReviewModel> reviews = <ReviewModel>[].obs;

  // ============================================================
  // Offers
  // ============================================================

  final listScrollController = ScrollController();

  late final Paginator<DealModel> offersPaginator;

  List<DealModel> get merchantOffers => offersPaginator.items;

  // ============================================================
  // Lifecycle
  // ============================================================

  @override
  void onInit() {
    super.onInit();

    debugPrint("CustomerBusinessDetailsController onInit => $businessId");

    // ------------------------------------------------------------
    // Business
    // ------------------------------------------------------------
    loadBusinessDetails();

    // ------------------------------------------------------------
    // Reviews
    // ------------------------------------------------------------
    // Keep these as mock data for now.
    _loadMockReviews();

    // ------------------------------------------------------------
    // Offers
    // ------------------------------------------------------------
    _initOffersPaginator();

    listScrollController.addListener(() {
      if (!listScrollController.hasClients) {
        return;
      }

      if (listScrollController.position.pixels >=
          listScrollController.position.maxScrollExtent - 200) {
        loadMoreOffers();
      }
    });

    loadOffers();
  }

  // ============================================================
  // Offers Paginator
  // ============================================================

  void _initOffersPaginator() {
    offersPaginator = Paginator<DealModel>(
      fetchPage: (page, limit) async {
        try {
          final response = await _service.getOffers(page: page, limit: limit);

          final data = response.data;

          if (data == null) {
            throw Exception(response.message ?? 'Failed to load offers');
          }

          return data;
        } catch (e, s) {
          debugPrint("Get Business Offers Error => $e");
          debugPrintStack(stackTrace: s);

          rethrow;
        }
      },
    );
  }

  // ============================================================
  // Offers Actions
  // ============================================================

  Future<void> loadOffers() {
    return offersPaginator.loadInitial();
  }

  Future<void> loadMoreOffers() {
    return offersPaginator.loadMore();
  }

  Future<void> refreshOffers() {
    return offersPaginator.refresh();
  }

  // ============================================================
  // Business Details API
  // ============================================================

  Future<void> loadBusinessDetails() async {
    try {
      businessStatus.value = ApiStatus.loading;
      businessErrorMessage.value = null;

      final response = await _service.getBusinessDetails(businessId);

      if (response.success) {
        business.value = response.data;

        businessStatus.value = ApiStatus.completed;

        debugPrint("Business Details Loaded => ${business.value?.name}");
      } else {
        businessStatus.value = ApiStatus.error;

        businessErrorMessage.value = response.message;

        debugPrint("Business Details Error => ${response.message}");
      }
    } catch (e, s) {
      businessStatus.value = ApiStatus.error;

      businessErrorMessage.value = e.toString();

      debugPrint("Load Business Details Exception => $e");

      debugPrintStack(stackTrace: s);
    }
  }

  // ============================================================
  // Refresh Business Details
  // ============================================================

  Future<void> refreshBusinessDetails() async {
    await loadBusinessDetails();
  }

  // ============================================================
  // Tabs
  // ============================================================

  void changeTab(int index) {
    activeTabIndex.value = index;
  }

  // ============================================================
  // Mock Reviews
  // ============================================================

  void _loadMockReviews() {
    reviews.assignAll([
      ReviewModel(
        id: 'rev_1',
        userName: 'Mohamed Ali',
        userAvatar:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=150&auto=format&fit=crop',
        rating: 5.0,
        dateAgo: '2 days ago',
        content:
            'The hilib suqaar here is incredible! Best Somali food in Mogadishu. The service is fast and the staff are very friendly.',
        helpfulCount: 12,
        isHelpful: false,
      ),
      ReviewModel(
        id: 'rev_2',
        userName: 'Fatima Hassan',
        userAvatar:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150&auto=format&fit=crop',
        rating: 4.0,
        dateAgo: '2 days ago',
        content:
            'The service is excellent and the place is extremely neat. The camel meat platter was cooked to absolute perfection. Highly recommended!',
        helpfulCount: 5,
        isHelpful: false,
      ),
      ReviewModel(
        id: 'rev_3',
        userName: 'Yusup Ahmed',
        userAvatar:
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=150&auto=format&fit=crop',
        rating: 4.0,
        dateAgo: '3 days ago',
        content:
            'Authentic Somali cuisine. Very tasty and rich in flavors. Portions are generous.',
        helpfulCount: 2,
        isHelpful: false,
      ),
    ]);
  }

  // ============================================================
  // Reviews
  // ============================================================

  void addReview(String name, double rating, String content) {
    final newReview = ReviewModel(
      id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
      userName: name.trim().isEmpty ? 'Anonymous User' : name.trim(),
      userAvatar:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=150&auto=format&fit=crop',
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
