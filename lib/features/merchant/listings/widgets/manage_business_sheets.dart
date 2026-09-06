import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:som_spot/helper/date_converter/date_converter.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../../../core/category/controller/category_controller.dart';
import '../../../core/location/controller/business_location_controller.dart';
import '../../../core/location/widgets/app_location_picker.dart';
import '../../../core/location/widgets/app_location_suggestions.dart';
import '../controller/merchant_listing_controller.dart';

// ════════════════════════════════════════════════════════════
// Common helper for showing bottom sheets
// ════════════════════════════════════════════════════════════

void _showManageSheet(BuildContext context, {required Widget child}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => child,
  );
}

Widget _buildSheetHeader(
  BuildContext context, {
  required String title,
  required String subtitle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextColor,
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.softSlateBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 18.sp,
                color: AppColors.subtitleTextColor,
              ),
            ),
          ),
        ],
      ),
      Gap(4.h),
      Text(
        subtitle,
        style: context.bodySmall.copyWith(color: AppColors.subtitleTextColor),
      ),
    ],
  );
}

Widget _buildLabel(BuildContext context, String text) {
  return Text(
    text,
    style: context.titleSmall.copyWith(
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextColor,
    ),
  );
}

// ════════════════════════════════════════════════════════════
// 1. Edit Business Profile
// ════════════════════════════════════════════════════════════

void showEditBusinessProfileSheet(BuildContext context) {
  _showManageSheet(context, child: const _EditBusinessProfileSheet());
}

class _EditBusinessProfileSheet extends StatelessWidget {
  const _EditBusinessProfileSheet();

  @override
  Widget build(BuildContext context) {
    final controller = MerchantListingController.to;
    final categoryController = CategoryController.to;

    categoryController.loadInitialCategories();
    controller.loadBusiness();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.softBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),

      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.paddingOf(context).bottom > 0
            ? MediaQuery.paddingOf(context).bottom
            : 20.h,
      ),

      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children: [
              _buildSheetHeader(
                context,
                title: AppStrings.editBusinessProfile.tr,
                subtitle: AppStrings.updateHowCustomersSee.tr,
              ),

              Gap(20.h),

              //Cover + logo Image
              Center(
                child: Obx(() {
                  final controller = MerchantListingController.to;
                  final business = controller.selectedBusiness.value;

                  return Container(
                    width: double.infinity,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.backgroundsLinesColor,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // COVER IMAGE
                          Positioned.fill(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: controller.pickCoverImage,
                              child: controller.coverImage.value != null
                                  ? Image.file(
                                      controller.coverImage.value!,
                                      fit: BoxFit.cover,
                                    )
                                  : (business != null &&
                                        business.coverImage.isNotEmpty)
                                  ? CustomNetworkImage(
                                      key: ValueKey(business.coverImage),
                                      imageUrl: business.coverImage,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: AppColors.softSlateBgColor,
                                    ),
                            ),
                          ),

                          // COVER EDIT BUTTON
                          Positioned(
                            top: 10.h,
                            right: 10.w,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: controller.pickCoverImage,
                              child: Container(
                                padding: EdgeInsets.all(7.w),
                                decoration: BoxDecoration(
                                  color: AppColors.blueAccentColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Iconsax.edit,
                                  size: 16.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),

                          // LOGO
                          Stack(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: controller.pickLogoImage,
                                child: controller.logoImage.value != null
                                    ? ClipOval(
                                        child: Image.file(
                                          controller.logoImage.value!,
                                          height: 80.h,
                                          width: 80.w,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : (business != null &&
                                          business.logo.isNotEmpty)
                                    ? ClipOval(
                                        child: CustomNetworkImage(
                                          key: ValueKey(business.logo),
                                          imageUrl: business.logo,
                                          height: 80.h,
                                          width: 80.w,
                                          fit: BoxFit.cover,
                                          boxShape: BoxShape.circle,
                                        ),
                                      )
                                    : CircleAvatar(
                                        radius: 40.r,
                                        backgroundColor:
                                            AppColors.softSlateBgColor,
                                        child: Icon(
                                          Iconsax.shop,
                                          size: 32.sp,
                                          color: AppColors.blueAccentColor,
                                        ),
                                      ),
                              ),

                              // LOGO EDIT BUTTON
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: controller.pickLogoImage,
                                  child: Container(
                                    padding: EdgeInsets.all(6.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.blueAccentColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Iconsax.camera,
                                      size: 14.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              Gap(20.h),

              _buildLabel(context, AppStrings.businessName.tr),

              Gap(8.h),

              CustomTextField(
                controller: controller.businessNameController,
                hintText: AppStrings.restaurantNameExample.tr,
                fillColor: AppColors.white,
              ),

              Gap(16.h),

              _buildLabel(context, AppStrings.category.tr),

              Gap(8.h),

              Obx(
                () => Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: categoryController.categories.map((category) {
                    final selected =
                        controller.selectedCategoryId.value == category.id;

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        controller.selectedCategoryId.value = category.id;
                      },

                      child: Container(
                        padding: EdgeInsets.all(12.w),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),

                          border: Border.all(
                            color: selected
                                ? AppColors.primaryColor
                                : AppColors.backgroundsLinesColor,
                          ),
                        ),

                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomNetworkImage(
                              imageUrl: category.icon,

                              height: 20,
                              width: 20,
                              boxShape: BoxShape.circle,
                            ),
                            Gap(2),
                            Text(category.name.capitalizeWords()),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              Gap(16.h),

              _buildLabel(context, AppStrings.description.tr),

              Gap(8.h),

              CustomTextField(
                controller: controller.descriptionController,

                hintText: AppStrings.reviewHint.tr,

                fillColor: AppColors.white,

                maxLines: 4,

                minLines: 4,

                maxLength: 500,
              ),

              Gap(20.h),

              Obx(
                () => controller.isLoading.value
                    ? LoadingWidget() // AppStrings.loading.tr
                    : CustomButton(
                        text: AppStrings.saveChanges.tr,

                        onTap: controller.isLoading.value
                            ? null
                            : () async {
                                await controller.updateBusinessProfile();

                                if (!controller.isLoading.value) {
                                  AppRouter.route.pop();
                                }
                              },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ════════════════════════════════════════════════════════════
// 2. Manage Gallery
// ════════════════════════════════════════════════════════════

void showManageGallerySheet(BuildContext context) {
  _showManageSheet(context, child: const _ManageGallerySheet());
}

class _ManageGallerySheet extends StatefulWidget {
  const _ManageGallerySheet();

  @override
  State<_ManageGallerySheet> createState() => _ManageGallerySheetState();
}

class _ManageGallerySheetState extends State<_ManageGallerySheet> {
  final controller = MerchantListingController.to;

  Future<void> _pickImages() async {
    final images = await ImagePicker().pickMultiImage();

    if (images.isEmpty) return;

    controller.galleryImages.addAll(images.map((e) => File(e.path)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.softBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),

      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.paddingOf(context).bottom > 0
            ? MediaQuery.paddingOf(context).bottom
            : 20.h,
      ),

      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          mainAxisSize: MainAxisSize.min,

          children: [
            _buildSheetHeader(
              context,
              title: AppStrings.manageGallery.tr,
              subtitle: AppStrings.addPhotosShowcase.tr,
            ),

            Gap(20.h),

            Obx(() {
              final existing = controller.existingGalleryImages;
              final selected = controller.galleryImages;

              final totalCount = existing.length + selected.length;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                ),

                itemCount: totalCount + 1,

                itemBuilder: (context, index) {
                  // Add button
                  if (index == totalCount) {
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _pickImages,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.backgroundsLinesColor,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: AppColors.blueAccentColor),
                            Gap(4.h),
                            Text(AppStrings.changePhoto.tr),
                          ],
                        ),
                      ),
                    );
                  }

                  // Existing backend image (preview only)
                  if (index < existing.length) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CustomNetworkImage(
                            imageUrl: existing[index],
                            fit: BoxFit.cover,
                          ),

                          // light layer
                          Container(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ],
                      ),
                    );
                  }

                  // Newly selected image
                  final fileIndex = index - existing.length;
                  final file = selected[fileIndex];

                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.file(
                          file,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        top: 6.w,
                        right: 6.w,

                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            controller.galleryImages.removeAt(fileIndex);
                          },

                          child: Container(
                            padding: EdgeInsets.all(4.w),

                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),

                            child: Icon(
                              Icons.close,
                              size: 12.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
            Gap(24.h),

            Obx(
              () => controller.isLoading.value
                  ? LoadingWidget()
                  : CustomButton(
                      text: AppStrings.saveGallery.tr,

                      onTap: () async {
                        await controller.updateGallery();

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// 3. Operating Hours
// ════════════════════════════════════════════════════════════

void showOperatingHoursSheet(BuildContext context) {
  _showManageSheet(context, child: const _OperatingHoursSheet());
}

class _OperatingHoursSheet extends StatefulWidget {
  const _OperatingHoursSheet();

  @override
  State<_OperatingHoursSheet> createState() => _OperatingHoursSheetState();
}

class _OperatingHoursSheetState extends State<_OperatingHoursSheet> {
  final controller = MerchantListingController.to;

  final List<String> _days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

  String _label(String day) {
    return day[0].toUpperCase() + day.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.softBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.paddingOf(context).bottom > 0
            ? MediaQuery.paddingOf(context).bottom
            : 20.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSheetHeader(
              context,
              title: AppStrings.operatingHours.tr,
              subtitle: AppStrings.setWhenBusinessOpen.tr,
            ),

            Gap(20.h),

            Obx(() {
              return Column(
                children: _days
                    .map((day) => _buildDayRow(context, day))
                    .toList(),
              );
            }),

            Gap(20.h),

            Obx(
              () => controller.isLoading.value
                  ? LoadingWidget()
                  : CustomButton(
                      text: AppStrings.saveHours.tr,
                      onTap: () async {
                        await controller.updateOperatingHours();

                        if (controller.isLoading.value) return;

                        Navigator.pop(context);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayRow(BuildContext context, String day) {
    final data = controller.businessHours[day];

    if (data == null) {
      return const SizedBox();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 40.w,
            child: Text(
              _label(day),
              style: context.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkTextColor,
              ),
            ),
          ),

          Gap(12.w),

          _buildTimeBox(
            context,
            DateConverter.formatTimeToAmPm(data["open"] ?? "09:00"),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "–",
              style: context.bodyMedium.copyWith(
                color: AppColors.hintTextColor,
              ),
            ),
          ),

          _buildTimeBox(
            context,
            DateConverter.formatTimeToAmPm(data["close"] ?? "22:00"),
          ),

          const Spacer(),

          Switch.adaptive(
            value: data["isOpen"] ?? false,

            inactiveThumbColor: AppColors.grayTertiaryTextColor,
            inactiveTrackColor: AppColors.grayTertiaryTextColor.withValues(
              alpha: 0.3,
            ),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),

            onChanged: (value) {
              controller.businessHours[day] = {...data, "isOpen": value};

              controller.businessHours.refresh();
            },
            activeTrackColor: AppColors.blueAccentColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(BuildContext context, String time) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.backgroundsLinesColor),
      ),
      child: Text(
        time,
        style: context.bodySmall.copyWith(
          color: AppColors.darkTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
// ════════════════════════════════════════════════════════════
// 4. Update Location
// ════════════════════════════════════════════════════════════

void showUpdateLocationSheet(BuildContext context) {
  _showManageSheet(context, child: const _UpdateLocationSheet());
}

class _UpdateLocationSheet extends StatelessWidget {
  const _UpdateLocationSheet();

  @override
  Widget build(BuildContext context) {
    final controller = MerchantListingController.to;
    final location = BusinessLocationController.to;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.softBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.paddingOf(context).bottom > 0
            ? MediaQuery.paddingOf(context).bottom
            : 20.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSheetHeader(
              context,
              title: AppStrings.updateLocation.tr,
              subtitle: AppStrings.helpCustomersFind.tr,
            ),

            Gap(20.h),

            Obx(
              () => AppLocationPicker(
                mapController: location.mapController,
                selectedLatLng: location.selectedLatLng.value,
                isSearching: location.isMapSearching.value,
                onMapTap: location.updateMapPosition,
              ),
            ),

            AppLocationSuggestions(
              suggestions: location.suggestions,
              onTap: location.selectSuggestion,
            ),

            Gap(20.h),

            CustomTextField(
              controller: location.addressController,
              title: AppStrings.streetAddress.tr,
              hintText: AppStrings.enterStreetAddress.tr,
              fillColor: AppColors.white,
              onChanged: location.onAddressChanged,
              onFieldSubmitted: (_) => location.searchLocationFromAddress(),
              prefixIcon: Icon(
                Iconsax.location,
                size: 20.sp,
                color: AppColors.hintTextColor,
              ),
              suffixIcon: Obx(() {
                if (location.isSearchingSuggestions.value) {
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
                  onPressed: location.searchLocationFromAddress,
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
              controller: location.cityController,
              title: AppStrings.city.tr,
              hintText: AppStrings.enterCity.tr,
              fillColor: AppColors.white,
              textInputAction: TextInputAction.search,
              prefixIcon: Icon(
                Iconsax.building,
                size: 20.sp,
                color: AppColors.hintTextColor,
              ),
              suffixIcon: IconButton(
                onPressed: location.searchLocationFromAddress,
                icon: Icon(
                  Iconsax.search_normal,
                  size: 20.sp,
                  color: AppColors.primaryColor,
                ),
              ),
              onFieldSubmitted: (_) => location.searchLocationFromAddress(),
            ),

            Gap(24.h),

            Obx(
              () => CustomButton(
                isLoading: controller.isLoading.value,
                text: AppStrings.saveLocation.tr,
                onTap: controller.updateLocation,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// 5. Contact Information
// ════════════════════════════════════════════════════════════

void showContactInfoSheet(BuildContext context) {
  _showManageSheet(context, child: const _ContactInfoSheet());
}

class _ContactInfoSheet extends StatelessWidget {
  const _ContactInfoSheet();

  @override
  Widget build(BuildContext context) {
    final controller = MerchantListingController.to;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.softBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: MediaQuery.paddingOf(context).bottom > 0
            ? MediaQuery.paddingOf(context).bottom
            : 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSheetHeader(
            context,
            title: AppStrings.contactInformation.tr,
            subtitle: AppStrings.howCustomersReach.tr,
          ),

          Gap(20.h),

          _buildLabel(context, AppStrings.businessPhone.tr),

          Gap(8.h),

          CustomTextField(
            controller: controller.phoneController,
            hintText: '+252 61 XXX XXXX',
            fillColor: AppColors.white,
            keyboardType: TextInputType.phone,
          ),

          Gap(16.h),

          _buildLabel(context, AppStrings.whatsappOptional.tr),

          Gap(8.h),

          CustomTextField(
            controller: controller.whatsappController,
            hintText: '+252 61 XXX XXXX',
            fillColor: AppColors.white,
            keyboardType: TextInputType.phone,
          ),

          Gap(24.h),

          Obx(
            () => CustomButton(
              isLoading: controller.isLoading.value,
              text: AppStrings.saveContactInfo.tr,
              onTap: () async {
                await controller.updateContact();

                if (!controller.isLoading.value) {
                  FocusManager.instance.primaryFocus?.unfocus();

                  AppRouter.route.pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
