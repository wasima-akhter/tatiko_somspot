import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

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

Widget _buildSheetHeader(BuildContext context,
    {required String title, required String subtitle}) {
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
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.softSlateBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 18.sp, color: AppColors.subtitleTextColor),
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
              title: AppStrings.editBusinessProfile.tr,
              subtitle: AppStrings.updateHowCustomersSee.tr,
            ),
            Gap(20.h),

            // Profile Image Placeholder
            Center(
              child: Container(
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.backgroundsLinesColor),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: AppColors.softSlateBgColor,
                        child: Icon(Iconsax.shop, size: 32.sp, color: AppColors.blueAccentColor),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: AppColors.blueAccentColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.white, width: 2),
                          ),
                          child: Icon(Iconsax.camera, size: 14.sp, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Gap(20.h),

            _buildLabel(context, AppStrings.businessName.tr),
            Gap(8.h),
            CustomTextField(
              hintText: 'e.g. Hilib Macaan Restaurant',
              fillColor: AppColors.white,
            ),
            Gap(16.h),

            _buildLabel(context, AppStrings.category.tr),
            Gap(8.h),
            CustomTextField(
              hintText: 'e.g. Restaurant',
              fillColor: AppColors.white,
            ),
            Gap(16.h),

            _buildLabel(context, AppStrings.description.tr),
            Gap(8.h),
            CustomTextField(
              hintText: 'What did you like or dislike? How was the service?',
              fillColor: AppColors.white,
              maxLines: 4,
              minLines: 4,
              maxLength: 500,
            ),
            Gap(20.h),

            CustomButton(
              text: AppStrings.saveChanges.tr,
              onTap: () => Navigator.pop(context),
            ),
          ],
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

class _ManageGallerySheet extends StatelessWidget {
  const _ManageGallerySheet();

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

          // Gallery Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1,
            ),
            itemCount: 6, // 5 images + 1 add button
            itemBuilder: (context, index) {
              if (index == 5) {
                // Add button
                return GestureDetector(
                  onTap: () {
                    // TODO: pick image
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.backgroundsLinesColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 28.sp, color: AppColors.blueAccentColor),
                        Gap(4.h),
                        Text(
                          AppStrings.add.tr,
                          style: context.bodySmall.copyWith(
                            color: AppColors.subtitleTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              // Placeholder gallery items
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.softSlateBgColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Icon(Iconsax.image, size: 28.sp, color: AppColors.hintTextColor),
                    ),
                  ),
                  Positioned(
                    top: 6.w,
                    right: 6.w,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppColors.blueAccentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: 12.sp, color: AppColors.white),
                    ),
                  ),
                ],
              );
            },
          ),
          Gap(24.h),

          CustomButton(
            text: AppStrings.saveGallery.tr,
            onTap: () => Navigator.pop(context),
          ),
        ],
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
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final Map<String, bool> _enabled = {
    'Mon': true, 'Tue': true, 'Wed': true, 'Thu': true,
    'Fri': true, 'Sat': true, 'Sun': true,
  };

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

            ..._days.map((day) => _buildDayRow(context, day)),

            Gap(20.h),
            CustomButton(
              text: AppStrings.saveHours.tr,
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayRow(BuildContext context, String day) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 40.w,
            child: Text(
              day,
              style: context.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkTextColor,
              ),
            ),
          ),
          Gap(12.w),
          _buildTimeBox(context, '09:00'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text('–', style: context.bodyMedium.copyWith(color: AppColors.hintTextColor)),
          ),
          _buildTimeBox(context, '22:00'),
          const Spacer(),
          Switch.adaptive(
            value: _enabled[day]!,
            onChanged: (val) => setState(() => _enabled[day] = val),
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
            title: AppStrings.updateLocation.tr,
            subtitle: AppStrings.helpCustomersFind.tr,
          ),
          Gap(20.h),

          // Mock Map
          Container(
            width: double.infinity,
            height: 160.h,
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(painter: _LocationMapPainter()),
                ),
                Center(
                  child: Icon(
                    Iconsax.location5,
                    color: AppColors.blueAccentColor,
                    size: 32.sp,
                  ),
                ),
              ],
            ),
          ),
          Gap(20.h),

          _buildLabel(context, AppStrings.streetAddress.tr),
          Gap(8.h),
          CustomTextField(
            hintText: 'e.g. Maka Al Mukarama Road',
            fillColor: AppColors.white,
          ),
          Gap(24.h),

          CustomButton(
            text: AppStrings.saveLocation.tr,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class _LocationMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFF334155).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Horizontal roads
    canvas.drawLine(
      Offset(0, size.height * 0.35),
      Offset(size.width, size.height * 0.35),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.7),
      roadPaint,
    );
    // Vertical roads
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.7, size.height),
      roadPaint,
    );

    // Park area
    final parkPaint = Paint()
      ..color = const Color(0xFF86A789).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromLTWH(size.width * 0.1, size.height * 0.08, size.width * 0.18, size.height * 0.22),
      parkPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
            hintText: '+252 61 XXX XXXX',
            fillColor: AppColors.white,
            keyboardType: TextInputType.phone,
          ),
          Gap(16.h),

          _buildLabel(context, AppStrings.whatsappOptional.tr),
          Gap(8.h),
          CustomTextField(
            hintText: '+252 61 XXX XXXX',
            fillColor: AppColors.white,
            keyboardType: TextInputType.phone,
          ),
          Gap(24.h),

          CustomButton(
            text: AppStrings.saveContactInfo.tr,
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
