import 'package:som_spot/features/auth/complete_business_profile/controller/complete_business_profile_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

class ContactStep extends StatelessWidget {
  const ContactStep({super.key});

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
            AppStrings.howCanCustomersReachYou.tr,
            style: context.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(8.h),

          // ── Subtitle ──
          Text(
            AppStrings.contactSubtitle.tr,
            style: context.bodyLarge.copyWith(
              color: AppColors.subtitleTextColor,
              height: 1.5,
            ),
          ),
          Gap(24.h),

          // ── Contact Illustration ──
          Center(
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.call5,
                  size: 40.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          Gap(28.h),

          // ── Business Phone ──
          CustomTextField(
            controller: controller.phoneController,
            title: AppStrings.businessPhone.tr,
            hintText: AppStrings.enterBusinessPhone.tr,
            keyboardType: TextInputType.phone,
            onChanged: (_) => controller.syncWhatsApp(),
            prefixIcon: Icon(
              Iconsax.call,
              size: 20.sp,
              color: AppColors.hintTextColor,
            ),
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: AppColors.backgroundsLinesColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
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

          // ── WhatsApp Number ──
          Obx(
            () => CustomTextField(
              controller: controller.whatsAppController,
              title: AppStrings.whatsappNumber.tr,
              hintText: AppStrings.enterWhatsappNumber.tr,
              keyboardType: TextInputType.phone,
              readOnly: controller.sameAsPhone.value,
              prefixIcon: Icon(
                Icons.chat_outlined,
                size: 20.sp,
                color: controller.sameAsPhone.value
                    ? AppColors.hintTextColor.withValues(alpha: 0.5)
                    : AppColors.hintTextColor,
              ),
              fillColor: controller.sameAsPhone.value
                  ? AppColors.grayTabBgColor
                  : AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: AppColors.backgroundsLinesColor,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
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
          ),
          Gap(12.h),

          // ── Same as phone checkbox ──
          Obx(
            () => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () =>
                  controller.sameAsPhone.value = !controller.sameAsPhone.value,
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 22.h,
                    width: 22.w,
                    decoration: BoxDecoration(
                      color: controller.sameAsPhone.value
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: controller.sameAsPhone.value
                            ? AppColors.primaryColor
                            : AppColors.linesDarkColor,
                        width: 1.5,
                      ),
                    ),
                    child: controller.sameAsPhone.value
                        ? Icon(Icons.check, size: 14.sp, color: AppColors.white)
                        : null,
                  ),
                  Gap(10.w),
                  Text(
                    AppStrings.sameAsPhone.tr,
                    style: context.bodyMedium.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(32.h),
        ],
      ),
    );
  }
}
