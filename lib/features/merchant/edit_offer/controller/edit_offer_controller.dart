import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../../share/base_controller/base_form_controller.dart';
import '../../../../utils/multipart/multipart_body.dart';
import '../../../offers/shared/request/offers_request.dart';
import '../../../offers/shared/service/offers_service.dart';

class EditOfferController extends BaseFormController {
  final OfferService _service;

  EditOfferController(this._service);

  static EditOfferController get to => Get.find();

  final formKey = GlobalKey<FormState>();

  final RxnString selectedBusinessId = RxnString();
  final RxnString businessError = RxnString();

  final ImagePicker _picker = ImagePicker();

  final RxString imagePath = ''.obs;

  // ---------------------------------------------------------------------------
  // Business Logic
  // ---------------------------------------------------------------------------

  void selectBusinessId(String businessId) {
    selectedBusinessId.value = businessId;
    businessError.value = null;
  }

  bool _validateBusiness() {
    if (selectedBusinessId.value != null &&
        selectedBusinessId.value!.isNotEmpty) {
      return true;
    }

    businessError.value = AppStrings.unableToIdentifyBusiness.tr;

    AppToast.error(message: AppStrings.unableToIdentifyBusinessTryAgain.tr);

    return false;
  }

  // ---------------------------------------------------------------------------
  // Image Logic
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // Form Validation
  // ---------------------------------------------------------------------------

  bool _validateUpdateOffer({
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

    if (imagePath.value.isEmpty) {
      AppToast.error(message: AppStrings.pleaseSelectAnImage.tr);
      return false;
    }

    return true;
  }

  // ---------------------------------------------------------------------------
  // Update Offer
  // ---------------------------------------------------------------------------

  Future<void> updateOffer({
    required String offerId,
    required String title,
    required String discount,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    // Validate associated business.
    if (!_validateBusiness()) {
      return;
    }

    // Validate offer form data.
    final isValid = _validateUpdateOffer(
      startDate: startDate,
      endDate: endDate,
    );

    if (!isValid) {
      return;
    }

    beginSubmit();

    final files = <MultipartBody>[];

    if (imagePath.value.isNotEmpty) {
      files.add(MultipartBody(fieldKey: "logo", file: File(imagePath.value)));
    }

    try {
      final request = UpdateOfferRequest(
        offerId: offerId,
        business: selectedBusinessId.value!,
        title: title.trim(),
        discountLabel: "${discount.trim()}%",
        description: description.trim(),
        terms: "Dine-in only. One claim per customer.",
        startAt: DateConverter().formatMdY_to_DateTime(startDate),
        endAt: DateConverter().formatMdY_to_DateTime(endDate),
      );

      final result = await _service.updateOffer(request: request, files: files);

      if (!result.success) {
        submitFailure(result.message);

        AppToast.error(message: result.message);

        return;
      }

      submitSuccess();

      showSuccess(AppStrings.offerUpdatedSuccessfully.tr);

      resetForm(
        formKey: formKey,
        controllers: [],
        extraReset: [clearImage, () {}],
      );

      AppRouter.route.pop(true);
    } catch (e, s) {
      print(e.toString());
      debugPrintStack(stackTrace: s);

      submitFailure(AppStrings.somethingWentWrong.tr);

      AppToast.error(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
