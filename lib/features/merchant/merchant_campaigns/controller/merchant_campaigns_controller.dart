import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../../merchant_new_campaign/shared/helper/campaign_helper.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_model.dart';
import '../../merchant_new_campaign/shared/service/merchant_campaign_service.dart';

class MerchantCampaignsController extends GetxController {
  final MerchantCampaignService _service;

  MerchantCampaignsController(this._service);

  static MerchantCampaignsController get to => Get.find();

  final listScrollController = ScrollController();

  late final Paginator<MerchantCampaignModel> paginator;

  final selectedTab = MerchantCampaignTab.all.obs;

  String get selectedStatus {
    switch (selectedTab.value) {
      case MerchantCampaignTab.pending:
        return "pending_review";

      case MerchantCampaignTab.live:
        return "live";

      case MerchantCampaignTab.all:
        return "";
    }
  }

  final statusCounts = <String, int>{}.obs;

  final summaryCampaigns = Rxn<SummaryModel?>();

  final summaryLoading = true.obs;
  final summaryError = RxnString();

  @override
  void onInit() {
    super.onInit();

    paginator = Paginator(
      fetchPage: (page, limit) async {
        try {
          summaryLoading.value = true;

          final response = await _service.getCampaigns(
            page: page,
            limit: limit,
            status: selectedStatus,
          );

          final data = response.data;

          summaryCampaigns.value = data?.summary;

          statusCounts[selectedStatus] = data?.meta?.total ?? 0;

          summaryLoading.value = false;

          return data!;
        } catch (e) {
          summaryLoading.value = false;
          summaryError.value = e.toString();

          rethrow;
        }
      },
    );
    listScrollController.addListener(() {
      if (listScrollController.position.pixels >=
          listScrollController.position.maxScrollExtent - 200) {
        loadMore();
      }
    });

    loadCampaigns();
  }

  @override
  void onClose() {
    listScrollController.dispose();
    paginator.dispose();
    super.onClose();
  }

  Future<void> changeTab(MerchantCampaignTab tab) async {
    if (selectedTab.value == tab) {
      return;
    }

    selectedTab.value = tab;

    await paginator.refresh();
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
