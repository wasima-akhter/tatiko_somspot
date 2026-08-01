import 'package:get/get.dart';

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
  }

  @override
  void onInit() {
    super.onInit();

    loadDetails(campaignId);
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
