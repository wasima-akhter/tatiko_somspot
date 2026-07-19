import 'package:get/get.dart';

import '../influencer_my_campaigns/controller/influencer_my_campaigns_controller.dart';

class InfluencerBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => InfluencerDiscoverController());

    // Get.lazyPut(() => InfluencerTaskController());

    // Get.lazyPut(() => InfluencerWalletController());

    Get.lazyPut(() => InfluencerMyCampaignsController());
  }
}
