import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../core/business/response/business-response.dart';
import '../../../profile/main_profile/controller/profile_controller.dart';
import '../../customer_home/service/customer_home_service.dart';
import '../arg/customer_business_list_arg_model.dart';

class CustomerBusinessListController extends GetxController {
  CustomerBusinessListController(this._service, {this.categoryInfo});

  final CustromerHomeService _service;
  final CustomerBusinessListArgModel? categoryInfo;

  static CustomerBusinessListController get to => Get.find();

  ProfileScreenController get profileController => ProfileScreenController.to;

  // ---------------------------------------------------------------------------
  // Business List Paginator & Scroll
  // ---------------------------------------------------------------------------

  late final Paginator<BusinessModel> businessListPaginator;

  final businessListScrollController = ScrollController();

  final Rx<ApiStatus> businessListStatus = ApiStatus.loading.obs;

  String? businessListError;

  // Search parameters
  final businessLat = 23.8103.obs;
  final businessLng = 90.4125.obs;
  final double _businessRadiusKm = 10;

  List<BusinessModel> get businesses => businessListPaginator.items;

  @override
  void onInit() {
    super.onInit();

    // Load profile once.
    profileController.getProfile();

    // If coordinates are stored as a list/object in profileController, bind them:
    // businessLat.value = profileController.userLocationCords.value.coordinates.first;
    // businessLng.value = profileController.userLocationCords.value.coordinates.last;

    _initBusinessListPaginator();

    businessListScrollController.addListener(_onBusinessListScroll);

    loadInitialBusinesses();
  }

  Future<void> loadInitialBusinesses() async {
    await businessListPaginator.loadInitial();
  }

  void _initBusinessListPaginator() {
    businessListPaginator = Paginator<BusinessModel>(
      fetchPage: (page, limit) async {
        if (categoryInfo == null || categoryInfo!.categoryId.isEmpty) {
          businessListPaginator.status.value = ApiStatus.noDataFound;
          businessListPaginator.errorMessage.value =
              "No businesses found under this category.";
          return PaginatedResult<BusinessModel>(data: [], meta: null);
        }
        final response = await _service.getNearbyBusinesses(
          page: page,
          limit: limit,
          lat: businessLat.value,
          lng: businessLng.value,
          radiusKm: _businessRadiusKm,
          category: categoryInfo?.categoryId ?? '',
        );

        return response.data!;
      },
    );
  }

  void _onBusinessListScroll() {
    if (!businessListScrollController.hasClients) return;

    final position = businessListScrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreBusinesses();
    }
  }

  /// Load the next page.
  Future<void> loadMoreBusinesses() {
    return businessListPaginator.loadMore();
  }

  /// Refresh using current parameters.
  Future<void> refreshBusinesses({bool isRefresh = false}) async {
    return businessListPaginator.refresh();
  }

  @override
  void onClose() {
    businessListScrollController.removeListener(_onBusinessListScroll);
    businessListScrollController.dispose();
    businessListPaginator.dispose();

    super.onClose();
  }
}
