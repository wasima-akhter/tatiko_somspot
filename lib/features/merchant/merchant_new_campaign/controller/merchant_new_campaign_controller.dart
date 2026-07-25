import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MerchantNewCampaignController extends GetxController {
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
  final categories = [
    "Food",
    "Fashion",
    "Technology",
    "Beauty",
    "Lifestyle",
    "Food",
    "Fashion",
    "Technology",
    "Beauty",
    "Lifestyle",
  ];

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
      return false;
    }

    if (selectedObjective.isEmpty) {
      return false;
    }

    if (selectedContentType.isEmpty) {
      return false;
    }

    return true;
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
}
