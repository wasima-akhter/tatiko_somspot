import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:som_spot/features/auth/completed_profile_customer_merchandiser/service/complete_profile_service.dart';

import '../../../../helper/snackbar/api_snackbar.dart';
import '../service/complete_profile_request.dart';
import '../service/profile_navigation_service.dart';

class CompletedProfileCustomerController extends GetxController {
  final CompleteProfileService _service;

  CompletedProfileCustomerController(this._service);

  static CompletedProfileCustomerController get to => Get.find();

  void initialize({String? email}) {
    emailController.text = email ?? "";
  }

  final profileImagePath = Rx<String?>(null);
  final isLoading = false.obs;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

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

  Future<void> finishSetup() async {
    if (nameController.text.trim().isEmpty) {
      ApiSnackbar.show("Please enter your name", type: SnackbarType.error);
      return;
    }
    if (phoneController.text.trim().isEmpty) {
      ApiSnackbar.show(
        "Please enter your phone number",
        type: SnackbarType.error,
      );
      return;
    }

    if (profileImagePath.value == null) {
      ApiSnackbar.show(
        "Please upload a profile image",
        type: SnackbarType.error,
      );
      return;
    }

    try {
      isLoading.value = true;

      final result = await _service.completeProfile(
        CompleteProfileRequest(
          name: nameController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          profileImage: File(profileImagePath.value!),
        ),
      );

      if (!result.success) {
        ApiSnackbar.show(result.message, type: SnackbarType.error);
        return;
      }

      ApiSnackbar.show(result.message, type: SnackbarType.success);

      ProfileNavigationService.navigate();
    } finally {
      isLoading.value = false;
    }
  }
}
