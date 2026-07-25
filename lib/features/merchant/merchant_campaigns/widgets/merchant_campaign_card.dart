import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';

import '../../../../share/controller/screen_export.dart';
import '../modules/merchant_campaign_tag.dart';

class MerchantCampaignCard extends StatelessWidget {
  final Map<String, dynamic> campaign;

  const MerchantCampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          AppRouter.route.pushNamed(RoutePath.merchantCampaignDetailsScreen),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),

        padding: EdgeInsets.all(12.w),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(14.r),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 10,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    campaign["title"],

                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                MerchantCampaignStatusTag(status: campaign["status"]),
              ],
            ),

            Gap(4.h),

            Text(
              campaign["type"],
              style: context.bodySmall.copyWith(
                color: AppColors.subtitleTextColor,
              ),
            ),

            Gap(12.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("Budget spent", style: context.bodySmall),

                Text(
                  campaign["budgetSpent"],
                  style: context.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Gap(6.h),

            LinearProgressIndicator(
              value: .5,

              backgroundColor: AppColors.backgroundsLinesColor,

              color: AppColors.primaryColor,
            ),

            Gap(10.h),

            Row(
              children: [
                Icon(
                  Iconsax.people,
                  size: 14.sp,
                  color: AppColors.primaryColor,
                ),

                Gap(4.w),

                Text(campaign["applicants"], style: context.bodySmall),

                Gap(12.w),

                Icon(Iconsax.clock, size: 14.sp),

                Gap(4.w),

                Text(campaign["daysLeft"], style: context.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
