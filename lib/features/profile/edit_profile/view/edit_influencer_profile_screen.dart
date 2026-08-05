import 'package:flutter/services.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/dropdown/custom_dropdown_field.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';
import '../controller/edit_influencer_controller.dart';

class EditInfluencerScreen extends StatelessWidget {
  const EditInfluencerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditInfluencerController.to;

    final formKey = GlobalKey<FormState>();

    return ScaffoldWrapper(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("Edit Creator Profile"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),

          child: SingleChildScrollView(
            child: Form(
              key: formKey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Gap(24.h),

                  Text(
                    "Creator Details",

                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,

                      color: AppColors.darkTextColor,
                    ),
                  ),

                  Gap(8.h),

                  Text(
                    "Update your audience information and social presence",

                    style: context.bodyLarge.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),

                  Gap(32.h),

                  // ------------------------------------------------
                  // CATEGORY
                  // ------------------------------------------------
                  Text(
                    "Influencer Type",

                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,

                      color: AppColors.darkTextColor,
                    ),
                  ),

                  Gap(10.h),

                  Obx(
                    () => CustomDropdownField<String>(
                      hintText: "Select Influencer Type",

                      items: controller.influencerCategories
                          .map((e) => e.name)
                          .toList(),

                      value: controller.selectedInfluencerCategoryName.isEmpty
                          ? null
                          : controller.selectedInfluencerCategoryName,

                      isRequired: true,

                      onChanged: (value) {
                        final category = controller.influencerCategories
                            .firstWhereOrNull((e) => e.name == value);

                        controller.selectInfluencerCategory(category?.id);
                      },
                    ),
                  ),

                  Gap(16.h),

                  // ------------------------------------------------
                  // BIO
                  // ------------------------------------------------
                  CustomTextField(
                    controller: controller.bioController,

                    title: "Bio",

                    hintText:
                        "Example: I run the biggest food review page in Mogadishu",

                    maxLines: 5,

                    prefixIcon: Icon(
                      Iconsax.text,

                      size: 20.sp,

                      color: AppColors.hintTextColor,
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your bio";
                      }

                      return null;
                    },
                  ),

                  Gap(16.h),

                  // ------------------------------------------------
                  // FOLLOWERS
                  // ------------------------------------------------
                  CustomTextField(
                    controller: controller.followerCountController,

                    title: "Follower Count",

                    hintText: "Enter total followers",

                    keyboardType: TextInputType.number,

                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                    prefixIcon: Icon(
                      Iconsax.profile_2user,

                      size: 20.sp,

                      color: AppColors.hintTextColor,
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter follower count";
                      }

                      return null;
                    },
                  ),

                  Gap(24.h),

                  Text(
                    "Social Accounts",

                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,

                      color: AppColors.darkTextColor,
                    ),
                  ),

                  Gap(10.h),

                  // ------------------------------------------------
                  // TIKTOK
                  // ------------------------------------------------
                  CustomTextField(
                    controller: controller.tiktokController,

                    title: "TikTok",

                    hintText: "@username",

                    prefixIcon: Icon(
                      Iconsax.video,

                      size: 20.sp,

                      color: AppColors.hintTextColor,
                    ),
                  ),

                  Gap(16.h),

                  // ------------------------------------------------
                  // INSTAGRAM
                  // ------------------------------------------------
                  CustomTextField(
                    controller: controller.instagramController,

                    title: "Instagram",

                    hintText: "@username",

                    prefixIcon: Icon(
                      Iconsax.instagram,

                      size: 20.sp,

                      color: AppColors.hintTextColor,
                    ),
                  ),

                  Gap(16.h),

                  // ------------------------------------------------
                  // FACEBOOK
                  // ------------------------------------------------
                  CustomTextField(
                    controller: controller.facebookController,

                    title: "Facebook",

                    hintText: "Page username",

                    prefixIcon: Icon(
                      Icons.facebook,

                      size: 20.sp,

                      color: AppColors.hintTextColor,
                    ),
                  ),

                  Gap(40.h),

                  Obx(
                    () => SizedBox(
                      width: double.infinity,

                      child: CustomButton(
                        text: "Save Changes",

                        isLoading: controller.isLoading.value,

                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();

                          if (!(formKey.currentState?.validate() ?? false)) {
                            return;
                          }

                          controller.updateCreatorProfile();
                        },
                      ),
                    ),
                  ),

                  Gap(24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
