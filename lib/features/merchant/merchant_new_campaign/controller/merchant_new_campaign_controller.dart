import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/helper/snackbar/api_snackbar.dart';

class MerchantNewCampaignController extends GetxController {
  static MerchantNewCampaignController get to => Get.find();
  // Text Controllers
  final campaignNameController = TextEditingController();

  final creatorCountController = TextEditingController();

  final requirementsController = TextEditingController();

  // Date Controllers
  final startDateController = TextEditingController();

  final endDateController = TextEditingController();

  // Objective
  final objectives = ["Awareness", "Traffic", "Offer", "Lead Generation"];

  final selectedObjective = "".obs;

  // Content Type
  final contentTypes = ["Video Ad", "Product Review", "Reel", "Story"];

  final selectedContentType = "".obs;

  // Influencer Category
  final categories = ["Food", "Fashion", "Technology", "Beauty", "Lifestyle"];

  final selectedCategory = "".obs;

  void selectObjective(String value) {
    selectedObjective.value = value;
  }

  void selectContentType(String value) {
    selectedContentType.value = value;
  }

  void selectCategory(String? value) {
    selectedCategory.value = value ?? "";
  }

  bool validate() {
    if (campaignNameController.text.trim().isEmpty) {
      _showValidationError("Campaign name is required");
      return false;
    }

    if (selectedObjective.value.isEmpty) {
      _showValidationError("Please select an objective");
      return false;
    }

    if (selectedContentType.value.isEmpty) {
      _showValidationError("Please select content type");
      return false;
    }

    if (selectedCategory.value.isEmpty) {
      _showValidationError("Please select influencer category");
      return false;
    }

    if (creatorCountController.text.trim().isEmpty) {
      _showValidationError("Target number of creators is required");
      return false;
    }

    final creatorCount = int.tryParse(creatorCountController.text.trim());

    if (creatorCount == null || creatorCount <= 0) {
      _showValidationError("Enter a valid creator number");
      return false;
    }

    if (startDateController.text.trim().isEmpty) {
      _showValidationError("Start date is required");
      return false;
    }

    if (endDateController.text.trim().isEmpty) {
      _showValidationError("End date is required");
      return false;
    }

    if (requirementsController.text.trim().isEmpty) {
      _showValidationError("Content requirements are required");
      return false;
    }

    return true;
  }

  void _showValidationError(String message) {
    ApiSnackbar.show(type: SnackbarType.error, message);
  }

  @override
  void onInit() {
    super.onInit();

    if (kDebugMode) {
      _loadDummyData();
    }
  }

  void _loadDummyData() {
    campaignNameController.text = "Summer Influencer Campaign";

    selectedObjective.value = "Awareness";

    selectedContentType.value = "Video Ad";

    selectedCategory.value = "Lifestyle";

    creatorCountController.text = "5";

    startDateController.text = "15 Jul 2026";

    endDateController.text = "22 Jul 2026";

    requirementsController.text = "Create 1 short video promoting our product.";
  }

  @override
  void onClose() {
    campaignNameController.dispose();

    creatorCountController.dispose();

    requirementsController.dispose();

    startDateController.dispose();

    endDateController.dispose();

    super.onClose();
  }

  void onTapNext() {
    if (!validate()) {
      return;
    }

    AppRouter.route.pushNamed(RoutePath.merchantPricingPackagesScreen);
  }
}
