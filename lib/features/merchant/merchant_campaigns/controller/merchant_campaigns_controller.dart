import 'package:get/get.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../merchant_new_campaign/shared/helper/campaign_helper.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_model.dart';
import '../../merchant_new_campaign/shared/service/merchant_campaign_service.dart';

class MerchantCampaignsController extends GetxController {
  final MerchantCampaignService _service;

  MerchantCampaignsController(this._service);

  static MerchantCampaignsController get to => Get.find();

  late final Paginator<MerchantCampaignModel> paginator;

  final apiStatus = ApiStatus.loading.obs;
  final RxnString errorMessage = RxnString();

  final selectedTab = MerchantCampaignTab.all.obs;

  String get selectedStatus {
    switch (selectedTab.value) {
      case MerchantCampaignTab.pending:
        return "pending_review";

      case MerchantCampaignTab.live:
        return "live";

      case MerchantCampaignTab.all:
        return "all";
    }
  }

  final statusCounts = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();

    paginator = Paginator(
      fetchPage: (page, limit) async {
        try {
          apiStatus.value = ApiStatus.loading;

          final response = await _service.getCampaigns(
            page: page,
            limit: limit,
            status: selectedStatus,
          );

          final data = response.data;

          statusCounts[selectedStatus] = data?.meta?.total ?? 0;

          apiStatus.value = ApiStatus.completed;

          return data!;
        } catch (e) {
          apiStatus.value = ApiStatus.error;
          errorMessage.value = e.toString();

          rethrow;
        }
      },
    );
    loadCampaigns();
  }

  Future<void> changeTab(MerchantCampaignTab tab) async {
    if (selectedTab.value == tab) {
      return;
    }

    selectedTab.value = tab;

    await paginator.loadInitial();
  }

  Future<void> loadCampaigns() {
    return paginator.loadInitial();
  }

  Future<void> loadMore() {
    return paginator.loadMore();
  }

  Future<void> refreshCampaigns() {
    return paginator.refresh();
  }

  List<MerchantCampaignModel> get campaigns => paginator.items;
}
