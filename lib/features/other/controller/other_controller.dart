import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/toast/toast_helper.dart';
import '../../../share/base_controller/base_form_controller.dart';
import '../../../share/widgets/paginator/paginator.dart';
import '../../../utils/app_strings/app_strings.dart';
import '../../../utils/enum/app_enum.dart';
import '../model/faq_model.dart';
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
      errorMessage.value = AppStrings.somethingWentWrong.tr;

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
      errorMessage.value = AppStrings.somethingWentWrong.tr;

      privacyLoadingMethod(ApiStatus.error);
    }
  }

  /// ---------------
  ///

  // ---------------------------------------------------------------------------
  // FAQ
  // ---------------------------------------------------------------------------

  late final Paginator<FaqModel> faqPaginator;

  final faqScrollController = ScrollController();

  final Rx<ApiStatus> faqStatus = ApiStatus.completed.obs;

  String? faqError;

  void _initFaqPaginator() {
    faqPaginator = Paginator<FaqModel>(
      fetchPage: (page, limit) async {
        final response = await _service.getFaq(page: page, limit: limit);

        if (!response.success || response.data == null) {
          faqStatus.value = ApiStatus.error;
          faqError = response.message;

          throw Exception(response.message);
        }

        final result = response.data!;

        faqStatus.value = result.data.isEmpty
            ? ApiStatus.noDataFound
            : ApiStatus.completed;

        return result;
      },
    );
  }

  Future<void> loadFaq() async {
    await faqPaginator.loadInitial();
  }

  Future<void> loadMoreFaq() async {
    await faqPaginator.loadMore();
  }

  Future<void> refreshFaq() async {
    await faqPaginator.refresh();
  }

  void _onFaqScroll() {
    if (!faqScrollController.hasClients) return;

    final position = faqScrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      loadMoreFaq();
    }
  }

  // Convenient getter for UI
  List<FaqModel> get faqs => faqPaginator.items;

  // ---------------------------------------------------------------------------
  // INIT
  // ---------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    _initFaqPaginator();

    faqScrollController.addListener(_onFaqScroll);

    getTermsConditions();
    getPrivacyPolicy();
    getAboutUs();

    // Load first FAQ page.
    loadFaq();
  }

  @override
  void onClose() {
    faqScrollController.removeListener(_onFaqScroll);
    faqScrollController.dispose();

    faqPaginator.dispose();

    subjectController.dispose();
    messageController.dispose();

    super.onClose();
  }

  //
  // Rating app -->
  final RxDouble rating = 3.0.obs;

  String get ratingText {
    if (rating.value <= 1) return AppStrings.poor.tr;
    if (rating.value <= 2) return AppStrings.fair.tr;
    if (rating.value <= 3) return AppStrings.okay.tr;
    if (rating.value <= 4) return AppStrings.good.tr;

    return AppStrings.excellent.tr;
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

      AppToast.success(message: AppStrings.thankYouForRatingSomSpot.tr);
    } catch (_) {
      ratingLoadingMethod(ApiStatus.error);

      AppToast.error(message: AppStrings.somethingWentWrong.tr);
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
      errorMessage.value = AppStrings.somethingWentWrong.tr;

      aboutLoadingMethod(ApiStatus.error);
    }
  }
}
