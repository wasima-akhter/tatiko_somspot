import 'package:som_spot/share/controller/screen_export.dart';

import '../../../../helper/toast/toast_helper.dart';
import '../../../auth/completed_profile_influencer/model/influencer_info_profile_request.dart';
import '../../../core/category/controller/category_controller.dart';
import '../../../core/category/model/category_model.dart';
import '../../models/influencer_profile_model.dart';
import '../../service/influencer_profile_service.dart';

class EditInfluencerController extends GetxController {
  final InfluencerProfileService _service;

  EditInfluencerController(this._service);

  static EditInfluencerController get to => Get.find();

  // ---------------------------------------------------------------------------
  // Profile Data
  // ---------------------------------------------------------------------------

  final influencerProfile = Rxn<InfluencerProfileModel>();

  // ---------------------------------------------------------------------------
  // Creator Fields
  // ---------------------------------------------------------------------------

  final bioController = TextEditingController();

  final followerCountController = TextEditingController();

  final tiktokController = TextEditingController();

  final instagramController = TextEditingController();

  final facebookController = TextEditingController();

  // ---------------------------------------------------------------------------
  // Category
  // ---------------------------------------------------------------------------

  final selectedInfluencerCategoryId = "".obs;

  RxList<CategoryModel> get influencerCategories =>
      CategoryController.to.categories;

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
  // Loading
  // ---------------------------------------------------------------------------

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (CategoryController.to.categories.isEmpty) {
      CategoryController.to.fetchCategories();
    }

    getCreatorProfile();
  }

  // ---------------------------------------------------------------------------
  // GET
  // ---------------------------------------------------------------------------

  Future<void> getCreatorProfile() async {
    try {
      isLoading.value = true;

      final result = await _service.getCreatorProfile();

      if (!result.success || result.data == null) {
        AppToast.error(message: result.message);

        return;
      }

      influencerProfile.value = result.data;

      _populateFields();
    } finally {
      isLoading.value = false;
    }
  }

  void _populateFields() {
    final profile = influencerProfile.value;

    if (profile == null) {
      return;
    }

    bioController.text = profile.bio;

    followerCountController.text = profile.followerCount.toString();

    selectedInfluencerCategoryId.value = profile.category?.id ?? "";

    for (final social in profile.socials) {
      switch (social.platform.toLowerCase()) {
        case "tiktok":
          tiktokController.text = social.handle;

          break;

        case "instagram":
          instagramController.text = social.handle;

          break;

        case "facebook":
          facebookController.text = social.handle;

          break;
      }
    }
  }

  // ---------------------------------------------------------------------------
  // VALIDATION
  // ---------------------------------------------------------------------------

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
  // UPDATE
  // ---------------------------------------------------------------------------

  Future<void> updateCreatorProfile() async {
    if (!validateCreatorProfile()) {
      return;
    }

    try {
      isLoading.value = true;

      final result = await _service.updateCreatorProfile(
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

      AppRouter.route.pop();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    bioController.dispose();

    followerCountController.dispose();

    tiktokController.dispose();

    instagramController.dispose();

    facebookController.dispose();

    super.onClose();
  }
}
