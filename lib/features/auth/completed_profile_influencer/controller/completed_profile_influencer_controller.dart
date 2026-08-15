import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/router/route_path.dart';
import '../../../../core/router/routes.dart';
import '../../../../helper/toast/toast_helper.dart';
import '../../../core/category/controller/category_controller.dart';
import '../../../core/category/model/category_model.dart';
import '../../../core/location/controller/business_location_controller.dart';
import '../model/influencer_complete_profile_request.dart';
import '../model/influencer_info_profile_request.dart';
import '../service/influencer_complete_profile_service.dart';

class CompletedProfileInfluencerController extends GetxController {
  final InfluencerCompleteProfileService _service;

  CompletedProfileInfluencerController(this._service);

  static CompletedProfileInfluencerController get to => Get.find();

  // ---------------------------------------------------------------------------
  // Basic Profile
  // ---------------------------------------------------------------------------

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  // ---------------------------------------------------------------------------
  // Creator Profile
  // ---------------------------------------------------------------------------

  final bioController = TextEditingController();

  final followerCountController = TextEditingController();

  final tiktokController = TextEditingController();

  final instagramController = TextEditingController();

  final facebookController = TextEditingController();

  // Selected Influencer Category ID
  final selectedInfluencerCategoryId = "".obs;

  // API Categories
  RxList<CategoryModel> get influencerCategories =>
      CategoryController.to.categoryPaginator.items;

  // Selected category name (for display)
  String get selectedInfluencerCategoryName {
    return influencerCategories
            .firstWhereOrNull((e) => e.id == selectedInfluencerCategoryId.value)
            ?.name ??
        "";
  }

  void selectInfluencerCategory(String? id) {
    selectedInfluencerCategoryId.value = id ?? "";
  }

  // ---------------------------------------------------------------------------
  // Location
  // ---------------------------------------------------------------------------

  BusinessLocationController get location => BusinessLocationController.to;

  // ---------------------------------------------------------------------------
  // Profile Image
  // ---------------------------------------------------------------------------

  final profileImagePath = Rx<String?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickProfileImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 90,
    );

    if (picked != null) {
      profileImagePath.value = picked.path;
    }
  }

  // ---------------------------------------------------------------------------
  // Loading
  // ---------------------------------------------------------------------------

  final isLoading = false.obs;

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    location.reset(initialLatLng: const LatLng(23.8103, 90.4125));

    if (CategoryController.to.categories.isEmpty) {
      CategoryController.to.loadInitialCategories();
    }
  }

  // ---------------------------------------------------------------------------
  // Validation
  // ---------------------------------------------------------------------------

  bool validateBasicProfile() {
    if (nameController.text.trim().isEmpty) {
      AppToast.error(message: "Please enter your name");
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      AppToast.error(message: "Please enter your phone number");
      return false;
    }

    if (profileImagePath.value == null) {
      AppToast.error(message: "Please upload your profile photo");
      return false;
    }

    if (location.addressController.text.trim().isEmpty) {
      AppToast.error(message: "Please select your location");
      return false;
    }

    return true;
  }

  bool validateCreatorProfile() {
    if (selectedInfluencerCategoryId.value.isEmpty) {
      AppToast.error(message: "Please select influencer type");
      return false;
    }

    if (bioController.text.trim().isEmpty) {
      AppToast.error(message: "Please enter your bio");
      return false;
    }

    if (followerCountController.text.trim().isEmpty) {
      AppToast.error(message: "Please enter follower count");
      return false;
    }

    return true;
  }
  // ---------------------------------------------------------------------------
  // API - Step 1 Basic Profile
  // ---------------------------------------------------------------------------

  Future<void> completeBasicProfile() async {
    if (!validateBasicProfile()) return;

    try {
      isLoading.value = true;

      final result = await _service.completeProfile(
        InfluencerCompleteProfileRequest(
          name: nameController.text.trim(),

          address: location.addressController.text.trim(),

          phoneNumber: phoneController.text.trim(),

          profileImage: File(profileImagePath.value!),
        ),
      );

      if (!result.success) {
        AppToast.error(message: result.message);
        return;
      }

      AppToast.success(message: result.message);

      AppRouter.route.pushNamed(RoutePath.influencerInfoComplete);
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // API - Step 2 Creator Profile
  // ---------------------------------------------------------------------------

  Future<void> completeCreatorProfile() async {
    if (!validateCreatorProfile()) return;

    try {
      isLoading.value = true;

      final result = await _service.completeCreatorProfile(
        InfluencerInfoProfileRequest(
          category: selectedInfluencerCategoryId.value,

          bio: bioController.text.trim(),

          followerCount: int.parse(followerCountController.text.trim()),

          socials: [
            if (tiktokController.text.trim().isNotEmpty)
              CreatorSocialRequest(
                platform: "tiktok",
                handle: tiktokController.text.trim(),
                url:
                    "https://tiktok.com/${tiktokController.text.trim().replaceFirst('@', '')}",
              ),

            if (instagramController.text.trim().isNotEmpty)
              CreatorSocialRequest(
                platform: "instagram",
                handle: instagramController.text.trim(),
              ),

            if (facebookController.text.trim().isNotEmpty)
              CreatorSocialRequest(
                platform: "facebook",
                handle: facebookController.text.trim(),
              ),
          ],
        ),
      );

      if (!result.success) {
        AppToast.error(message: result.message);
        return;
      }

      AppToast.success(message: result.message);

      AppRouter.route.goNamed(RoutePath.navigationPages);
    } finally {
      isLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // Dispose
  // ---------------------------------------------------------------------------

  @override
  void onClose() {
    nameController.dispose();

    phoneController.dispose();

    bioController.dispose();

    followerCountController.dispose();

    tiktokController.dispose();

    instagramController.dispose();

    facebookController.dispose();

    super.onClose();
  }
}
