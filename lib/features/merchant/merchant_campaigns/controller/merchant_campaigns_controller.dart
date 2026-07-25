import 'package:get/get.dart';

import '../modules/merchant_campaign_tag.dart';

class MerchantCampaignsController extends GetxController {
  static MerchantCampaignsController get to => Get.find();

  final selectedTab = 0.obs;

  final campaigns = <Map<String, dynamic>>[
    {
      "title": "Sunset Coffee Promotion",
      "type": "Offer Campaign",
      "status": MerchantCampaignStatus.pending,
      "budgetSpent": "\$00 / \$35",
      "applicants": "0",
      "daysLeft": "14 days left",
    },
    {
      "title": "Summer Fashion Promo",
      "type": "Product Campaign",
      "status": MerchantCampaignStatus.pending,
      "budgetSpent": "\$10 / \$50",
      "applicants": "2",
      "daysLeft": "8 days left",
    },
    {
      "title": "Sunset Coffee Promotion",
      "type": "Offer Campaign",
      "status": MerchantCampaignStatus.pending,
      "budgetSpent": "\$00 / \$35",
      "applicants": "3",
      "daysLeft": "3 days left",
    },
    {
      "title": "Sunset Coffee Promotion",
      "type": "Offer Campaign",
      "status": MerchantCampaignStatus.approved,
      "budgetSpent": "\$21 / \$35",
      "applicants": "3",
      "daysLeft": "1 day left",
    },
  ];

  List<Map<String, dynamic>> get currentCampaigns {
    switch (selectedTab.value) {
      // All
      case 0:
        return campaigns;

      // Pending
      case 1:
        return campaigns
            .where((e) => e["status"] == MerchantCampaignStatus.pending)
            .toList();

      // Approved
      case 2:
        return campaigns
            .where((e) => e["status"] == MerchantCampaignStatus.approved)
            .toList();

      default:
        return [];
    }
  }
}
