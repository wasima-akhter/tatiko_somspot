import 'dart:async';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/router/route_path.dart';
import '../../../../core/router/routes.dart';

class CompletedProfileInfluencerController extends GetxController {
  final profileImagePath = Rx<String?>(null);
  final isLoading = false.obs;

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
    try {
      isLoading.value = true;

      // upload image API here

      await Future.delayed(const Duration(seconds: 1));

      AppRouter.route.goNamed(RoutePath.navigationPages);
    } finally {
      isLoading.value = false;
    }
  }
}
