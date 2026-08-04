import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_detail_model.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_model.dart';
import '../../merchant_new_campaign/shared/service/merchant_campaign_service.dart';
import '../helper/merchant_campaign_detail_helper.dart';

class MerchantCampaignDetailsController extends GetxController {
  final MerchantCampaignService _service;

  final String campaignId;

  MerchantCampaignDetailsController(this._service, this.campaignId) {
    debugPrint("MerchantCampaignDetailsController CREATED => $campaignId");
  }

  static MerchantCampaignDetailsController get to => Get.find();

  final selectedTab = MerchantCampaignDetailsTab.overview.obs;

  final status = ApiStatus.loading.obs;

  final errorMessage = RxnString();

  final campaign = Rxn<MerchantCampaignDetailsModel>();

  void changeTab(MerchantCampaignDetailsTab tab) {
    selectedTab.value = tab;

    switch (tab) {
      case MerchantCampaignDetailsTab.overview:
        refreshOverview();
        break;

      case MerchantCampaignDetailsTab.influencers:
        refreshApplications();
        break;

      case MerchantCampaignDetailsTab.content:
        refreshContents();
        break;
    }
  }

  void refreshOverview() async {
    await loadDetails(campaignId);
  }

  Future<void> loadDetails(String id) async {
    try {
      status.value = ApiStatus.loading;

      final response = await _service.getCampaignDetails(id);

      if (response.success) {
        campaign.value = response.data;

        status.value = ApiStatus.completed;
      } else {
        status.value = ApiStatus.error;

        errorMessage.value = response.message;
      }
    } catch (e) {
      status.value = ApiStatus.error;

      errorMessage.value = e.toString();
    }
  }

  // ===============================
  // Campaign Applications Pagination
  // ===============================

  late final Paginator<CampaignApplicationModel> applicationsPaginator;

  final ScrollController applicationScrollController = ScrollController();

  List<CampaignApplicationModel> get applications =>
      applicationsPaginator.items;

  @override
  void onInit() {
    super.onInit();

    debugPrint("onInit campaignId => $campaignId");

    applicationsPaginator = Paginator<CampaignApplicationModel>(
      fetchPage: (page, limit) async {
        try {
          final response = await _service.getCampaignApplications(
            campaignId: campaignId,
            page: page,
            limit: limit,
          );

          final data = response.data;

          if (response.success && data != null) {
            return data;
          }

          throw Exception(response.message ?? "Failed to load applications");
        } catch (e) {
          rethrow;
        }
      },
    );

    applicationScrollController.addListener(() {
      if (applicationScrollController.position.pixels >=
          applicationScrollController.position.maxScrollExtent - 200) {
        loadMoreApplications();
      }
    });

    //
    contentsPaginator = Paginator<CampaignContentModel>(
      fetchPage: (page, limit) async {
        final response = await _service.getCampaignContents(
          campaignId: campaignId,
          page: page,
          limit: limit,
        );

        if (response.success && response.data != null) {
          return response.data!;
        }

        throw Exception(response.message ?? "Failed loading contents");
      },
    );

    loadDetails(campaignId);

    loadApplications();

    loadContents();
  }

  // Initial load
  Future<void> loadApplications() async {
    await applicationsPaginator.loadInitial();
  }

  // Pagination
  Future<void> loadMoreApplications() async {
    await applicationsPaginator.loadMore();
  }

  // Refresh
  Future<void> refreshApplications() async {
    await applicationsPaginator.refresh();
  }

  @override
  void onClose() {
    applicationScrollController.dispose();
    applicationsPaginator.dispose();

    contentsPaginator.dispose();

    super.onClose();
  }

  //
  final creatorStatus = ApiStatus.loading.obs;

  final creator = Rxn<MerchantCreatorModel>();

  Future<void> loadCreator(String userId) async {
    try {
      creatorStatus.value = ApiStatus.loading;

      final response = await _service.assignedInfluencerDetail(userId);

      if (response.success) {
        creator.value = response.data;

        creatorStatus.value = ApiStatus.completed;
      } else {
        creatorStatus.value = ApiStatus.error;
      }
    } catch (e) {
      creatorStatus.value = ApiStatus.error;
    }
  }

  // campaign -detail>content tab
  late final Paginator<CampaignContentModel> contentsPaginator;

  List<CampaignContentModel> get contents => contentsPaginator.items;

  final contentActionStatus = ApiStatus.completed.obs;

  final contentActionLoading = RxnString();

  Future<void> loadContents() {
    return contentsPaginator.loadInitial();
  }

  Future<void> refreshContents() {
    return contentsPaginator.refresh();
  }

  //
  final reasonController = TextEditingController();
  Future<bool> changeContentStatus({
    required String action,
    String? rejectionReason,
    required String contentId,
  }) async {
    contentActionLoading.value = action;

    final response = await _service.updateContentStatus(
      contentId: contentId,
      action: action,
      rejectionReason: rejectionReason,
    );

    if (!response.success) {
      contentActionLoading.value = null;
      return false;
    }

    contentActionLoading.value = null;

    await refreshContents();

    return true;
  }
  // campaign -content details

  final contentDetailStatus = ApiStatus.loading.obs;

  final errorMessageContentDetail = RxnString();

  final contentDetail = Rxn<CampaignContentModel>();

  Future<void> loadContentDetails(String contentId) async {
    debugPrint('loadContentDetails--> called');
    try {
      contentDetailStatus.value = ApiStatus.loading;

      final response = await _service.getCampaignContentDetails(
        applicationId: contentId,
      );

      if (response.success) {
        debugPrint('loadContentDetails--> response.success');
        contentDetail.value = response.data;

        contentDetailStatus.value = ApiStatus.completed;
      } else {
        errorMessageContentDetail.value = response.message;

        contentDetailStatus.value = ApiStatus.error;
      }
    } catch (e) {
      errorMessageContentDetail.value = e.toString();

      contentDetailStatus.value = ApiStatus.error;
    }
  }
}
