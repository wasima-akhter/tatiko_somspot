import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/snackbar/api_snackbar.dart';
import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../offers/shared/response/offers_response.dart';
import '../../review/response/review_response.dart';
import '../../review/service/review_service.dart';
import '../../saved/shared/service/saved_service.dart';
import '../shared/model/customer_buiness_details_model.dart';
import '../shared/service/customer_business_details_service.dart';

class CustomerBusinessDetailsController extends GetxController {
  static CustomerBusinessDetailsController get to => Get.find();

  final CustomerBusinessDetailsService _service;
  final SavedService _savedService;
  final ReviewService _reviewService;

  /// Business ID passed from the previous screen
  final String businessId;

  CustomerBusinessDetailsController(
    this._service, {
    required this.businessId,
    required ReviewService reviewService,
    required SavedService savedService,
  }) : _savedService = savedService,
       _reviewService = reviewService {
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
  // Offers
  // ============================================================

  final listScrollController = ScrollController();

  late final Paginator<OfferModel> offersPaginator;

  List<OfferModel> get merchantOffers => offersPaginator.items;

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
    _initReviewsPaginator();

    reviewListScrollController.addListener(() {
      if (reviewListScrollController.position.pixels >=
          reviewListScrollController.position.maxScrollExtent - 200) {
        loadMoreReviews();
      }
    });

    loadBusinessReviews();
    // ------------------------------------------------------------
    // Offers
    // ------------------------------------------------------------
    _initOffersPaginator();

    listScrollController.addListener(() {
      if (!listScrollController.hasClients) return;

      if (listScrollController.position.pixels >=
          listScrollController.position.maxScrollExtent - 200) {
        if (activeTabIndex.value == 1) {
          loadMoreOffers();
        } else if (activeTabIndex.value == 2) {
          loadMoreReviews();
        }
      }
    });

    loadOffers();
  }

  // ============================================================
  // Offers Paginator
  // ============================================================

  void _initOffersPaginator() {
    offersPaginator = Paginator<OfferModel>(
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

        // Initialize bookmark state from real business data
        isBusinessSaved.value = response.data!.isSaved ?? false;

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

  // Bookmark
  final isBusinessSaved = false.obs;
  final saveStatus = ApiStatus.completed.obs;
  final saveErrorMessage = ''.obs;

  Future<void> toggleBusinessSaved() async {
    if (saveStatus.value == ApiStatus.loading) return;

    final previousValue = isBusinessSaved.value;

    // Optimistic UI update
    isBusinessSaved.value = !previousValue;

    saveStatus.value = ApiStatus.loading;
    saveErrorMessage.value = '';

    try {
      final response = await _savedService.toggleSaved(businessId: businessId);

      if (response.success) {
        final data = response.data;

        // Server is the source of truth
        isBusinessSaved.value = data?.saved == true;

        saveStatus.value = ApiStatus.completed;

        ApiSnackbar.show(response.message, type: SnackbarType.success);
      } else {
        // Revert optimistic update
        isBusinessSaved.value = previousValue;

        saveErrorMessage.value = response.message;
        saveStatus.value = ApiStatus.error;

        ApiSnackbar.show(response.message);
      }
    } catch (e, s) {
      isBusinessSaved.value = previousValue;

      saveErrorMessage.value = "Something went wrong";
      saveStatus.value = ApiStatus.error;

      debugPrint("Toggle Business Saved Error => $e");
      debugPrintStack(stackTrace: s);

      ApiSnackbar.show(AppStrings.somethingWentWrong.tr);
    }
  }

  //

  // ============================================================
  // Reviews
  // ============================================================

  final reviewListScrollController = ScrollController();

  late final Paginator<BusinessReviewModel> reviewsPaginator;

  final reviewsErrorMessage = ''.obs;

  final postReviewStatus = ApiStatus.completed.obs;
  final postReviewErrorMessage = ''.obs;

  // Review helpful loading state.
  // Only stores review IDs currently being toggled.
  final RxSet<String> helpfulLoadingReviews = <String>{}.obs;

  List<BusinessReviewModel> get reviews => reviewsPaginator.items;

  // ------------------------------------------------------------
  // Reviews Paginator
  // ------------------------------------------------------------

  void _initReviewsPaginator() {
    reviewsPaginator = Paginator<BusinessReviewModel>(
      fetchPage: (page, limit) async {
        try {
          final response = await _reviewService.getBusinessReviews(
            businessId: businessId,
            page: page,
            limit: limit,
          );

          if (!response.success || response.data == null) {
            reviewsErrorMessage.value = response.message;
            throw Exception(response.message);
          }

          reviewsErrorMessage.value = '';

          return response.data!;
        } catch (e, s) {
          reviewsErrorMessage.value = e.toString();

          debugPrint("Get Business Reviews Error => $e");
          debugPrintStack(stackTrace: s);

          rethrow;
        }
      },
    );
  }

  // ------------------------------------------------------------
  // Reviews Actions
  // ------------------------------------------------------------

  Future<void> loadBusinessReviews() {
    return reviewsPaginator.loadInitial();
  }

  Future<void> loadMoreReviews() {
    return reviewsPaginator.loadMore();
  }

  Future<void> refreshBusinessReviews() {
    return reviewsPaginator.refresh();
  }

  // ------------------------------------------------------------
  // Post Review
  // ------------------------------------------------------------

  Future<bool> postReview({
    required double rating,
    required String review,
  }) async {
    if (postReviewStatus.value == ApiStatus.loading) {
      return false;
    }

    postReviewStatus.value = ApiStatus.loading;
    postReviewErrorMessage.value = '';

    try {
      final response = await _reviewService.postReview(
        businessId: businessId,
        rating: rating,
        review: review,
      );

      if (response.success) {
        postReviewStatus.value = ApiStatus.completed;

        // Reload reviews so the newly posted review appears.
        await refreshBusinessReviews();

        return true;
      }

      postReviewErrorMessage.value = response.message;
      postReviewStatus.value = ApiStatus.error;

      ApiSnackbar.show(response.message);

      return false;
    } catch (e, s) {
      postReviewErrorMessage.value = AppStrings.somethingWentWrong.tr;
      postReviewStatus.value = ApiStatus.error;

      debugPrint("Post Review Error => $e");
      debugPrintStack(stackTrace: s);

      ApiSnackbar.show(AppStrings.somethingWentWrong.tr);

      return false;
    }
  }

  // ------------------------------------------------------------
  // Helpful
  // ------------------------------------------------------------

  BusinessReviewModel? getReviewById(String reviewId) {
    final index = reviewsPaginator.items.indexWhere(
      (review) => review.id == reviewId,
    );

    if (index == -1) return null;

    return reviewsPaginator.items[index];
  }

  bool isHelpfulLoading(String reviewId) {
    return helpfulLoadingReviews.contains(reviewId);
  }

  Future<void> toggleReviewHelpful({required String reviewId}) async {
    // Prevent multiple requests for the same review.
    if (helpfulLoadingReviews.contains(reviewId)) {
      return;
    }

    helpfulLoadingReviews.add(reviewId);

    try {
      final response = await _reviewService.toggleReviewHelpful(
        reviewId: reviewId,
      );

      if (!response.success || response.data == null) {
        ApiSnackbar.show(response.message);
        return;
      }

      final result = response.data!;

      final index = reviewsPaginator.items.indexWhere(
        (review) => review.id == reviewId,
      );

      if (index == -1) {
        return;
      }

      final oldReview = reviewsPaginator.items[index];

      // Backend is the source of truth.
      final updatedReview = BusinessReviewModel(
        id: oldReview.id,
        user: oldReview.user,
        rating: oldReview.rating,
        review: oldReview.review,
        isHelpful: result.isHelpful,
        helpfulCount: result.helpfulCount,
        createdAt: oldReview.createdAt,
      );

      reviewsPaginator.items[index] = updatedReview;

      // Make sure Obx widgets listening to the paginator's RxList rebuild.
      reviewsPaginator.items.refresh();
    } catch (e, s) {
      debugPrint("Toggle Review Helpful Error => $e");
      debugPrintStack(stackTrace: s);

      ApiSnackbar.show(AppStrings.somethingWentWrong.tr);
    } finally {
      helpfulLoadingReviews.remove(reviewId);
    }
  }
  ////------------------------------------

  @override
  void onClose() {
    listScrollController.dispose();
    reviewsPaginator.dispose();

    super.onClose();
  }
}
