import 'package:get/get.dart';
import 'package:som_spot/features/merchant/edit_offer/controller/edit_offer_controller.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../service/offers_service.dart';

class EditOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditOfferController(sl<OfferService>()));
  }
}
