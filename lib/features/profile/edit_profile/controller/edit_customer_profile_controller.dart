import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:som_spot/features/profile/main_profile/controller/profile_controller.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';

import '../../../../core/router/routes.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../core/location/controller/business_location_controller.dart';
import '../../request/edit_profile_request.dart';
import '../../service/profile_service.dart';

class EditCustomerProfileController extends GetxController {
  final ProfileService _service;

  EditCustomerProfileController(this._service);

  static EditCustomerProfileController get to => Get.find();

  final profileController = ProfileScreenController.to;

  // ---------------------------------------------------------------------------
  // Controllers
  // ---------------------------------------------------------------------------

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  // ---------------------------------------------------------------------------
  // Image
  // ---------------------------------------------------------------------------

  final selectedImage = RxnString();

  final ImagePicker _picker = ImagePicker();

  // ---------------------------------------------------------------------------
  // Loading
  // ---------------------------------------------------------------------------

  final isUpdateLoading = false.obs;
  final isProfileLoading = false.obs;

  // ---------------------------------------------------------------------------
  // Image Picker
  // ---------------------------------------------------------------------------

  Future<void> pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      selectedImage.value = image.path;
    }
  }

  // ---------------------------------------------------------------------------
  // Update Profile
  // ---------------------------------------------------------------------------

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      isUpdateLoading.value = true;

      final location = BusinessLocationController.to;

      // Validate location
      if (location.addressController.text.trim().isEmpty) {
        AppToast.error(message: AppStrings.addressIsRequired.tr);
        return;
      }

      final result = await _service.editProfile(
        EditProfileRequest(
          name: name.trim(),
          phone: phone.trim(),

          // Location
          address: location.addressController.text.trim(),
          lat: location.selectedLatLng.value.latitude,
          lng: location.selectedLatLng.value.longitude,

          // Image
          profileImage: selectedImage.value == null
              ? null
              : File(selectedImage.value!),
        ),
      );

      if (!result.success || result.data == null) {
        AppToast.error(message: result.message);
        return;
      }

      final profile = result.data!;

      await profileController.getProfile();

      profileController.userName.value = profile.name;
      profileController.userPhone.value = profile.phone ?? '';

      if (profile.profileImage != null) {
        profileController.userAvatar.value = profile.profileImage!;
      }

      AppToast.success(message: result.message);

      AppRouter.route.pop();
    } finally {
      isUpdateLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // Get Profile
  // ---------------------------------------------------------------------------

  Future<void> getProfile() async {
    try {
      isProfileLoading.value = true;

      final result = await _service.getProfile();

      if (!result.success || result.data == null) {
        AppToast.error(message: result.message);
        return;
      }

      final profile = result.data!;

      // -----------------------------------------------------------------------
      // Form fields
      // -----------------------------------------------------------------------

      nameController.text = profile.name;
      phoneController.text = profile.phone ?? '';

      // -----------------------------------------------------------------------
      // Profile Controller
      // -----------------------------------------------------------------------

      profileController.userName.value = profile.name;
      profileController.userPhone.value = profile.phone ?? '';

      if (profile.profileImage != null) {
        profileController.userAvatar.value = profile.profileImage!;
      }

      // -----------------------------------------------------------------------
      // Location
      // -----------------------------------------------------------------------

      final location = BusinessLocationController.to;

      final cords = profile.locationCoordinates?.coordinates;

      if (cords != null && cords.length >= 2) {
        final latLng = LatLng(
          cords[1], // latitude
          cords[0], // longitude
        );

        location.setLocationFromProfile(
          latLng: latLng,
          address: profile.address,
        );
      } else {
        location.addressController.text = profile.address ?? '';
      }
    } finally {
      isProfileLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // Init
  // ---------------------------------------------------------------------------

  @override
  void onInit() {
    super.onInit();

    getProfile();
  }

  // ---------------------------------------------------------------------------
  // Dispose
  // ---------------------------------------------------------------------------

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();

    super.onClose();
  }
}
