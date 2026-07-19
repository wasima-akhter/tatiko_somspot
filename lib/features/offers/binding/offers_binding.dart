import 'package:get/get.dart';
import 'package:som_spot/core/di/repo_service_injection.dart';

import '../../dashboard/create_offer/service/create_offer_service.dart';
import '../controller/offer_controller.dart';

class OffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OffersController>(
      () => OffersController(sl<OfferService>()),
      fenix: true,
    );
  }
}
