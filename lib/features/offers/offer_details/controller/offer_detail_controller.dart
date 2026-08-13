import 'package:som_spot/helper/snackbar/api_snackbar.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../customer/saved/shared/service/saved_service.dart';
import '../../shared/response/claimed_offer_model.dart';
import '../../shared/response/offers_response.dart';
import '../../shared/service/offers_service.dart';

class OfferDetailController extends GetxController {
  final OfferService _service;
  final SavedService _savedService;
  final String offerId;
  final bool isFromClaim;

  OfferDetailController(
    this._service, {
    required this.offerId,
    this.isFromClaim = false,
    required SavedService savedService,
  }) : _savedService = savedService;

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

      // Initial bookmark state from offer details
      isOfferSaved.value = response.data?.isSaved ?? false;

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

  // Toggle offer bookmark
  final isOfferSaved = false.obs;
  final saveStatus = ApiStatus.completed.obs;

  final saveErrorMessage = ''.obs;

  Future<void> toggleOfferSaved() async {
    if (saveStatus.value == ApiStatus.loading) return;

    // Optimistic UI update
    final previousValue = isOfferSaved.value;
    isOfferSaved.value = !previousValue;

    saveStatus.value = ApiStatus.loading;

    try {
      final response = await _savedService.toggleSaved(offerId: offerId);

      if (response.success) {
        final data = response.data;

        // Always trust server response
        isOfferSaved.value = data?.saved == true;

        saveStatus.value = ApiStatus.completed;

        ApiSnackbar.show(response.message, type: SnackbarType.success);
      } else {
        // Revert if API fails
        isOfferSaved.value = previousValue;

        saveErrorMessage.value = response.message;

        saveStatus.value = ApiStatus.error;

        ApiSnackbar.show(response.message);
      }
    } catch (e, s) {
      isOfferSaved.value = previousValue;

      saveStatus.value = ApiStatus.error;

      debugPrint("Toggle Offer Saved Error => $e");
      debugPrintStack(stackTrace: s);

      ApiSnackbar.show("Something went wrong");
    }
  }

  //

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
