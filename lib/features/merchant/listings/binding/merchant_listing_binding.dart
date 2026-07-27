import 'package:get/get.dart';
import 'package:som_spot/features/merchant/listings/service/manage_listing_service.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../controller/merchant_listing_controller.dart';

class MerchantListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MerchantListingController>(
      () => MerchantListingController(sl<ManageBusinessService>()),
      fenix: true,
    );
  }
}
