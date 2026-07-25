import 'package:get/get.dart';

import '../controller/merchant_campaigns_controller.dart';

class MerchantCampaignsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantCampaignsController>(
      () => MerchantCampaignsController(),
      fenix: true,
    );
  }
}
