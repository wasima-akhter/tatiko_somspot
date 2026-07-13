import 'package:get/get.dart';

import '../../other/controller/other_controller.dart';
import '../influencer_discover/controller/influencer_discover_controller.dart';
import '../influencer_my_campaigns/controller/influencer_my_campaigns_controller.dart';
import '../influencer_task_screen/controller/influencer_task_controller.dart';
import '../influencer_wallet/controller/influencer_wallet_controller.dart';

class InfluencerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InfluencerDiscoverController());

    Get.lazyPut(() => InfluencerTaskController());

    Get.lazyPut(() => InfluencerWalletController());

    Get.lazyPut(() => InfluencerMyCampaignsController());

    Get.lazyPut(() => OtherController());
  }
}
