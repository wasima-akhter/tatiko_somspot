import 'package:get/get.dart';
import 'package:som_spot/features/customer/saved/shared/service/saved_service.dart';

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
        savedService: sl<SavedService>(),
        offerId: args.offerId,
        isFromClaim: args.isFromClaim,
      ),
    );
  }
}
