import 'package:get/get.dart';
import 'package:som_spot/features/merchant/merchant_new_campaign/controller/merchant_new_campaign_controller.dart';

import '../controller/merchant_campaign_details_controller.dart';
import '../controller/merchat_campaign_content_details_controller.dart';

class MerchantCampaignDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantCampaignDetailsController>(
      () => MerchantCampaignDetailsController(),
      fenix: true,
    );
  }
}

class MerchantCampaignContentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantCampaignContentDetailsController>(
      () => MerchantCampaignContentDetailsController(),
      fenix: true,
    );
  }
}

class MerchantNewCampaignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantNewCampaignController>(
      () => MerchantNewCampaignController(),
      fenix: true,
    );
  }
}
