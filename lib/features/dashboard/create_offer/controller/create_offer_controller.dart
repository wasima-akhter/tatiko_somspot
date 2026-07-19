import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';

import '../../../../share/base_controller/base_form_controller.dart';
import '../../../core/business/response/business-response.dart';
import '../request/create_offer_request.dart';
import '../service/create_offer_service.dart';

class CreateOfferController extends BaseFormController {
  final OfferService _service;

  CreateOfferController(this._service);

  static CreateOfferController get to => Get.find();

  final formKey = GlobalKey<FormState>();

  final Rxn<BusinessModel> selectedBusiness = Rxn<BusinessModel>();
  final RxnString businessError = RxnString();

  void selectBusiness(BusinessModel business) {
    selectedBusiness.value = business;
    businessError.value = null;
  }

  final ImagePicker _picker = ImagePicker();
  RxString imagePath = ''.obs;

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagePath.value = image.path;
      }
    } catch (e) {
      AppToast.error(message: 'Failed to pick image');
    }
  }

  void clearImage() {
    imagePath.value = '';
  }

  Future<void> createOffer({
    required String title,
    required String discount,
    required String description,
    required String startDate,
    required String endDate,
  }) async {
    businessError.value = null;

    if (selectedBusiness.value == null) {
      businessError.value = "Please select a business";
      AppToast.error(message: "Please select a business");
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (startDate.isEmpty || endDate.isEmpty) {
      AppToast.error(message: "Please select offer dates");
      return;
    }
    if (imagePath.isEmpty) {
      AppToast.error(message: "Please select an image");
      return;
    }

    beginSubmit();

    try {
      final request = CreateOfferRequest(
        business: selectedBusiness.value!.id,

        title: title.trim(),

        discountLabel: "${discount.trim()}%",

        description: description.trim(),

        terms: "Dine-in only. One claim per customer.",

        startAt: DateConverter().formatDateForApi(startDate),

        endAt: DateConverter().formatDateForApi(endDate),
      );

      final result = await _service.createOffer(request);

      if (!result.success) {
        submitFailure(result.message);

        AppToast.error(message: result.message);

        return;
      }

      submitSuccess();

      showSuccess("Offer created successfully");

      resetForm(
        formKey: formKey,
        controllers: [],
        extraReset: [
          clearImage,
          () {
            selectedBusiness.value = null;
          },
        ],
      );
    } catch (e) {
      submitFailure("Something went wrong");

      AppToast.error(message: "Something went wrong");
    }
  }

  ///
}
