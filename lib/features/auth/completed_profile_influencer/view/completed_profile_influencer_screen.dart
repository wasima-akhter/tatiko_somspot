import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../../../../share/widgets/dropdown/custom_dropdown_field.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../../../common_components/location/app_location_picker.dart';
import '../../../common_components/location/app_location_suggestions.dart';
import '../controller/completed_profile_influencer_controller.dart';

class CompletedProfileInfluencerScreen extends StatelessWidget {
  const CompletedProfileInfluencerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompletedProfileInfluencerController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
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
                        height: 120.w,
                        width: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: imagePath != null
                              ? null
                              : AppColors.primaryColor.withValues(alpha: 0.05),
                          border: Border.all(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.4,
                            ),
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
                Gap(24.h),

                Text(
                  "Influencer Type",
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTextColor,
                  ),
                ),

                Gap(10.h),
                CustomDropdownField<String>(
                  hintText: "Select Influencer Type",
                  items: controller.influencerTypes,
                  value: controller.selectedInfluencerType?.value,
                  isRequired: true,
                  onChanged: (value) {
                    controller.selectedInfluencerType?.value = value ?? '';
                  },
                ),
                Gap(24.h),

                Text(
                  "Select Location",
                  style: context.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTextColor,
                  ),
                ),

                Gap(10.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Container(
                    height: 220.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.primaryColor.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withValues(alpha: 0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Obx(() {
                      final isSearching = controller.isMapSearching.value;
                      return Stack(
                        children: [
                          AppLocationPicker(
                            mapController: controller.mapController,
                            selectedLatLng: controller.selectedLatLng.value,
                            isSearching: controller.isMapSearching.value,
                            onMapTap: controller.updateMapPosition,
                          ),

                          if (isSearching)
                            AppLocationSuggestions(
                              suggestions: controller.suggestions,
                              onTap: controller.selectSuggestion,
                            ),
                        ],
                      );
                    }),
                  ),
                ),
                Gap(24.h),
                // ── Street Address ──
                CustomTextField(
                  controller: controller.addressController,
                  title: AppStrings.streetAddress.tr,
                  hintText: AppStrings.enterStreetAddress.tr,
                  textInputAction: TextInputAction.next,
                  onChanged: (val) => controller.onAddressChanged(val),
                  prefixIcon: Icon(
                    Iconsax.location,
                    size: 20.sp,
                    color: AppColors.hintTextColor,
                  ),
                  suffixIcon: Obx(() {
                    if (controller.isSearchingSuggestions.value) {
                      return Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryColor,
                            ),
                          ),
                        ),
                      );
                    }
                    return IconButton(
                      onPressed: () => controller.searchLocationFromAddress(),
                      icon: Icon(
                        Iconsax.search_normal,
                        size: 20.sp,
                        color: AppColors.primaryColor,
                      ),
                    );
                  }),
                  onFieldSubmitted: (_) =>
                      controller.searchLocationFromAddress(),
                ),

                // ── Search Suggestions List ──
                Obx(() {
                  if (controller.suggestions.isEmpty)
                    return const SizedBox.shrink();
                  return Container(
                    margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                    constraints: BoxConstraints(maxHeight: 200.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.backgroundsLinesColor,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      itemCount: controller.suggestions.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: AppColors.backgroundsLinesColor,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final suggestion = controller.suggestions[index];
                        final displayName = suggestion['display_name'] ?? '';
                        return ListTile(
                          leading: const Icon(
                            Iconsax.location,
                            color: AppColors.primaryColor,
                          ),
                          title: Text(
                            displayName,
                            style: context.bodyMedium.copyWith(
                              color: AppColors.darkTextColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () => controller.selectSuggestion(suggestion),
                        );
                      },
                    ),
                  );
                }),

                Gap(16.h),

                // ── City ──
                CustomTextField(
                  controller: controller.cityController,
                  title: AppStrings.city.tr,
                  hintText: AppStrings.enterCity.tr,
                  textInputAction: TextInputAction.search,
                  prefixIcon: Icon(
                    Iconsax.building,
                    size: 20.sp,
                    color: AppColors.hintTextColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => controller.searchLocationFromAddress(),
                    icon: Icon(
                      Iconsax.search_normal,
                      size: 20.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  onFieldSubmitted: (_) =>
                      controller.searchLocationFromAddress(),
                ),
                Gap(40.h),

                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Finish & Setup",
                      isLoading: controller.isLoading.value,
                      onTap: controller.finishSetup,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
