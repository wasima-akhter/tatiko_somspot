import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/toast/toast_helper.dart';
import '../../../share/base_controller/base_form_controller.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../../../utils/enum/app_enum.dart';
import '../request/help_support-request.dart';
import '../request/rate_app_request.dart';
import '../service/other_service.dart';

class OtherController extends BaseFormController {
  final OtherService _service;

  OtherController(this._service);

  static OtherController get to => Get.find();

  final formKey = GlobalKey<FormState>();

  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final List<FaqModel> faqs = const [
    FaqModel(
      question: "How do I claim a deal on SomSpot?",
      answer:
          "Go to any active offer on the Home or Saved screen, tap on the 'Claim' button. The coupon will be added to your My Claims list where you can click 'View' to present the QR code to the merchant to redeem.",
    ),
    FaqModel(
      question: "How long are deals valid?",
      answer:
          "Each deal has a specific expiry date indicated on its detail page and card. Make sure to redeem the deal before the timer or date runs out.",
    ),
    FaqModel(
      question: "Is SomSpot free to use?",
      answer:
          "Yes, SomSpot is 100% free for customers to discover nearby businesses, browse promotional discounts, and claim deals.",
    ),
    FaqModel(
      question: "Can I cancel a claimed deal?",
      answer:
          "Claimed deals will automatically expire if they are not used within their validity period. There is no need to manually cancel or remove them.",
    ),
  ];
  Future<void> submitMessage() async {
    if (!formKey.currentState!.validate()) return;

    beginSubmit();

    try {
      final result = await _service.postFeedback(
        FeedbackRequest(
          subject: subjectController.text.trim(),
          feedback: messageController.text.trim(),
        ),
      );

      if (!result.success) {
        submitFailure(result.message);
        return;
      }

      resetForm(
        formKey: formKey,
        controllers: [subjectController, messageController],
      );

      submitSuccess();

      showSuccess(AppStrings.messageSubmitted.tr);
    } catch (_) {
      submitFailure("Something went wrong.");
    }
  }

  /// TERMS & CONDITIONS
  ///
  /// // Terms & Conditions

  final Rx<ApiStatus> termsLoading = ApiStatus.completed.obs;

  void termsLoadingMethod(ApiStatus status) {
    termsLoading.value = status;
  }

  final termsDescription = "".obs;

  Future<void> getTermsConditions() async {
    termsLoadingMethod(ApiStatus.loading);
    errorMessage.value = null;

    try {
      final result = await _service.getTermsConditions();

      if (!result.success) {
        errorMessage.value = result.message;

        termsLoadingMethod(ApiStatus.error);

        return;
      }

      final data = result.data;

      if (data == null) {
        termsLoadingMethod(ApiStatus.noDataFound);

        return;
      }

      termsDescription.value = data.description;

      termsLoadingMethod(ApiStatus.completed);
    } catch (_) {
      errorMessage.value = "Something went wrong.";

      termsLoadingMethod(ApiStatus.error);
    }
  }

  ///
  // Privacy Policy

  final Rx<ApiStatus> privacyLoading = ApiStatus.completed.obs;

  void privacyLoadingMethod(ApiStatus status) {
    privacyLoading.value = status;
  }

  final privacyDescription = "".obs;

  Future<void> getPrivacyPolicy() async {
    privacyLoadingMethod(ApiStatus.loading);

    errorMessage.value = null;

    try {
      final result = await _service.getPrivacyPolicy();

      if (!result.success) {
        errorMessage.value = result.message;

        privacyLoadingMethod(ApiStatus.error);

        return;
      }

      final data = result.data;

      if (data == null) {
        privacyLoadingMethod(ApiStatus.noDataFound);

        return;
      }

      privacyDescription.value = data.description;

      privacyLoadingMethod(ApiStatus.completed);
    } catch (_) {
      errorMessage.value = "Something went wrong.";

      privacyLoadingMethod(ApiStatus.error);
    }
  }

  /// ---------------
  ///

  @override
  void onInit() {
    super.onInit();

    getTermsConditions();
    getPrivacyPolicy();
    getAboutUs();
  }

  @override
  void onClose() {
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  //
  // Rating app -->
  final RxDouble rating = 3.0.obs;

  String get ratingText {
    if (rating.value <= 1) return "Poor";
    if (rating.value <= 2) return "Fair";
    if (rating.value <= 3) return "Okay";
    if (rating.value <= 4) return "Good";

    return "Excellent";
  }

  void updateRating(double value) {
    rating.value = value;
  }

  final Rx<ApiStatus> ratingLoading = ApiStatus.completed.obs;

  void ratingLoadingMethod(ApiStatus status) {
    ratingLoading.value = status;
  }

  Future<void> submitRating({VoidCallback? onSuccess}) async {
    ratingLoadingMethod(ApiStatus.loading);

    final request = RateAppRequest(rating: rating.value.toInt());

    try {
      final result = await _service.rateApp(request);

      if (!result.success) {
        ratingLoadingMethod(ApiStatus.error);

        AppToast.error(message: result.message);

        return;
      }

      ratingLoadingMethod(ApiStatus.completed);

      AppToast.success(message: "Thank you for rating SomSpot");
      onSuccess?.call();
    } catch (_) {
      ratingLoadingMethod(ApiStatus.error);

      AppToast.error(message: "Something went wrong");
    }
  }

  // about us:
  // About Us

  final Rx<ApiStatus> aboutLoading = ApiStatus.completed.obs;

  void aboutLoadingMethod(ApiStatus status) {
    aboutLoading.value = status;
  }

  final aboutDescription = "".obs;
  Future<void> getAboutUs() async {
    aboutLoadingMethod(ApiStatus.loading);

    errorMessage.value = null;

    try {
      final result = await _service.getAboutUs();

      if (!result.success) {
        errorMessage.value = result.message;

        aboutLoadingMethod(ApiStatus.error);

        return;
      }

      final data = result.data;

      if (data == null) {
        aboutLoadingMethod(ApiStatus.noDataFound);

        return;
      }

      aboutDescription.value = data.description;

      aboutLoadingMethod(ApiStatus.completed);
    } catch (_) {
      errorMessage.value = "Something went wrong.";

      aboutLoadingMethod(ApiStatus.error);
    }
  }
}

class FaqModel {
  final String question;
  final String answer;

  const FaqModel({required this.question, required this.answer});
}
