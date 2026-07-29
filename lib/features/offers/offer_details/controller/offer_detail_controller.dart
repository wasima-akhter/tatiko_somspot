import 'package:get/get.dart';

import '../../../../utils/enum/app_enum.dart';
import '../../shared/response/offers_response.dart';
import '../../shared/service/offers_service.dart';

class OfferDetailController extends GetxController {
  final OfferService _service;
  final String offerId;

  OfferDetailController(this._service, this.offerId);

  static OfferDetailController get to => Get.find();

  final offer = Rxn<OfferModel>();

  final status = ApiStatus.completed.obs;

  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    getOfferDetails();
  }

  Future<void> getOfferDetails() async {
    status.value = ApiStatus.loading;

    final response = await _service.getOfferDetails(offerId);

    if (response.success) {
      offer.value = response.data;

      status.value = ApiStatus.completed;
    } else {
      errorMessage.value = response.message;

      status.value = ApiStatus.error;
    }
  }

  Future<void> refreshOffer() async {
    await getOfferDetails();
  }
}
