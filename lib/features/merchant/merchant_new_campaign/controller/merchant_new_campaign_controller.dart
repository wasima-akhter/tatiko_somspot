import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/core/business/response/business-response.dart';
import 'package:som_spot/features/core/category/model/category_model.dart';
import 'package:som_spot/features/offers/shared/binding/offers_binding.dart';
import 'package:som_spot/features/offers/shared/response/offers_response.dart';
import 'package:som_spot/helper/snackbar/api_snackbar.dart';

import '../../../../helper/date_converter/date_converter.dart';
import '../../../../share/base_controller/base_form_controller.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../core/business/controller/business-controller.dart';
import '../../../core/category/controller/category_controller.dart';
import '../../../offers/offers_list/controller/offer_controller.dart';
import '../shared/request/new_campaign_request.dart';
import '../shared/service/merchant_campaign_service.dart';

class MerchantNewCampaignController extends BaseFormController {
  MerchantNewCampaignController(this._campaignService);

  static MerchantNewCampaignController get to => Get.find();

  final MerchantCampaignService _campaignService;

  // ============================================================
  // Text Controllers
  // ============================================================

  final campaignNameController = TextEditingController();

  final creatorCountController = TextEditingController();

  final requirementsController = TextEditingController();

  final startDateController = TextEditingController();

  final endDateController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  // ============================================================
  // Static Options
  // ============================================================

  final objectives = const ["Awareness", "Traffic", "Offer", "Lead Generation"];

  final contentTypes = const ["Video Ad", "Product Review", "Reel", "Story"];

  // ============================================================
  // Selected Values
  // ============================================================

  final selectedObjective = "".obs;

  final selectedContentType = "".obs;

  /// Category ID
  final selectedCategory = "".obs;

  /// Offer ID
  final selectedOfferId = "".obs;

  /// Pricing package
  final selectedPackage = Rxn<PricingModel>();

  // ============================================================
  // API Data Getters
  // ============================================================

  RxList<CategoryModel> get categories => CategoryController.to.categories;

  RxList<OfferModel> get offers => OffersController.to.paginator.items;

  BusinessModel? get business {
    final businesses = BusinessController.to.myBusinessesPaginator.items;

    if (businesses.isEmpty) {
      return null;
    }

    return businesses.first;
  }

  // ============================================================
  // Display Helpers
  // ============================================================

  String get selectedCategoryName {
    return categories
            .firstWhereOrNull((e) => e.id == selectedCategory.value)
            ?.name ??
        "";
  }

  String get selectedOfferName {
    return offers
            .firstWhereOrNull((e) => e.id == selectedOfferId.value)
            ?.title ??
        "";
  }

  String get selectedPackageName => selectedPackage.value?.title ?? "";

  String get selectedPackagePrice => selectedPackage.value?.price ?? "";

  // ============================================================
  // Selection Methods
  // ============================================================

  void selectObjective(String value) {
    selectedObjective.value = value;
  }

  void selectContentType(String value) {
    selectedContentType.value = value;
  }

  void selectCategory(String? value) {
    selectedCategory.value = value ?? "";
  }

  void selectOffer(String? value) {
    selectedOfferId.value = value ?? "";
  }

  void selectPackage(PricingModel package) {
    selectedPackage.value = package;
  }

  int get selectedVideoLength {
    return selectedPackage.value?.videoLengthSec ?? 0;
  }
  // ============================================================
  // Validation
  // ============================================================

  bool validateCampaignDetails() {
    if (campaignNameController.text.trim().isEmpty) {
      return _showError("Campaign name is required");
    }

    if (selectedObjective.value.isEmpty) {
      return _showError("Please select an objective");
    }

    if (selectedContentType.value.isEmpty) {
      return _showError("Please select content type");
    }

    if (selectedOfferId.value.isEmpty) {
      return _showError("Please select an offer");
    }

    if (selectedCategory.value.isEmpty) {
      return _showError("Please select influencer category");
    }

    final creators = int.tryParse(creatorCountController.text.trim());

    if (creators == null || creators <= 0) {
      return _showError("Enter valid creator number");
    }

    if (startDateController.text.trim().isEmpty) {
      return _showError("Start date is required");
    }

    if (endDateController.text.trim().isEmpty) {
      return _showError("End date is required");
    }

    if (requirementsController.text.trim().isEmpty) {
      return _showError("Content requirements are required");
    }

    return true;
  }

  bool validatePricing() {
    if (selectedPackage.value == null) {
      return _showError("Please select a pricing package");
    }

    return true;
  }

  bool _showError(String message) {
    ApiSnackbar.show(type: SnackbarType.error, message);

    return false;
  }

  // ============================================================
  // Navigation
  // ============================================================

  void onCampaignNext() {
    if (!validateCampaignDetails()) {
      return;
    }

    AppRouter.route.pushNamed(RoutePath.merchantPricingPackagesScreen);
  }

  void onPricingNext() {
    if (!validatePricing()) {
      return;
    }

    AppRouter.route.pushNamed(RoutePath.mrchantPreviewCampaignScreen);
  }

  Future<void> onSubmit() async {
    await createCampaign();
  }

  // ============================================================
  // Create Campaign API
  // ============================================================

  Future<void> createCampaign() async {
    if (submitLoading.value == ApiStatus.loading) {
      return;
    }

    if (business == null) {
      submitFailure("Unable to identify the associated business.");
      return;
    }

    try {
      beginSubmit();

      debugPrint(
        'startDateController: ${DateConverter().formatMdY_to_DateTime(startDateController.text)}',
      );

      final request = CreateCampaignRequest(
        business: business!.id,

        name: campaignNameController.text.trim(),

        about: requirementsController.text.trim(),

        objective: selectedObjective.value.toLowerCase(),

        contentType: selectedContentType.value.toLowerCase(),

        influencerCategory: selectedCategory.value,

        targetCreators: int.parse(creatorCountController.text.trim()),

        videoLengthSec: selectedVideoLength,

        startDate: DateConverter().formatMdY_to_DateTime(
          startDateController.text,
        ),

        endDate: DateConverter().formatMdY_to_DateTime(endDateController.text),

        contentRequirements: requirementsController.text.trim(),

        offer: selectedOfferId.value,
      );

      final response = await _campaignService.createNewCampaign(request);

      if (!response.success) {
        submitFailure(response.message);

        ApiSnackbar.show(type: SnackbarType.error, response.message);

        return;
      }

      submitSuccess();

      showSuccess("Campaign created successfully");

      AppRouter.route.goNamed(RoutePath.merchantCampaignsScreen);
    } catch (e, stack) {
      submitFailure(e.toString());
      debugPrint(stack.toString());

      ApiSnackbar.show(type: SnackbarType.error, "Something went wrong");
    }
  }
  // ============================================================
  // Lifecycle
  // ============================================================

  @override
  void onInit() async {
    super.onInit();

    if (CategoryController.to.categories.isEmpty) {
      CategoryController.to.fetchCategories();
    }
    if (BusinessController.to.myBusinessesPaginator.items.isEmpty) {
      BusinessController.to.refreshBusinesses();
    }

    if (!Get.isRegistered<OffersController>()) {
      OffersBinding().dependencies();
    }

    await OffersController.to.loadOffers();

    debugPrint(
      '  OffersController.to.paginator.items.length ${OffersController.to.paginator.items.length}',
    );

    if (kDebugMode) {
      loadInitialData();

      _loadDummyData();
    }
  }

  final pageStatus = ApiStatus.loading.obs;
  Future<void> loadInitialData() async {
    try {
      pageStatus.value = ApiStatus.loading;

      if (CategoryController.to.categories.isEmpty) {
        await CategoryController.to.fetchCategories();
      }

      if (BusinessController.to.myBusinessesPaginator.items.isEmpty) {
        await BusinessController.to.refreshBusinesses();
      }

      if (!Get.isRegistered<OffersController>()) {
        OffersBinding().dependencies();
      }

      await OffersController.to.loadOffers();

      pageStatus.value = ApiStatus.completed;
    } catch (e) {
      pageStatus.value = ApiStatus.error;
      errorMessage.value = e.toString();
    }
  }

  void _loadDummyData() {
    campaignNameController.text = "Summer Influencer Campaign";
    requirementsController.text = "Increase brand awareness and drive sales.";
    creatorCountController.text = "5";
    startDateController.text = DateFormat("MMM d, yyyy").format(DateTime.now());

    endDateController.text = DateFormat(
      "MMM d, yyyy",
    ).format(DateTime.now().add(const Duration(days: 30)));
    requirementsController.text = "Create 1 short video promoting our product.";
    selectedObjective.value = "Awareness";
    selectedContentType.value = "Reel";
  }

  void clearCampaignForm() {
    resetForm(
      formKey: formKey,
      controllers: [
        campaignNameController,
        creatorCountController,
        requirementsController,
        startDateController,
        endDateController,
      ],
      extraReset: [
        () => selectedObjective.value = "",
        () => selectedContentType.value = "",
        () => selectedCategory.value = "",
        () => selectedOfferId.value = "",
        () => selectedPackage.value = null,
      ],
    );
  }

  @override
  void onClose() {
    campaignNameController.dispose();

    requirementsController.dispose();

    creatorCountController.dispose();

    requirementsController.dispose();

    startDateController.dispose();

    endDateController.dispose();

    super.onClose();
  }

  //
  final packages = [
    PricingModel(
      title: "20 Seconds Video",
      subtitle: "Short Video • 20s",
      description: "A little more room to show the offer in action.",
      price: "\$5",
      videoLengthSec: 20,
    ),

    PricingModel(
      title: "30 Seconds Video",
      subtitle: "Standard Video • 30s",
      description: "The most popular format for local campaigns.",
      price: "\$7",
      videoLengthSec: 30,
    ),

    PricingModel(
      title: "45 Seconds Video",
      subtitle: "Extended Video • 45s",
      description: "Great for storytelling and product walkthroughs.",
      price: "\$10",
      videoLengthSec: 45,
    ),

    PricingModel(
      title: "60 Seconds Video",
      subtitle: "Long Video • 60s",
      description: "Full narrative, maximum detail and reach.",
      price: "\$15",
      videoLengthSec: 60,
    ),
  ];
}

class PricingModel {
  final String title;
  final String subtitle;
  final String description;
  final String price;

  final int videoLengthSec;

  PricingModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.videoLengthSec,
  });
}
