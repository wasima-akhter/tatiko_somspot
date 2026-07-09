import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../controller/completed_profile_influencer_controller.dart';

class CompletedProfileInfluencerScreen extends StatelessWidget {
  const CompletedProfileInfluencerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompletedProfileInfluencerController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(24.h),

              Text(
                "Connect Socials",
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),

              Gap(8.h),

              Text(
                "Link your accounts to verify your reach",
                style: context.bodyLarge.copyWith(
                  color: AppColors.subtitleTextColor,
                ),
              ),

              Gap(32.h),

              Center(
                child: Obx(() {
                  final imagePath = controller.profileImagePath.value;

                  return GestureDetector(
                    onTap: controller.pickProfileImage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 150.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: imagePath != null
                            ? null
                            : AppColors.primaryColor.withValues(alpha: 0.05),
                        border: Border.all(
                          color: AppColors.primaryColor.withValues(alpha: 0.4),
                          width: 2,
                        ),
                        image: imagePath != null
                            ? DecorationImage(
                                image: FileImage(File(imagePath)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: imagePath == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.gallery_add,
                                  size: 35.sp,
                                  color: AppColors.primaryColor,
                                ),
                                Gap(8.h),
                                Text(
                                  "Upload Photo",
                                  style: context.bodySmall.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Iconsax.camera,
                                  size: 16.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                    ),
                  );
                }),
              ),
              Gap(16.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Add Profile Photo",
                  textAlign: TextAlign.center,
                  style: context.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              Gap(40.h),

              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Finish & Setup",
                    isLoading: controller.isLoading.value,
                    onTap: controller.profileImagePath.value == null
                        ? null
                        : controller.finishSetup,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
