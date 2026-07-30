import 'package:get/get.dart';
import 'package:som_spot/features/merchant/merchant_new_campaign/shared/service/merchant_campaign_service.dart';

import '../../../../../core/di/repo_service_injection.dart';
import '../../../merchant_campaign_details/controller/merchant_campaign_details_controller.dart';
import '../../../merchant_campaign_details/controller/merchat_campaign_content_details_controller.dart';
import '../../../merchant_campaigns/controller/merchant_campaigns_controller.dart';
import '../../controller/merchant_new_campaign_controller.dart';
import '../../controller/merchant_pricing_controller.dart';

class MerchantCampaignsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantCampaignsController>(
      () => MerchantCampaignsController(sl<MerchantCampaignService>()),
    );
  }
}

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
      () => MerchantNewCampaignController(sl<MerchantCampaignService>()),
      fenix: true,
    );
  }
}

class MerchantPricingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantPricingController>(
      () => MerchantPricingController(),
      fenix: true,
    );
  }
}
