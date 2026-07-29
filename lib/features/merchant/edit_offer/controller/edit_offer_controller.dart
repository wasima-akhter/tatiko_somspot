import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/controller/screen_export.dart';

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

  void selectBusinessId(String businessId) {
    selectedBusinessId.value = businessId;
    businessError.value = null;
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        imagePath.value = image.path;
      }
    } catch (e) {
      AppToast.error(message: "Failed to pick image");
    }
  }

  void clearImage() {
    imagePath.value = '';
  }

  Future<void> updateOffer({
    required String offerId,
    required String title,
    required String discount,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    businessError.value = null;

    if (selectedBusinessId.value == null) {
      businessError.value = "Unable to identify the associated business.";
      AppToast.error(
        message:
            "Unable to identify the associated business. Please try again.",
      );
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (startDate.isEmpty || endDate.isEmpty) {
      AppToast.error(message: "Please select offer dates");
      return;
    }

    if (imagePath.value.isEmpty) {
      AppToast.error(message: "Please select an image");
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

      showSuccess("Offer updated successfully");

      resetForm(
        formKey: formKey,
        controllers: [],
        extraReset: [clearImage, () {}],
      );

      // await OfferDetailController.to.getOfferDetails();
      AppRouter.route.pop(true);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);

      submitFailure(e.toString());
      AppToast.error(message: e.toString());
    }
  }
}
