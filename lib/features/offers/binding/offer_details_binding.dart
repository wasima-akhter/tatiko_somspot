import 'package:get/get.dart';

import '../../../core/di/repo_service_injection.dart';
import '../../dashboard/create_offer/service/create_offer_service.dart';
import '../controller/offer_detail_controller.dart';

class OfferDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferDetailsController>(
      () => OfferDetailsController(sl<OfferService>()),
    );
  }
}
