import 'package:get/get.dart';

import '../helper/my_campaigns_helper.dart';

class InfluencerMyCampaignsController extends GetxController {
  static InfluencerMyCampaignsController get to => Get.find();
  final RxBool isActive = true.obs;

  final activeCampaigns = <CampaignModel>[
    CampaignModel(
      brand: "Mogadishu Pizza",
      title: "Buy 1 Get 1 Free Promo",
      status: CampaignStatus.inProgress,
    ),
    CampaignModel(
      brand: "Burger House",
      title: "Weekend Combo",
      status: CampaignStatus.inProgress,
    ),
    CampaignModel(
      brand: "Coffee Time",
      title: "Summer Campaign",
      status: CampaignStatus.inProgress,
    ),
  ].obs;

  final completedCampaigns = <CampaignModel>[
    CampaignModel(
      brand: "Pizza Hub",
      title: "Holiday Offer",
      status: CampaignStatus.completed,
    ),
    CampaignModel(
      brand: "Fresh Juice",
      title: "Fruit Festival",
      status: CampaignStatus.completed,
    ),
  ].obs;

  List<CampaignModel> get campaigns =>
      isActive.value ? activeCampaigns : completedCampaigns;

  void changeTab(bool active) {
    isActive.value = active;
  }
}
