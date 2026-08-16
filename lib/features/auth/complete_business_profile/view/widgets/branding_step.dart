import 'dart:io';

import 'package:som_spot/features/auth/complete_business_profile/controller/complete_business_profile_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';

class BrandingStep extends StatelessWidget {
  const BrandingStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CompleteBusinessProfileController.to;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(8.h),

          // ── Title ──
          Text(
            AppStrings.addYourBranding.tr,
            style: context.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(8.h),

          // ── Subtitle ──
          Text(
            AppStrings.brandingSubtitle.tr,
            style: context.bodyLarge.copyWith(
              color: AppColors.subtitleTextColor,
              height: 1.5,
            ),
          ),
          Gap(24.h),

          // ── Cover Photo ──
          Text(
            AppStrings.coverPhoto.tr,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(4.h),
          Text(
            AppStrings.uploadCoverPhoto.tr,
            style: context.bodySmall.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
          Gap(12.h),

          Obx(() {
            final imagePath = controller.coverImagePath.value;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => controller.pickCoverImage(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: imagePath != null
                      ? null
                      : AppColors.primaryColor.withValues(alpha: 0.04),
                  border: imagePath != null
                      ? null
                      : Border.all(
                          color: AppColors.primaryColor.withValues(alpha: 0.3),
                          width: 1.5,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                  image: imagePath != null
                      ? DecorationImage(
                          image: FileImage(File(imagePath)),
                          fit: BoxFit.cover,
                        )
                      : null,
                  boxShadow: imagePath != null
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: imagePath != null
                    ? // Overlay with change button
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.all(12.r),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.camera,
                                size: 14.sp,
                                color: AppColors.white,
                              ),
                              Gap(6.w),
                              Text(
                                AppStrings.changePhoto.tr,
                                style: context.bodySmall.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : // Empty state
                      _UploadPlaceholder(
                        icon: Iconsax.image,
                        text: AppStrings.tapToUpload.tr,
                      ),
              ),
            );
          }),
          Gap(28.h),

          // ── Logo ──
          Text(
            AppStrings.logo.tr,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(4.h),
          Text(
            AppStrings.uploadLogo.tr,
            style: context.bodySmall.copyWith(
              color: AppColors.subtitleTextColor,
            ),
          ),
          Gap(12.h),

          Center(
            child: Obx(() {
              final imagePath = controller.logoImagePath.value;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => controller.pickLogoImage(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 120.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: imagePath != null
                        ? null
                        : AppColors.primaryColor.withValues(alpha: 0.04),
                    border: imagePath != null
                        ? Border.all(color: AppColors.primaryColor, width: 3)
                        : Border.all(
                            color: AppColors.primaryColor.withValues(
                              alpha: 0.3,
                            ),
                            width: 1.5,
                          ),
                    image: imagePath != null
                        ? DecorationImage(
                            image: FileImage(File(imagePath)),
                            fit: BoxFit.cover,
                          )
                        : null,
                    boxShadow: imagePath != null
                        ? [
                            BoxShadow(
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.15,
                              ),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: imagePath != null
                      ? // Camera overlay
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            padding: EdgeInsets.all(6.r),
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
                              size: 14.sp,
                              color: AppColors.white,
                            ),
                          ),
                        )
                      : // Empty state
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.gallery_add,
                              size: 28.sp,
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.6,
                              ),
                            ),
                            Gap(6.h),
                            Text(
                              AppStrings.logo.tr,
                              style: context.bodySmall.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                ),
              );
            }),
          ),
          Gap(32.h),
        ],
      ),
    );
  }
}

class _UploadPlaceholder extends StatelessWidget {
  final IconData icon;
  final String text;

  const _UploadPlaceholder({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 32.sp, color: AppColors.primaryColor),
        ),
        Gap(12.h),
        Text(
          text,
          style: context.bodyMedium.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(4.h),
        Text(
          'JPG, PNG',
          style: context.bodySmall.copyWith(color: AppColors.hintTextColor),
        ),
      ],
    );
  }
}
