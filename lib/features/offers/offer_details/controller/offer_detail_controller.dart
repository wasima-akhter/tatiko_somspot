import 'package:som_spot/helper/snackbar/api_snackbar.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../shared/response/claimed_offer_model.dart';
import '../../shared/response/offers_response.dart';
import '../../shared/service/offers_service.dart';

class OfferDetailController extends GetxController {
  final OfferService _service;
  final String offerId;
  final bool isFromClaim;

  OfferDetailController(
    this._service, {
    required this.offerId,
    this.isFromClaim = false,
  });

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

  //

  final claimStatus = ApiStatus.completed.obs;
  final claimErrorMessage = ''.obs;

  final claimedOffer = Rxn<ClaimOfferModel>();

  Future<ClaimOfferModel?> claimOffer() async {
    try {
      claimStatus.value = ApiStatus.loading;
      claimErrorMessage.value = '';

      final response = await _service.claimOffer(offerId);

      if (response.success && response.data != null) {
        claimedOffer.value = response.data;
        claimStatus.value = ApiStatus.completed;

        debugPrint("Offer Claimed Successfully => ${response.data!.code}");

        ApiSnackbar.show(response.message, type: SnackbarType.success);

        return response.data;
      }

      claimStatus.value = ApiStatus.error;
      claimErrorMessage.value = response.message;
      ApiSnackbar.show(response.message);
      return null;
    } catch (e, s) {
      claimStatus.value = ApiStatus.error;
      claimErrorMessage.value = e.toString();

      debugPrint("Claim Offer Exception => $e");
      debugPrintStack(stackTrace: s);

      return null;
    }
  }
}
