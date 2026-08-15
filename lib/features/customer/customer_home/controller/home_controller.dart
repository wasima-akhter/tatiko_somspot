import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/core/category/controller/category_controller.dart';

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

  final RxList<CreatorContentModel> contents = <CreatorContentModel>[].obs;

  final Rx<ApiStatus> contentStatus = ApiStatus.completed.obs;

  String? contentError;

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

  List<BusinessModel> get nearbyBusinesses => nearbyBusinessesPaginator.items;

  @override
  void onInit() {
    super.onInit();

    // Load profile once.
    profileController.getProfile();

    // _nearbyLat = profileController.userLocationCords.value.coordinates.first;
    // _nearbyLng = profileController.userLocationCords.value.coordinates.last;

    _initNearbyBusinessesPaginator();

    nearbyBusinessesScrollController.addListener(_onNearbyBusinessesScroll);

    fetchCreatorContent();
  }

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
    return userName.value.isEmpty ? 'User' : userName.value;
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
        Future(() => fetchCreatorContent()),
        Future(() => profileController.getProfile()),
        Future(() => categoryController.refreshCategories()),
        Future(() => nearbyController.refreshBusinesses(isRefresh: true)),
      ]);
    } catch (e) {
      // handle error if required
    } finally {
      isRefreshing.value = false;
    }
  }

  Future<void> fetchCreatorContent({bool isRefresh = false}) async {
    if (!isRefresh && contents.isEmpty) {
      contentStatus.value = ApiStatus.loading;
    }

    contentError = null;

    final response = await _service.getCreatorContent();

    if (!response.success) {
      contentStatus.value = ApiStatus.error;
      contentError = response.message;
      return;
    }

    final data = response.data ?? [];

    contents.assignAll(data);

    if (contents.isEmpty) {
      contentStatus.value = ApiStatus.noDataFound;
      return;
    }

    contentStatus.value = ApiStatus.completed;
  }

  ///

  //
}
