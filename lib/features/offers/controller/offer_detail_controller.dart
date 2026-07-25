import 'package:get/get.dart';

import '../../merchant/create_offer/service/create_offer_service.dart';

class OfferDetailsController extends GetxController {
  final String offerId = Get.arguments;

  final OfferService _service;

  OfferDetailsController(this._service);

  static OfferDetailsController get to => Get.find();
}
