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
      title: AppStrings.editInfluencerProfile.tr,
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
                    AppStrings.influencerDetails.tr,
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                  ),

                  Text(
                    AppStrings.updateAudienceInformation.tr,
                    style: context.bodyLarge.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),

                  Gap(32.h),

                  // ------------------------------------------------
                  // CATEGORY
                  // ------------------------------------------------
                  Text(
                    AppStrings.influencerType.tr,
                    style: context.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkTextColor,
                    ),
                  ),

                  Gap(10.h),

                  Obx(
                    () => CustomDropdownField<String>(
                      hintText: AppStrings.selectInfluencerType.tr,

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
                    title: AppStrings.bio.tr,
                    hintText: AppStrings.bioExample.tr,

                    maxLines: 5,

                    prefixIcon: Icon(
                      Iconsax.text,

                      size: 20.sp,

                      color: AppColors.hintTextColor,
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.pleaseEnterYourBio.tr;
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

                    title: AppStrings.followerCount.tr,
                    hintText: AppStrings.enterTotalFollowers.tr,
                    keyboardType: TextInputType.number,

                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                    prefixIcon: Icon(
                      Iconsax.profile_2user,

                      size: 20.sp,

                      color: AppColors.hintTextColor,
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.pleaseEnterFollowerCount.tr;
                      }

                      return null;
                    },
                  ),

                  Gap(24.h),
                  Text(
                    AppStrings.socialAccounts.tr,
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

                    title: AppStrings.tiktok.tr,
                    hintText: AppStrings.usernameHint.tr,

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
                    title: AppStrings.instagram.tr,
                    hintText: AppStrings.usernameHint.tr,

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
                    title: AppStrings.facebook.tr,
                    hintText: AppStrings.pageUsername.tr,

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
                        text: AppStrings.saveChanges.tr,

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
