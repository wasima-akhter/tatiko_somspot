import 'package:get/get.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../../offer_details/controller/offer_detail_controller.dart';
import '../service/offers_service.dart';

// class OfferDetailsBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<OfferDetailController>(
//       () => OfferDetailController(sl<OfferService>()),
//       fenix: true,
//     );
//   }
// }
class OfferDetailsBinding extends Bindings {
  final String offerId;

  OfferDetailsBinding(this.offerId);

  @override
  void dependencies() {
    Get.lazyPut<OfferDetailController>(
      () => OfferDetailController(sl<OfferService>(), offerId),
    );
  }
}
