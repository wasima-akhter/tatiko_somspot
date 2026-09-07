import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/features/offers/offers_list/controller/offer_controller.dart';
import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../../helper/snackbar/api_snackbar.dart';
import '../../../../share/base_controller/base_form_controller.dart';
import '../../../../share/widgets/dialog/custom_dialog.dart';
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

  // ============================================================
  // Validation
  // ============================================================

  bool validateOfferDetails({
    required String title,
    required String discount,
    required String startDate,
    required String endDate,
    required String description,
  }) {
    if (title.trim().isEmpty) {
      return _showError(AppStrings.offerTitleRequired.tr);
    }

    if (title.trim().length < 3) {
      return _showError(AppStrings.offerTitleTooShort.tr);
    }

    if (discount.trim().isEmpty) {
      return _showError(AppStrings.offerDiscountRequired.tr);
    }

    final discountValue = int.tryParse(discount.trim());

    if (discountValue == null) {
      return _showError(AppStrings.offerDiscountInvalid.tr);
    }

    if (discountValue <= 0 || discountValue > 100) {
      return _showError(AppStrings.offerDiscountRangeError.tr);
    }

    if (startDate.trim().isEmpty) {
      return _showError(AppStrings.startDateIsRequired.tr);
    }

    if (endDate.trim().isEmpty) {
      return _showError(AppStrings.endDateIsRequired.tr);
    }

    final parsedStartDate = _parseOfferDate(startDate);
    final parsedEndDate = _parseOfferDate(endDate);

    if (parsedStartDate == null) {
      return _showError(AppStrings.invalidStartDate.tr);
    }

    if (parsedEndDate == null) {
      return _showError(AppStrings.invalidEndDate.tr);
    }

    if (parsedEndDate.isBefore(parsedStartDate)) {
      return _showError(AppStrings.endDateMustBeAfterStartDate.tr);
    }

    if (description.trim().isEmpty) {
      return _showError(AppStrings.descriptionRequired.tr);
    }

    if (description.trim().length < 10) {
      return _showError(AppStrings.descriptionMinLength.tr);
    }

    return true;
  }

  DateTime? _parseOfferDate(String value) {
    try {
      return DateFormat('MMM d, yyyy').parseStrict(value.trim());
    } catch (_) {
      return null;
    }
  }

  bool _showError(String message) {
    ApiSnackbar.show(type: SnackbarType.error, message);

    return false;
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
    required BuildContext context,
  }) async {
    //
    // Validate offer details.
    final isValid = validateOfferDetails(
      title: title,
      discount: discount,
      description: description,
      startDate: startDate,
      endDate: endDate,
    );

    if (!isValid) {
      return;
    }

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

      await AppDialog.show(
        context: context,
        title: "Offer Submitted",
        subtitle:
            "Your offer has been created successfully and submitted for admin review. "
            "It will become active once it has been approved by the admin.",
        type: AppDialogType.success,
        confirmText: "Done",

        showDefaultButtons: true,

        subtitleColor: AppColors.black,
        dismissible: false,
        onConfirm: () {
          AppRouter.route.pop();
        },
      );

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
    } catch (e, stackrace) {
      debugPrint('error: $stackrace');
      submitFailure(AppStrings.somethingWentWrong.tr);

      AppToast.error(message: AppStrings.somethingWentWrong.tr);
    }
  }

  ///
}
