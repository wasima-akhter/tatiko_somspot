import 'dart:io';

import 'package:latlong2/latlong.dart';
import 'package:som_spot/features/profile/edit_profile/controller/edit_customer_profile_controller.dart';
import 'package:som_spot/helper/validator/text_field_validator.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../../../../share/export/screen_export.dart';
import '../../../core/location/controller/business_location_controller.dart';
import '../../../core/location/widgets/app_location_picker.dart';
import '../../../core/location/widgets/app_location_suggestions.dart';

class EditCustomerProfileScreen extends StatefulWidget {
  const EditCustomerProfileScreen({super.key});

  @override
  State<EditCustomerProfileScreen> createState() =>
      _EditCustomerProfileScreenState();
}

class _EditCustomerProfileScreenState extends State<EditCustomerProfileScreen> {
  final controller = EditCustomerProfileController.to;
  final locationController = BusinessLocationController.to;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Clear selected local image on entry.
    controller.selectedImage.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: AppStrings.editProfile.tr,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gap(24.h),

                  // ----------------------------------------------------------------
                  // Avatar
                  // ----------------------------------------------------------------
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
                              onTap: controller.pickImage,
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

                  // ----------------------------------------------------------------
                  // Full Name
                  // ----------------------------------------------------------------
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

                  // ----------------------------------------------------------------
                  // Phone
                  // ----------------------------------------------------------------
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

                  Gap(32.h),

                  // ----------------------------------------------------------------
                  // Location
                  // ----------------------------------------------------------------
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.whereAreYouLocated.tr,
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                  ),

                  Gap(12.h),

                  // Map
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
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.08,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Obx(() {
                        final LatLng latLng =
                            locationController.selectedLatLng.value;

                        final isSearching =
                            locationController.isMapSearching.value;

                        return Stack(
                          children: [
                            AppLocationPicker(
                              mapController: locationController.mapController,
                              selectedLatLng: latLng,
                              isSearching: isSearching,
                              onMapTap: locationController.updateMapPosition,
                            ),

                            if (isSearching)
                              AppLocationSuggestions(
                                suggestions: locationController.suggestions,
                                onTap: locationController.selectSuggestion,
                              ),
                          ],
                        );
                      }),
                    ),
                  ),

                  Gap(20.h),

                  // ----------------------------------------------------------------
                  // Address
                  // ----------------------------------------------------------------
                  CustomTextField(
                    controller: locationController.addressController,
                    title: AppStrings.streetAddress.tr,
                    hintText: AppStrings.enterStreetAddress.tr,
                    textInputAction: TextInputAction.next,
                    onChanged: locationController.onAddressChanged,
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
                        onPressed: locationController.searchLocationFromAddress,
                        icon: Icon(
                          Iconsax.search_normal,
                          size: 20.sp,
                          color: AppColors.primaryColor,
                        ),
                      );
                    }),
                    onFieldSubmitted: (_) =>
                        locationController.searchLocationFromAddress(),
                  ),

                  // ----------------------------------------------------------------
                  // Suggestions
                  // ----------------------------------------------------------------
                  Obx(() {
                    if (locationController.suggestions.isEmpty) {
                      return const SizedBox.shrink();
                    }

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
                        itemCount: locationController.suggestions.length,
                        separatorBuilder: (_, _) => const Divider(
                          color: AppColors.backgroundsLinesColor,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final suggestion =
                              locationController.suggestions[index];

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
                            onTap: () =>
                                locationController.selectSuggestion(suggestion),
                          );
                        },
                      ),
                    );
                  }),

                  Gap(16.h),

                  // ----------------------------------------------------------------
                  // City
                  // ----------------------------------------------------------------
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

                  Gap(40.h),

                  // ----------------------------------------------------------------
                  // Save
                  // ----------------------------------------------------------------
                  Obx(
                    () => controller.isUpdateLoading.value
                        ? const LoadingWidget()
                        : CustomButton(
                            text: AppStrings.saveChanges.tr,
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              if (!(_formKey.currentState?.validate() ??
                                  false)) {
                                return;
                              }

                              controller.updateProfile(
                                name: controller.nameController.text.trim(),
                                phone: controller.phoneController.text.trim(),
                              );
                            },
                          ),
                  ),

                  Gap(20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
