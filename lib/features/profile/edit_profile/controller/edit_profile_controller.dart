import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:som_spot/features/profile/main_profile/controller/profile_controller.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';

import '../../../../core/router/routes.dart';
import '../../request/edit_profile_request.dart';
import '../../service/profile_service.dart';

class EditProfileController extends GetxController {
  final ProfileService _service;

  EditProfileController(this._service);

  static EditProfileController get to => Get.find();

  final profileController = ProfileScreenController.to;

  final selectedImage = RxnString();

  final isUpdateLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      selectedImage.value = image.path;
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      isUpdateLoading.value = true;

      final result = await _service.editProfile(
        EditProfileRequest(
          name: name,
          phone: phone,
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

      profileController.userName.value = profile.name;

      profileController.userPhone.value = profile.phone ?? "";

      if (profile.profileImage != null) {
        profileController.userAvatar.value = profile.profileImage!;
      }

      AppToast.success(message: result.message);

      AppRouter.route.pop();
    } finally {
      isUpdateLoading.value = false;
    }
  }
}
