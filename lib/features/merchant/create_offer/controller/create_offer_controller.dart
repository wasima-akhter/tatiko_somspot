import 'package:image_picker/image_picker.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/features/offers/offers_list/controller/offer_controller.dart';
import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../../../share/base_controller/base_form_controller.dart';
import '../../../core/business/controller/business-controller.dart';
import '../../../offers/shared/request/offers_request.dart';
import '../../../offers/shared/service/offers_service.dart';

class CreateOfferController extends BaseFormController {
  final OfferService _service;

  CreateOfferController(this._service);

  static CreateOfferController get to => Get.find();

  final formKey = GlobalKey<FormState>();

  final RxnString businessError = RxnString();
  final businessId = "".obs;

  final ImagePicker _picker = ImagePicker();
  RxString imagePath = ''.obs;

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath.value = image.path;
      }
    } catch (e) {
      AppToast.error(message: AppStrings.failedToPickImage.tr);
    }
  }

  void clearImage() {
    imagePath.value = '';
  }

  // -----------------------------------------------------------------------------
  // Business Logic
  // -----------------------------------------------------------------------------

  Future<bool> _resolveBusiness() async {
    debugPrint('business resolve method');
    businessError.value = null;

    await BusinessController.to.myBusinessesPaginator.refresh();

    final businesses = BusinessController.to.myBusinessesPaginator.items;

    if (businesses.isNotEmpty) {
      businessId.value = businesses.first.id;
    }

    return _validateBusiness();
  }

  bool _validateBusiness() {
    if (businessId.value.isNotEmpty) {
      return true;
    }

    businessError.value = AppStrings.unableToIdentifyBusiness.tr;

    AppToast.error(message: AppStrings.unableToIdentifyBusinessTryAgain.tr);

    return false;
  }

  // -----------------------------------------------------------------------------
  // Form Validation
  // -----------------------------------------------------------------------------

  bool _validateCreateOffer({
    required String startDate,
    required String endDate,
  }) {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    if (startDate.isEmpty || endDate.isEmpty) {
      AppToast.error(message: AppStrings.pleaseSelectOfferDates.tr);
      return false;
    }

    if (imagePath.isEmpty) {
      AppToast.error(message: AppStrings.pleaseSelectAnImage.tr);
      return false;
    }

    return true;
  }

  // -----------------------------------------------------------------------------
  // Create Offer
  // -----------------------------------------------------------------------------

  Future<void> createOffer({
    required String title,
    required String discount,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    // Validate offer form data.
    final isValid = _validateCreateOffer(
      startDate: startDate,
      endDate: endDate,
    );

    if (!isValid) {
      return;
    }

    //
    // Resolve and validate the associated business.
    final businessResolved = await _resolveBusiness();

    if (!businessResolved) {
      return;
    }

    beginSubmit();

    try {
      final request = CreateOfferRequest(
        business: businessId.value,
        title: title.trim(),
        discountLabel: "${discount.trim()}%",
        description: description.trim(),
        terms: "Dine-in only. One claim per customer.",
        startAt: DateConverter().formatMdY_to_DateTime(startDate),
        endAt: DateConverter().formatMdY_to_DateTime(endDate),
      );

      final result = await _service.createOffer(request);

      if (!result.success) {
        submitFailure(result.message);

        AppToast.error(message: result.message);

        return;
      }

      submitSuccess();

      showSuccess(AppStrings.offerCreatedSuccessfully.tr);

      resetForm(
        formKey: formKey,
        controllers: [],
        extraReset: [clearImage, () {}],
      );

      // Update offer list.
      await OffersController.to.refreshOffers();

      AppRouter.route.goNamed(RoutePath.navigationPages);

      NavigationControllerMain.to.goToTabOffers();
    } catch (e) {
      submitFailure(AppStrings.somethingWentWrong.tr);

      AppToast.error(message: AppStrings.somethingWentWrong.tr);
    }
  }

  ///
}
