import 'dart:io';

import 'package:som_spot/features/profile/edit_profile/controller/edit_merchant_profile_controller.dart';
import 'package:som_spot/helper/validator/text_field_validator.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../utils/common_controller/common_controller.dart';
import '../../../core/location/controller/business_location_controller.dart';
import '../../../core/location/widgets/app_location_picker.dart';
import '../../../core/location/widgets/app_location_suggestions.dart';

class EditMerchantProfileScreen extends StatefulWidget {
  const EditMerchantProfileScreen({super.key});

  @override
  State<EditMerchantProfileScreen> createState() =>
      _EditMerchantProfileScreenState();
}

class _EditMerchantProfileScreenState extends State<EditMerchantProfileScreen> {
  final controller = EditMerchantProfileController.to;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.nameController.text =
        controller.profileController.userName.value;
    controller.phoneController.text =
        controller.profileController.userPhone.value;

    // Clear selected local image on entry
    controller.selectedImage.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(AppStrings.editProfile.tr),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gap(24.h),
                  // Avatar Section
                  Center(
                    child: SizedBox(
                      height: 110.h,
                      width: 110.w,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Obx(() {
                              final localPath = controller.selectedImage.value;
                              return Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.w,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 8.r,
                                      offset: Offset(0, 4.h),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: localPath != null
                                      ? Image.file(
                                          File(localPath),
                                          fit: BoxFit.cover,
                                        )
                                      : CustomNetworkImage(
                                          imageUrl: controller
                                              .profileController
                                              .userAvatar
                                              .value,
                                          boxShape: BoxShape.circle,
                                        ),
                                ),
                              );
                            }),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => controller.pickImage(),
                              child: Container(
                                height: 34.h,
                                width: 34.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.w,
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: AppColors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(36.h),

                  // Full Name Field
                  CustomTextField(
                    title: AppStrings.fullName.tr,
                    controller: controller.nameController,
                    fillColor: AppColors.white,
                    hintText: AppStrings.fullName.tr,
                    prefixIcon: Icon(
                      Iconsax.user,
                      color: AppColors.hintTextColor,
                      size: 20.sp,
                    ),

                    validator: TextFieldValidator.name(),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: AppColors.backgroundsLinesColor,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: AppColors.backgroundsLinesColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),
                  Gap(20.h),

                  // Phone Number Field
                  CustomTextField(
                    title: AppStrings.phoneNumber.tr,
                    controller: controller.phoneController,
                    fillColor: AppColors.white,
                    hintText: AppStrings.phoneNumber.tr,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icon(
                      Iconsax.call,
                      color: AppColors.hintTextColor,
                      size: 20.sp,
                    ),
                    validator: TextFieldValidator.phone(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: AppColors.backgroundsLinesColor,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: AppColors.backgroundsLinesColor,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                  ),

                  Gap(20.h),

                  if (CommonController.to.isInfluencer) ...[
                    _buildInfluencerLocation(context),
                    Gap(24.h),
                  ],
                  Gap(48.h),

                  // Save Changes button
                  Obx(
                    () => controller.isUpdateLoading.value
                        ? LoadingWidget()
                        : CustomButton(
                            text: AppStrings.saveChanges.tr,
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              if (!(_formKey.currentState?.validate() ??
                                  false)) {
                                return;
                              }

                              EditMerchantProfileController.to.updateProfile(
                                name: controller.nameController.text.trim(),
                                phone: controller.phoneController.text.trim(),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfluencerLocation(BuildContext context) {
    final locationController = BusinessLocationController.to;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                onPressed: locationController.isGettingCurrentLocation.value
                    ? null
                    : locationController.useCurrentLocation,
                icon: locationController.isGettingCurrentLocation.value
                    ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: const CircularProgressIndicator(strokeWidth: 2),
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
            child: Obx(
              () => Stack(
                children: [
                  AppLocationPicker(
                    mapController: locationController.mapController,
                    selectedLatLng: locationController.selectedLatLng.value,
                    isSearching: locationController.isMapSearching.value,
                    onMapTap: locationController.updateMapPosition,
                  ),

                  if (locationController.isMapSearching.value)
                    AppLocationSuggestions(
                      suggestions: locationController.suggestions,
                      onTap: locationController.selectSuggestion,
                    ),
                ],
              ),
            ),
          ),
        ),

        Gap(16.h),

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
                  child: const CircularProgressIndicator(strokeWidth: 2),
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

        Gap(16.h),

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
            onPressed: locationController.searchLocationFromAddress,
            icon: Icon(
              Iconsax.search_normal,
              size: 20.sp,
              color: AppColors.primaryColor,
            ),
          ),
          onFieldSubmitted: (_) =>
              locationController.searchLocationFromAddress(),
        ),
      ],
    );
  }
}
