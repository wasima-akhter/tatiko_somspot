import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/core/business/response/business-response.dart';
import 'package:som_spot/features/core/category/model/category_model.dart';
import 'package:som_spot/features/merchant/merchant_campaigns/controller/merchant_campaigns_controller.dart';
import 'package:som_spot/features/offers/shared/binding/offers_binding.dart';
import 'package:som_spot/features/offers/shared/response/offers_response.dart';
import 'package:som_spot/helper/snackbar/api_snackbar.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../helper/date_converter/date_converter.dart';
import '../../../../share/base_controller/base_form_controller.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../../core/business/controller/business-controller.dart';
import '../../../core/category/binding/category_binding_helper.dart';
import '../../../offers/offers_list/controller/offer_controller.dart';
import '../shared/helper/campaign_helper.dart';
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

  final objectives = CampaignObjective.values;

  final contentTypes = CampaignContentType.values;

  // ============================================================
  // Selected Values
  // ============================================================

  final selectedObjective = Rxn<CampaignObjective>();

  final selectedContentType = Rxn<CampaignContentType>();

  /// Category ID
  final selectedCategory = "".obs;

  /// Offer ID
  final selectedOfferId = "".obs;

  /// Pricing package
  final selectedPackage = Rxn<PricingModel>();

  // ============================================================
  // API Data Getters
  // ============================================================

  RxList<CategoryModel> get categories =>
      categoryController.categoryPaginator.items;

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

  void selectObjective(CampaignObjective value) {
    selectedObjective.value = value;
  }

  void selectContentType(CampaignContentType value) {
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
    print(
      ' selectedContentType.value?.apiValue  ${selectedContentType.value?.apiValue ?? ''}',
    );
    if (campaignNameController.text.trim().isEmpty) {
      return _showError(AppStrings.campaignNameIsRequired.tr);
    }

    if (selectedObjective.value == null) {
      return _showError(AppStrings.pleaseSelectAnObjective.tr);
    }

    if (selectedContentType.value == null) {
      return _showError(AppStrings.pleaseSelectContentType.tr);
    }
    //

    final selectedOffer = offers.firstWhereOrNull(
      (offer) => offer.id == selectedOfferId.value,
    );

    if (selectedOffer == null) {
      return _showError(AppStrings.pleaseSelectAnOffer.tr);
    }

    final campaignEndDate = DateFormat(
      "MMM d, yyyy",
    ).parse(endDateController.text.trim());

    final offerEndDate = selectedOffer.endAt;

    final campaignEndDay = DateTime(
      campaignEndDate.year,
      campaignEndDate.month,
      campaignEndDate.day,
    );

    final offerEndDay = DateTime(
      offerEndDate.year,
      offerEndDate.month,
      offerEndDate.day,
    );

    if (campaignEndDay.isAfter(offerEndDay)) {
      final offerEndDateText = DateConverter.formatDate(
        dateTime: selectedOffer.endAt,
        format: 'MMM d, yyyy',
      );

      return _showError(
        AppStrings.campaignEndDateAfterOfferEndDate.trParams({
          'date': offerEndDateText,
        }),
      );
    }
    //

    if (selectedOfferId.value.isEmpty) {
      return _showError(AppStrings.pleaseSelectAnOffer.tr);
    }

    if (selectedCategory.value.isEmpty) {
      return _showError(AppStrings.pleaseSelectInfluencerCategory.tr);
    }

    final creators = int.tryParse(creatorCountController.text.trim());

    if (creators == null || creators <= 0) {
      return _showError(AppStrings.enterValidCreatorNumber.tr);
    }

    if (startDateController.text.trim().isEmpty) {
      return _showError(AppStrings.startDateIsRequired.tr);
    }

    if (endDateController.text.trim().isEmpty) {
      return _showError(AppStrings.endDateIsRequired.tr);
    }

    if (requirementsController.text.trim().isEmpty) {
      return _showError(AppStrings.contentRequirementsAreRequired.tr);
    }

    return true;
  }

  bool validatePricing() {
    if (selectedPackage.value == null) {
      return _showError(AppStrings.pleaseSelectPricingPackage.tr);
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
      submitFailure(AppStrings.unableToIdentifyAssociatedBusiness.tr);

      return;
    }

    try {
      beginSubmit();

      print(
        'startDateController: ${DateConverter().formatMdY_to_DateTime(startDateController.text)}',
      );
      print(
        ' selectedContentType.value?.apiValue ?? '
        ',: ${selectedContentType.value?.apiValue ?? ''}',
      );

      final request = CreateCampaignRequest(
        business: business!.id,

        name: campaignNameController.text.trim(),

        about: requirementsController.text.trim(),

        objective: selectedObjective.value?.apiValue ?? '',

        contentType: selectedContentType.value?.apiValue ?? '',

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

      showSuccess(AppStrings.campaignCreatedSuccessfully.tr);

      clearCampaignForm();

      await MerchantCampaignsController.to.refreshCampaigns();

      AppRouter.route.goNamed(RoutePath.merchantCampaignsScreen);
    } catch (e, stack) {
      submitFailure(e.toString());
      print(stack.toString());

      ApiSnackbar.show(
        type: SnackbarType.error,
        AppStrings.somethingWentWrong.tr,
      );
    }
  }
  // ============================================================
  // Lifecycle
  // ============================================================

  final categoryController = CategoryBindings.campaignController;

  /*
  @override
  void onInit() async {
    super.onInit();

    // if (CategoryController.to.categories.isEmpty) {
    categoryController.loadInitialCategories();
    // }
    if (BusinessController.to.myBusinessesPaginator.items.isEmpty) {
      BusinessController.to.refreshBusinesses();
    }

    if (!Get.isRegistered<OffersController>()) {
      OffersBinding().dependencies();
    }

    await OffersController.to.loadOffers();

    print(
      '  OffersController.to.paginator.items.length ${OffersController.to.paginator.items.length}',
    );

    if (kDebugMode) {
      loadInitialData();

      _loadDummyData();
    }
  }

  final pageStatus = ApiStatus.completed.obs;
  Future<void> loadInitialData() async {
    try {
      pageStatus.value = ApiStatus.loading;

      if (categoryController.categories.isEmpty) {
        await categoryController.loadInitialCategories();
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
*/

  @override
  void onInit() async {
    super.onInit();

    await loadInitialData();

    if (kDebugMode) {
      _loadDummyData();
    }
  }

  final pageStatus = ApiStatus.completed.obs;

  Future<void> loadInitialData() async {
    pageStatus.value = ApiStatus.loading;

    // Fetch each dependency independently.
    await Future.wait([_loadCategories(), _loadBusinesses(), _loadOffers()]);

    // Never block the form because one of the supporting
    // lists failed to load.
    pageStatus.value = ApiStatus.completed;
  }

  Future<void> _loadCategories() async {
    try {
      await categoryController.loadInitialCategories();

      print(
        '📂 [MerchantNewCampaign] Categories loaded: '
        '${categoryController.categories.length}',
      );
    } catch (e, stack) {
      print('❌ [MerchantNewCampaign] Failed to load categories: $e');
      print(stack.toString());
    }
  }

  Future<void> _loadBusinesses() async {
    try {
      if (BusinessController.to.myBusinessesPaginator.items.isEmpty) {
        await BusinessController.to.refreshBusinesses();
      }

      print(
        '🏢 [MerchantNewCampaign] Businesses loaded: '
        '${BusinessController.to.myBusinessesPaginator.items.length}',
      );
    } catch (e, stack) {
      print('❌ [MerchantNewCampaign] Failed to load businesses: $e');
      print(stack.toString());
    }
  }

  Future<void> _loadOffers() async {
    try {
      if (!Get.isRegistered<OffersController>()) {
        OffersBinding().dependencies();
      }

      await OffersController.to.loadOffers();

      print(
        '🎁 [MerchantNewCampaign] Offers loaded: '
        '${OffersController.to.paginator.items.length}',
      );
    } catch (e, stack) {
      print('❌ [MerchantNewCampaign] Failed to load offers: $e');
      print(stack.toString());
    }
  }

  void _loadDummyData() {
    campaignNameController.text = "Summer Influencer Campaign";
    requirementsController.text = "Increase brand awareness and drive sales.";
    creatorCountController.text = "1";
    startDateController.text = DateFormat("MMM d, yyyy").format(DateTime.now());

    endDateController.text = DateFormat(
      "MMM d, yyyy",
    ).format(DateTime.now().add(const Duration(days: 30)));
    requirementsController.text = "Create 1 short video promoting our product.";
    selectedObjective.value = null;
    selectedContentType.value = CampaignContentType.reel;
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
        () => selectedObjective.value = null,
        () => selectedContentType.value = null,
        () => selectedCategory.value = "",
        () => selectedOfferId.value = "",
        () => selectedPackage.value = null,
      ],
    );

    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void onClose() {
    campaignNameController.dispose();

    requirementsController.dispose();

    creatorCountController.dispose();

    startDateController.dispose();

    endDateController.dispose();

    super.onClose();
  }

  //
  final packages = [
    PricingModel(
      title: AppStrings.shortVideo.trParams({'seconds': '20'}),
      subtitle: AppStrings.shortVideo.trParams({'seconds': '20'}),
      description: AppStrings.littleMoreRoomToShowOffer.tr,
      price: '\$5',
      videoLengthSec: 20,
    ),

    PricingModel(
      title: AppStrings.standardVideo.trParams({'seconds': '30'}),
      subtitle: AppStrings.standardVideo.trParams({'seconds': '30'}),
      description: AppStrings.mostPopularFormatForLocalCampaigns.tr,
      price: '\$7',
      videoLengthSec: 30,
    ),

    PricingModel(
      title: AppStrings.extendedVideo.trParams({'seconds': '45'}),
      subtitle: AppStrings.extendedVideo.trParams({'seconds': '45'}),
      description: AppStrings.greatForStorytelling.tr,
      price: '\$10',
      videoLengthSec: 45,
    ),

    PricingModel(
      title: AppStrings.longVideo.trParams({'seconds': '60'}),
      subtitle: AppStrings.longVideo.trParams({'seconds': '60'}),
      description: AppStrings.fullNarrativeMaximumDetail.tr,
      price: '\$15',
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
