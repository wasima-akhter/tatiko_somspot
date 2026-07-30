import 'package:get/get.dart';

import '../../merchant_new_campaign/shared/helper/campaign_helper.dart';
import '../helper/merchant_campaign_detail_helper.dart';

class MerchantCampaignDetailsController extends GetxController {
  static MerchantCampaignDetailsController get to => Get.find();

  final selectedTab = MerchantCampaignDetailsTab.overview.obs;

  void changeTab(MerchantCampaignDetailsTab tab) {
    selectedTab.value = tab;
  }

  //-----------------------------------------
  // Mock Campaign
  //-----------------------------------------

  final campaign = {
    "title": "Buy 1 Get 1 Free Promo",
    "type": "Offer Campaign",
    "price": "\$35",
    "status": MerchantCampaignStatus.live,
    "budget": "\$500",
    "creators": "3 required",
    "package": "Standard",
    "duration": "14 days left",
    "currentStep": 3,
  };

  //-----------------------------------------
  // Timeline
  //-----------------------------------------

  final List<String> _steps = const [
    "Campaign submitted",
    "Admin approval",
    "Influencers assigned",
    "Content review",
    "Published",
  ];

  List<MerchantCampaignTimelineStep> get timeline {
    final current = campaign["currentStep"] as int;

    return List.generate(_steps.length, (index) {
      late TimelineStepStatus status;

      if (index < current) {
        status = TimelineStepStatus.completed;
      } else if (index == current) {
        status = TimelineStepStatus.current;
      } else {
        status = TimelineStepStatus.pending;
      }

      return MerchantCampaignTimelineStep(title: _steps[index], status: status);
    });
  }

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
