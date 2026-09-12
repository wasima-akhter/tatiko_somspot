import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/offers/shared/response/offers_response.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../core/business/response/business-response.dart';
import '../../../core/category/binding/category_binding_helper.dart';
import '../../../core/location/current_location/current_location_controller.dart';
import '../../../profile/main_profile/controller/profile_controller.dart';
import '../../customer_business_list/controller/customer_business_list_controller.dart';
import '../model/home_content_creator_model.dart';
import '../repository/customer_home_repository.dart';
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

  // ---------------------------------------------------------------------------
  // Location
  // ---------------------------------------------------------------------------

  LocationController get locationController => LocationController.to;

  final nearbyLat = RxnDouble();
  final nearbyLng = RxnDouble();

  final nearbyLocationUnavailable = false.obs;

  final double _nearbyRadiusKm = 10;
  String? _nearbyCategory;

  List<BusinessModel> get nearbyBusinesses {
    final items = nearbyBusinessesPaginator.items;

    return items.sublist(0, items.length < 3 ? items.length : 3);
  }

  @override
  void onInit() {
    super.onInit();

    // Load profile once.
    profileController.getProfile();

    // Nearby businesses
    _initNearbyBusinessesPaginator();
    nearbyBusinessesScrollController.addListener(_onNearbyBusinessesScroll);
    _initializeLocationAndNearbyBusinesses();

    // Top Deals
    _initTopDealsPaginator();
    topDealsScrollController.addListener(_onTopDealsScroll);

    // Creator Content
    _initCreatorContentPaginator();
    creatorContentScrollController.addListener(_onCreatorContentScroll);

    loadCreatorContent();
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
  // ---------------------------------------------------------------------------
  // Nearby Businesses
  // ---------------------------------------------------------------------------

  void _initNearbyBusinessesPaginator() {
    nearbyBusinessesPaginator = Paginator<BusinessModel>(
      fetchPage: (page, limit) async {
        final lat = nearbyLat.value;
        final lng = nearbyLng.value;

        // Location is required before making the API request.
        if (lat == null || lng == null) {
          throw Exception('Location is unavailable');
        }

        final response = await _service.getNearbyBusinesses(
          page: page,
          limit: limit,
          lat: lat,
          lng: lng,
          radiusKm: _nearbyRadiusKm,
          category: _nearbyCategory,
          locationMode: BusinessLocationMode.nearby,
        );

        if (!response.success || response.data == null) {
          nearbyBusinessesStatus.value = ApiStatus.error;
          nearbyBusinessesError = response.message;

          throw Exception(response.message);
        }

        final result = response.data!;

        nearbyBusinessesStatus.value = result.data.isEmpty
            ? ApiStatus.noDataFound
            : ApiStatus.completed;

        return result;
      },
    );
  }

  Future<void> _initializeLocationAndNearbyBusinesses() async {
    nearbyLocationUnavailable.value = false;
    nearbyBusinessesStatus.value = ApiStatus.loading;
    nearbyBusinessesError = null;

    final position = await locationController.getCurrentLocation();

    if (position == null) {
      nearbyLocationUnavailable.value = true;
      nearbyBusinessesStatus.value = ApiStatus.noDataFound;

      nearbyBusinessesError =
          'Location is unavailable. Enable location to find businesses nearby.';

      return;
    }

    nearbyLat.value = position.latitude;
    nearbyLng.value = position.longitude;

    debugPrint(
      'Home location: '
      '${nearbyLat.value}, ${nearbyLng.value}',
    );

    await loadNearbyBusinesses();
  }

  Future<void> loadNearbyBusinesses() async {
    if (nearbyLat.value == null || nearbyLng.value == null) {
      return;
    }

    debugPrint(
      'Loading nearby businesses at: '
      '${nearbyLat.value}, ${nearbyLng.value}',
    );

    await nearbyBusinessesPaginator.loadInitial();

    debugPrint(
      'Nearby businesses loaded: '
      '${nearbyBusinessesPaginator.items.length}',
    );
  }

  Future<void> retryNearbyLocation() async {
    await _initializeLocationAndNearbyBusinesses();
  }

  void _onNearbyBusinessesScroll() {
    if (!nearbyBusinessesScrollController.hasClients) return;

    final position = nearbyBusinessesScrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreNearbyBusinesses();
    }
  }

  Future<void> loadMoreNearbyBusinesses() {
    return nearbyBusinessesPaginator.loadMore();
  }

  Future<void> refreshNearbyBusinesses() async {
    // If we don't currently have a location, try to obtain it first.
    if (nearbyLat.value == null || nearbyLng.value == null) {
      await _initializeLocationAndNearbyBusinesses();
      return;
    }

    await nearbyBusinessesPaginator.refresh();
  }

  @override
  void onClose() {
    nearbyBusinessesScrollController.removeListener(_onNearbyBusinessesScroll);

    nearbyBusinessesScrollController.dispose();
    nearbyBusinessesPaginator.dispose();

    topDealsScrollController.removeListener(_onTopDealsScroll);
    topDealsScrollController.dispose();
    topDealsPaginator.dispose();

    creatorContentScrollController.removeListener(_onCreatorContentScroll);

    creatorContentScrollController.dispose();
    creatorContentPaginator.dispose();

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

  final categoryController = CategoryBindings.customerController;
  Future<void> refreshHomeData() async {
    isRefreshing.value = true;

    try {
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
