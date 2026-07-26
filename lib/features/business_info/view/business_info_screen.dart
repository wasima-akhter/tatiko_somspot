import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../../../share/controller/screen_export.dart';

class BusinessInfoScreen extends StatelessWidget {
  const BusinessInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.softBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.softBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: AppColors.darkTextColor,
          ),
        ),
        title: Text(
          "Business Info".tr,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel(context, "Legal Business Name".tr),
            Gap(8.h),
            CustomTextField(
              hintText: 'Hilib Macaan Restaurant LLC',
              fillColor: AppColors.white,
            ),
            Gap(20.h),
            _buildLabel(context, "Tax ID".tr),
            Gap(8.h),
            CustomTextField(
              hintText: 'SO-TAX-2845-99',
              fillColor: AppColors.white,
            ),
            Gap(20.h),
            _buildLabel(context, "Founded".tr),
            Gap(8.h),
            CustomTextField(
              hintText: '2018',
              fillColor: AppColors.white,
              keyboardType: TextInputType.number,
            ),
            Gap(20.h),
            _buildLabel(context, "Employees".tr),
            Gap(8.h),
            CustomTextField(
              hintText: '12',
              fillColor: AppColors.white,
              keyboardType: TextInputType.number,
            ),
            Gap(24.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.blueAccentColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.info_circle,
                    color: AppColors.blueAccentColor,
                    size: 20.sp,
                  ),
                  Gap(12.w),
                  Expanded(
                    child: Text(
                      "Changes to legal info may require verification.".tr,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.darkTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(32.h),
            CustomButton(
              text: "Save changes".tr,
              onTap: () {
                context.pop();
              },
            ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: context.titleMedium.copyWith(
        fontWeight: FontWeight.bold,
        color: AppColors.darkTextColor,
      ),
    );
  }
}
