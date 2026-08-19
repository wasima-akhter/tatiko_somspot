import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/core/category/controller/category_controller.dart';
import 'package:som_spot/features/offers/shared/response/offers_response.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../core/business/response/business-response.dart';
import '../../../profile/main_profile/controller/profile_controller.dart';
import '../../customer_business_list/controller/customer_business_list_controller.dart';
import '../model/home_content_creator_model.dart';
import '../service/customer_home_service.dart';

class HomeController extends GetxController {
  HomeController(this._service);

  final CustromerHomeService _service;

  static HomeController get to => Get.find();

  ProfileScreenController get profileController => ProfileScreenController.to;

  //

  final selectedCategoryId = "".obs;
  // ---------------------------------------------------------------------------
  // Nearby Businesses
  // ---------------------------------------------------------------------------

  late final Paginator<BusinessModel> nearbyBusinessesPaginator;

  final nearbyBusinessesScrollController = ScrollController();

  final Rx<ApiStatus> nearbyBusinessesStatus = ApiStatus.loading.obs;

  String? nearbyBusinessesError;

  // Current nearby-business search parameters
  final nearbyLat = 23.8103.obs;
  final nearbyLng = 90.4125.obs;
  final double _nearbyRadiusKm = 10;
  String? _nearbyCategory;

  // List<BusinessModel> get nearbyBusinesses => nearbyBusinessesPaginator.items;
  List<BusinessModel> get nearbyBusinesses {
    final items = nearbyBusinessesPaginator.items;
    return items.sublist(0, items.length < 3 ? items.length : 3);
  }

  @override
  void onInit() {
    super.onInit();

    // Load profile once.
    profileController.getProfile();

    // _nearbyLat = profileController.userLocationCords.value.coordinates.first;
    // _nearbyLng = profileController.userLocationCords.value.coordinates.last;

    //
    _initNearbyBusinessesPaginator();

    nearbyBusinessesScrollController.addListener(_onNearbyBusinessesScroll);

    _initTopDealsPaginator();
    topDealsScrollController.addListener(_onTopDealsScroll);

    //
    _initCreatorContentPaginator();

    creatorContentScrollController.addListener(_onCreatorContentScroll);

    loadCreatorContent();

    //
    // Load first page of top deals.
    loadTopDeals();
  }

  // ---------------------------------------------------------------------------
  // Top Deals
  // ---------------------------------------------------------------------------

  late final Paginator<OfferModel> topDealsPaginator;

  final topDealsScrollController = ScrollController();

  final Rx<ApiStatus> topDealsStatus = ApiStatus.loading.obs;

  String? topDealsError;

  List<OfferModel> get topDeals => topDealsPaginator.items;

  void _initTopDealsPaginator() {
    topDealsPaginator = Paginator<OfferModel>(
      fetchPage: (page, limit) async {
        final response = await _service.getTopDeals(page: page, limit: limit);

        if (!response.success || response.data == null) {
          topDealsStatus.value = ApiStatus.error;
          topDealsError = response.message;

          throw Exception(response.message);
        }

        final result = response.data!;

        topDealsStatus.value = result.data.isEmpty
            ? ApiStatus.noDataFound
            : ApiStatus.completed;

        return result;
      },
    );
  }

  Future<void> loadTopDeals() {
    return topDealsPaginator.loadInitial();
  }

  void _onTopDealsScroll() {
    if (!topDealsScrollController.hasClients) return;

    final position = topDealsScrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreTopDeals();
    }
  }

  Future<void> loadMoreTopDeals() {
    return topDealsPaginator.loadMore();
  }

  Future<void> refreshTopDeals() {
    return topDealsPaginator.refresh();
  }

  // ---------------------------------------------------------------------------
  // Nearby Businesses
  // ---------------------------------------------------------------------------

  Future<void> loadNearbyBusinesses() async {
    debugPrint('Before: ${nearbyBusinessesPaginator.items.length}');
    await nearbyBusinessesPaginator.loadInitial();
    debugPrint('After: ${nearbyBusinessesPaginator.items.length}');
  }

  void _initNearbyBusinessesPaginator() {
    debugPrint('nearbyLat : $nearbyLat');

    nearbyBusinessesPaginator = Paginator<BusinessModel>(
      fetchPage: (page, limit) async {
        final response = await _service.getNearbyBusinesses(
          page: page,
          limit: limit,
          lat: nearbyLat.value,
          lng: nearbyLng.value,
          radiusKm: _nearbyRadiusKm,
          category: _nearbyCategory,
        );

        return response.data!;
      },
    );
  }

  void _onNearbyBusinessesScroll() {
    if (!nearbyBusinessesScrollController.hasClients) return;

    final position = nearbyBusinessesScrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreNearbyBusinesses();
    }
  }

  /// Load the next page.
  Future<void> loadMoreNearbyBusinesses() {
    return nearbyBusinessesPaginator.loadMore();
  }

  /// Refresh using the current location/filter.
  Future<void> refreshNearbyBusinesses() {
    return nearbyBusinessesPaginator.refresh();
  }

  @override
  void onClose() {
    nearbyBusinessesScrollController.removeListener(_onNearbyBusinessesScroll);

    nearbyBusinessesScrollController.dispose();
    nearbyBusinessesPaginator.dispose();

    topDealsScrollController.removeListener(_onTopDealsScroll);
    topDealsScrollController.dispose();
    topDealsPaginator.dispose();

    super.onClose();
  }

  // ---------------------------------------------------------------------------
  // Creator Content
  // ---------------------------------------------------------------------------

  //
  RxString get userName => profileController.userName;

  RxString get userProfileImage => profileController.userAvatar;

  RxString get userAddress => profileController.userLocationString;

  String get displayName {
    return userName.value.isEmpty ? AppStrings.user.tr : userName.value;
  }

  String get displayAvatar {
    return userProfileImage.value;
  }

  final RxBool isRefreshing = false.obs;

  Future<void> refreshHomeData() async {
    isRefreshing.value = true;

    try {
      final categoryController = CategoryController.to;

      final nearbyController = Get.find<CustomerBusinessListController>();

      await Future.wait([
        Future(() => refreshCreatorContent()),
        Future(() => profileController.getProfile()),
        Future(() => categoryController.refreshCategories()),
        Future(() => nearbyController.refreshBusinesses(isRefresh: true)),

        Future(() => refreshTopDeals()),
      ]);
    } catch (e) {
      // handle error if required
    } finally {
      isRefreshing.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // Creator Content
  // ---------------------------------------------------------------------------

  late final Paginator<CreatorContentModel> creatorContentPaginator;

  final creatorContentScrollController = ScrollController();

  final Rx<ApiStatus> creatorContentStatus = ApiStatus.loading.obs;

  String? creatorContentError;

  List<CreatorContentModel> get contents => creatorContentPaginator.items;

  void _initCreatorContentPaginator() {
    creatorContentPaginator = Paginator<CreatorContentModel>(
      fetchPage: (page, limit) async {
        final response = await _service.getCreatorContent(
          page: page,
          limit: limit,
        );

        if (!response.success || response.data == null) {
          creatorContentStatus.value = ApiStatus.error;
          creatorContentError = response.message;

          throw Exception(response.message);
        }

        final result = response.data!;

        creatorContentStatus.value = result.data.isEmpty
            ? ApiStatus.noDataFound
            : ApiStatus.completed;

        return result;
      },
    );
  }

  Future<void> fetchCreatorContent({bool isRefresh = false}) async {
    if (isRefresh) {
      await creatorContentPaginator.refresh();
    } else {
      await creatorContentPaginator.loadInitial();
    }
  }

  Future<void> loadCreatorContent() async {
    await creatorContentPaginator.loadInitial();
  }

  Future<void> loadMoreCreatorContent() async {
    await creatorContentPaginator.loadMore();
  }

  Future<void> refreshCreatorContent() async {
    await creatorContentPaginator.refresh();
  }

  void _onCreatorContentScroll() {
    if (!creatorContentScrollController.hasClients) return;

    final position = creatorContentScrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreCreatorContent();
    }
  }

  ///

  //
}
