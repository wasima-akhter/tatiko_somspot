import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/paginator/paginator.dart';
import '../shared/helper/claims_helper.dart';
import '../shared/response/claims_model.dart';
import '../shared/service/claims_service.dart';

class ClaimItem {
  final String id;
  final String businessName;
  final String businessImage;
  final String title;
  final String expireDate;
  final String claimCode;
  final bool isActive;

  ClaimItem({
    required this.id,
    required this.businessName,
    required this.businessImage,
    required this.title,
    required this.expireDate,
    required this.claimCode,
    this.isActive = true,
  });
}

class ClaimsController extends GetxController {
  final ClaimsService _service;

  ClaimsController(this._service);

  static ClaimsController get to => Get.find();

  final listScrollController = ScrollController();

  late final Paginator<ClaimWalletItemModel> activePaginator;
  late final Paginator<ClaimWalletItemModel> expiredPaginator;

  @override
  void onInit() {
    super.onInit();

    // -------------------------------------------------------------------------
    // Paginators
    // -------------------------------------------------------------------------

    activePaginator = Paginator(
      fetchPage: (page, limit) async {
        final response = await _service.getClaimWallet(
          status: 'claimed',
          page: page,
          limit: limit,
        );

        return response.data!;
      },
    );

    expiredPaginator = Paginator(
      fetchPage: (page, limit) async {
        final response = await _service.getClaimWallet(
          status: 'expired',
          page: page,
          limit: limit,
        );

        return response.data!;
      },
    );

    // -------------------------------------------------------------------------
    // Scroll
    // -------------------------------------------------------------------------

    listScrollController.addListener(() {
      if (!listScrollController.hasClients) return;

      if (listScrollController.position.pixels >=
          listScrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });

    loadActiveClaims();
  }

  final rxSelectedTab = ClaimsTabType.active.obs;

  // ---------------------------------------------------------------------------
  // Tab
  // ---------------------------------------------------------------------------

  Future<void> selectTab(ClaimsTabType tab) async {
    if (rxSelectedTab.value == tab) return;

    rxSelectedTab.value = tab;

    if (tab == ClaimsTabType.active) {
      if (activePaginator.items.isEmpty) {
        await loadActiveClaims();
      }
    } else {
      if (expiredPaginator.items.isEmpty) {
        await loadExpiredClaims();
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Active Claims
  // ---------------------------------------------------------------------------

  Future<void> loadActiveClaims() async {
    print('Before Active Claims: ${activePaginator.items.length}');

    await activePaginator.loadInitial();

    print('After Active Claims: ${activePaginator.items.length}');
  }

  Future<void> refreshActiveClaims() {
    return activePaginator.refresh();
  }

  // ---------------------------------------------------------------------------
  // Expired Claims
  // ---------------------------------------------------------------------------

  Future<void> loadExpiredClaims() async {
    print('Before Expired Claims: ${expiredPaginator.items.length}');

    await expiredPaginator.loadInitial();

    print('After Expired Claims: ${expiredPaginator.items.length}');
  }

  Future<void> refreshExpiredClaims() {
    return expiredPaginator.refresh();
  }

  // ---------------------------------------------------------------------------
  // Pagination
  // ---------------------------------------------------------------------------

  Future<void> loadMore() {
    if (rxSelectedTab.value == ClaimsTabType.active) {
      return activePaginator.loadMore();
    }

    return expiredPaginator.loadMore();
  }

  // ---------------------------------------------------------------------------
  // Refresh
  // ---------------------------------------------------------------------------

  Future<void> refreshClaims() {
    if (rxSelectedTab.value == ClaimsTabType.active) {
      return refreshActiveClaims();
    }

    return refreshExpiredClaims();
  }

  // ---------------------------------------------------------------------------
  // Dispose
  // ---------------------------------------------------------------------------

  @override
  void onClose() {
    listScrollController.dispose();

    activePaginator.dispose();
    expiredPaginator.dispose();

    super.onClose();
  }
}
