import 'package:get/get.dart';

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

  // Selected tab using enum instead of int
  final rxSelectedTab = ClaimsTabType.active.obs;

  late final Paginator<ClaimWalletItemModel> activePaginator;
  late final Paginator<ClaimWalletItemModel> expiredPaginator;

  @override
  void onInit() {
    super.onInit();

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
  }

  void changeTab(ClaimsTabType tab) {
    if (rxSelectedTab.value == tab) return;

    rxSelectedTab.value = tab;

    if (tab == ClaimsTabType.active) {
      if (activePaginator.items.isEmpty) {
        activePaginator.refresh();
      }
    } else {
      if (expiredPaginator.items.isEmpty) {
        expiredPaginator.refresh();
      }
    }
  }

  Future<void> refreshClaims() async {
    if (rxSelectedTab.value == ClaimsTabType.active) {
      await activePaginator.refresh();
    } else {
      await expiredPaginator.refresh();
    }
  }
}
