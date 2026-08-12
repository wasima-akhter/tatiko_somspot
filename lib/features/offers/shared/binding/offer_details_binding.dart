import 'package:get/get.dart';

import '../../../../core/di/repo_service_injection.dart';
import '../../offer_details/controller/offer_detail_controller.dart';
import '../../offer_details/helper/offer_details_arg_model.dart';
import '../service/offers_service.dart';

class OfferDetailsBinding extends Bindings {
  final OfferDetailsArgs args;

  OfferDetailsBinding(this.args);

  @override
  void dependencies() {
    Get.lazyPut<OfferDetailController>(
      () => OfferDetailController(
        sl<OfferService>(),
        offerId: args.offerId,
        isFromClaim: args.isFromClaim,
      ),
    );
  }
}
