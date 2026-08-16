import 'package:som_spot/share/export/screen_export.dart';

import '../../../controller/customer_business_details_controller.dart';

class MerchantAboutRating extends StatelessWidget {
  const MerchantAboutRating({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;

    return Obx(() {
      final business = controller.business.value;

      if (business == null || business.ratingCount <= 0) {
        return const SizedBox.shrink();
      }

      return Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: Row(
          children: [
            Icon(Icons.star_rounded, color: Colors.amber, size: 22.sp),

            Gap(6.w),

            Text(
              business.ratingAvg.toStringAsFixed(1),
              style: context.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextColor,
              ),
            ),

            Gap(6.w),

            Text(
              '(${business.ratingCount} ${AppStrings.reviews.tr})',
              style: context.bodySmall.copyWith(
                color: AppColors.subtitleTextColor,
              ),
            ),
          ],
        ),
      );
    });
  }
}
