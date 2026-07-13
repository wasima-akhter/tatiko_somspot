import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:som_spot/features/profile/main_profile/controller/profile_controller.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find<EditProfileController>();
  // Find the parent ProfileScreenController to update the profile state globally
  final profileController = Get.find<ProfileScreenController>();

  // Selected local image path for preview
  final selectedImage = RxnString();

  // Loading state for profile update
  final isUpdateLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        selectedImage.value = image.path;
      }
    } catch (e) {
      AppToast.error(message: "Failed to pick image: $e");
    }
  }

  void updateProfile({required String name, required String phone}) {
    isUpdateLoading.value = true;

    // Simulate API update
    Future.delayed(const Duration(seconds: 1), () {
      profileController.userName.value = name;
      profileController.userPhone.value = phone;
      if (selectedImage.value != null) {
        profileController.userAvatar.value = selectedImage.value!;
      }
      isUpdateLoading.value = false;

      AppToast.success(message: "Profile updated successfully!");
    });
  }
}
