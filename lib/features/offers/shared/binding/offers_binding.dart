import 'package:get/get.dart';
import 'package:som_spot/core/di/repo_service_injection.dart';

import '../../offers_list/controller/offer_controller.dart';
import '../service/offers_service.dart';

class OffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OffersController>(
      () => OffersController(sl<OfferService>()),
      fenix: true,
    );
  }
}
