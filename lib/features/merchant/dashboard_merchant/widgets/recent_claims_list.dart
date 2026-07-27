import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../response/dashboard_merchant_response.dart';

class RecentClaimsList extends StatelessWidget {
  final List<RecentClaim> claims;
  final bool isLoading;

  const RecentClaimsList({
    super.key,
    required this.claims,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading && claims.isEmpty) {
      return const EmptyRecentClaims();
    }

    return Column(
      children: List.generate(claims.length, (index) {
        final claim = claims[index];

        return Column(
          children: [
            _buildRecentClaimItem(
              context: context,
              title: claim.title,
              subtitle: claim.customerName != null
                  ? 'Claimed by ${claim.customerName}'
                  : '',
              isLoading: isLoading,
            ),

            if (index != claims.length - 1) Gap(12.h),
          ],
        );
      }),
    );
  }

  Widget _buildRecentClaimItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool isLoading,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Row(
        children: [
          AutoShimmerAnimate(
            isLoading: isLoading,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                color: AppColors.softSlateBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.tag,
                color: AppColors.slateIconColor,
                size: 20.sp,
              ),
            ),
          ),

          Gap(12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoShimmerAnimate(
                  isLoading: isLoading,
                  child: Text(
                    title.isEmpty
                        ? 'Loading claim title'
                        : title.capitalizeWords(),
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                ),

                Gap(4.h),

                AutoShimmerAnimate(
                  isLoading: isLoading,
                  child: Text(
                    subtitle.isEmpty
                        ? 'Claimed by customer'
                        : subtitle.capitalizeWords(),
                    style: context.bodySmall.copyWith(
                      color: AppColors.subtitleTextColor,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Gap(8.w),

          AutoShimmerAnimate(
            isLoading: isLoading,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.emeraldGreenColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                AppStrings.justNow.tr,
                style: context.bodySmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.emeraldGreenColor,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyRecentClaims extends StatelessWidget {
  const EmptyRecentClaims({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: AppColors.softSlateBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.receipt_item,
              size: 24.sp,
              color: AppColors.slateIconColor,
            ),
          ),

          Gap(12.h),

          Text(
            "No Recent Claims",
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextColor,
            ),
          ),

          Gap(4.h),

          Text(
            "Claims from your offers will appear here.",
            textAlign: TextAlign.center,
            style: context.bodySmall.copyWith(
              color: AppColors.subtitleTextColor,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
