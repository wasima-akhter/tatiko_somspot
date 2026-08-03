import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_detail_model.dart';
import '../../merchant_new_campaign/shared/service/merchant_campaign_service.dart';
import '../helper/merchant_campaign_detail_helper.dart';

class MerchantCampaignDetailsController extends GetxController {
  final MerchantCampaignService _service;

  final String campaignId;

  MerchantCampaignDetailsController(this._service, this.campaignId);

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
        // refreshContents();
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

    loadDetails(campaignId);

    loadApplications();
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

  // mock data
  final influencers = [
    {
      "name": "Ahmed Hassan",
      "category": "Food Creator",
      "avatar": "https://i.pravatar.cc/150?img=12",
      "assigned": true,
    },
    {
      "name": "Mohamed Ali",
      "category": "Lifestyle Creator",
      "avatar": "https://i.pravatar.cc/150?img=20",
      "assigned": true,
    },
    {
      "name": "Amina Yusuf",
      "category": "Travel Creator",
      "avatar": "https://i.pravatar.cc/150?img=32",
      "assigned": true,
    },
  ];
  final contents = [
    {
      "creator": "Ahmed Hassan",
      "time": "2 hours ago",
      "image": "https://images.unsplash.com/photo-1528605248644-14dd04022da1",
      "caption":
          "Best Pizza in Mogadishu 🍕 Buy 1 Get 1 Free today through @SomSpot — link in bio! #MogadishuEats #SomSpot",
      "status": "pending",
    },
    {
      "creator": "Mohamed Ali",
      "time": "5 hours ago",
      "image": "https://images.unsplash.com/photo-1528605248644-14dd04022da1",
      "caption": "Amazing grilled chicken! 🔥 Visit today.",
      "status": "pending",
    },
  ];
}
