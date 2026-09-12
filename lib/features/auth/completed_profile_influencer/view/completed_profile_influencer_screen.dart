import 'dart:io';

import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../../../../helper/validator/text_field_validator.dart';
import '../../../core/location/controller/business_location_controller.dart';
import '../../../core/location/widgets/app_location_picker.dart';
import '../../../core/location/widgets/app_location_suggestions.dart';
import '../controller/completed_profile_influencer_controller.dart';

class CompletedProfileInfluencerScreen extends StatelessWidget {
  const CompletedProfileInfluencerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CompletedProfileInfluencerController.to;
    final locationController = BusinessLocationController.to;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,

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
                    AppStrings.connectSocials.tr,
                    style: context.headlineMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                  ),

                  Gap(8.h),

                  Text(
                    AppStrings.linkAccountsToVerifyReach.tr,
                    style: context.bodyLarge.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),

                  Gap(32.h),

                  // ----------------------------------------------------------------
                  // Profile Image
                  // ----------------------------------------------------------------
                  Center(
                    child: Obx(() {
                      final imagePath = controller.profileImagePath.value;

                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: controller.pickProfileImage,

                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),

                          height: 120.w,

                          width: 120.w,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            color: imagePath != null
                                ? null
                                : AppColors.primaryColor.withValues(
                                    alpha: 0.05,
                                  ),

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
                                      AppStrings.uploadPhoto.tr,

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

                  Center(
                    child: Text(
                      AppStrings.addProfilePhoto.tr,

                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),

                  Gap(24.h),

                  // ----------------------------------------------------------------
                  // Name
                  // ----------------------------------------------------------------
                  CustomTextField(
                    controller: controller.nameController,

                    title: AppStrings.fullName.tr,

                    hintText: AppStrings.enterYourFullName.tr,

                    textInputAction: TextInputAction.next,

                    prefixIcon: Icon(
                      Iconsax.user,
                      size: 20.sp,
                      color: AppColors.hintTextColor,
                    ),
                  ),

                  Gap(16.h),

                  // ----------------------------------------------------------------
                  // Phone
                  // ----------------------------------------------------------------
                  CustomTextField(
                    controller: controller.phoneController,
                    title: AppStrings.phoneNumber.tr,
                    hintText: "XXXXXXXXXXX",
                    prefixIcon: Icon(
                      Icons.person_outline,
                      size: 20.sp,
                      color: AppColors.hintTextColor,
                    ),

                    keyboardType: TextInputType.phone,

                    textInputAction: TextInputAction.next,

                    validator: TextFieldValidator.phone(),
                  ),

                  Gap(24.h),

                  // ----------------------------------------------------------------
                  // Location Title
                  // ----------------------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.selectLocation.tr,
                        style: context.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkTextColor,
                        ),
                      ),

                      Obx(
                        () => TextButton.icon(
                          onPressed:
                              locationController.isGettingCurrentLocation.value
                              ? null
                              : locationController.useCurrentLocation,
                          icon:
                              locationController.isGettingCurrentLocation.value
                              ? SizedBox(
                                  width: 16.w,
                                  height: 16.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  Iconsax.gps,
                                  size: 18.sp,
                                  color: AppColors.primaryColor,
                                ),
                          label: Text(
                            locationController.isGettingCurrentLocation.value
                                ? AppStrings.gettingLocation.tr
                                : AppStrings.useCurrentLocation.tr,
                            style: context.bodyMedium.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                      ),

                      child: Obx(() {
                        return Stack(
                          children: [
                            AppLocationPicker(
                              mapController: locationController.mapController,

                              selectedLatLng:
                                  locationController.selectedLatLng.value,

                              isSearching:
                                  locationController.isMapSearching.value,

                              onMapTap: locationController.updateMapPosition,
                            ),

                            if (locationController.isMapSearching.value)
                              AppLocationSuggestions(
                                suggestions: locationController.suggestions,

                                onTap: locationController.selectSuggestion,
                              ),
                          ],
                        );
                      }),
                    ),
                  ),

                  Gap(24.h),

                  CustomTextField(
                    controller: locationController.addressController,
                    title: AppStrings.streetAddress.tr,
                    hintText: AppStrings.enterStreetAddress.tr,
                    fillColor: AppColors.white,
                    onChanged: locationController.onAddressChanged,
                    onFieldSubmitted: (_) =>
                        locationController.searchLocationFromAddress(),
                    prefixIcon: Icon(
                      Iconsax.location,
                      size: 20.sp,
                      color: AppColors.hintTextColor,
                    ),
                    suffixIcon: Obx(() {
                      if (locationController.isSearchingSuggestions.value) {
                        return Padding(
                          padding: EdgeInsets.all(12.w),
                          child: SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }

                      return IconButton(
                        onPressed: locationController.searchLocationFromAddress,
                        icon: Icon(
                          Iconsax.search_normal,
                          color: AppColors.primaryColor,
                          size: 20.sp,
                        ),
                      );
                    }),
                  ),

                  Gap(24.h),
                  // ── City ──
                  CustomTextField(
                    controller: locationController.cityController,
                    title: AppStrings.city.tr,
                    hintText: AppStrings.enterCity.tr,
                    textInputAction: TextInputAction.search,
                    prefixIcon: Icon(
                      Iconsax.building,
                      size: 20.sp,
                      color: AppColors.hintTextColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () =>
                          locationController.searchLocationFromAddress(),
                      icon: Icon(
                        Iconsax.search_normal,
                        size: 20.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    onFieldSubmitted: (_) =>
                        locationController.searchLocationFromAddress(),
                  ),

                  Gap(40.h),

                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        text: AppStrings.finishAndSetup.tr,
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          controller.completeBasicProfile();
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
