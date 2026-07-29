import 'package:get/get.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../../../merchant/create_offer/controller/create_offer_controller.dart';
import '../service/offers_service.dart';

class CreateOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateOfferController(sl<OfferService>()), fenix: true);
  }
}
