import '../../../share/export/screen_export.dart';

class SubscriptionKeyConceptBanner extends StatelessWidget {
  const SubscriptionKeyConceptBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.backgroundsLinesColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.lamp_on,
                color: AppColors.amberYellowColor,
                size: 22.sp,
              ),
              Gap(8.w),
              Text(
                'Key Concept'.tr,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
            ],
          ),
          Gap(16.h),
          _buildConceptRow(
            context,
            Iconsax.flash_1,
            AppColors.orangeColor,
            'Hot Deals',
            'drive engagement with your customers.'.tr,
          ),
          Gap(12.h),
          _buildConceptRow(
            context,
            Iconsax.star1,
            AppColors.purpleAccentColor,
            'Influencers',
            'drive high-impact business acquisition.'.tr,
          ),
          Gap(12.h),
          _buildConceptRow(
            context,
            Iconsax.crown1,
            AppColors.blueAccentColor,
            'Subscriptions',
            'drive continuous recurring revenue.'.tr,
          ),
        ],
      ),
    );
  }

  Widget _buildConceptRow(
    BuildContext context,
    IconData icon,
    Color color,
    String title,
    String desc,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 2.h),
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14.sp, color: color),
        ),
        Gap(12.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title ',
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextColor,
                  ),
                ),
                TextSpan(
                  text: desc,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
