import '../../../../../share/controller/screen_export.dart';
import '../../../../../utils/enum/app_enum.dart';
import '../../controller/search_controller.dart';

Widget buildTrendingSearches(BuildContext context) {
  return const TrendingSearchesSection();
}

class TrendingSearchesSection extends StatelessWidget {
  const TrendingSearchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = SearchScreenController.to;

      if (controller.trendingSearchStatus.value == ApiStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.trendingSearches.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TrendingSearchesHeader(),
          Gap(12.h),
          const TrendingSearchesList(),
          Gap(20.h),
        ],
      );
    });
  }
}

class TrendingSearchesHeader extends StatelessWidget {
  const TrendingSearchesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Iconsax.trend_up, color: AppColors.darkTextColor, size: 18.sp),
        Gap(8.w),
        Text(
          "Trending Now",
          style: context.titleMedium.copyWith(
            color: AppColors.darkTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}

class TrendingSearchesList extends StatelessWidget {
  const TrendingSearchesList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SearchScreenController.to;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.trendingSearches.length,
      separatorBuilder: (_, _) => Gap(10.h),
      itemBuilder: (context, index) {
        final item = controller.trendingSearches[index];

        return TrendingSearchItem(
          term: item.term,
          count: item.count,
          onTap: () {
            controller.search(item.term);
          },
        );
      },
    );
  }
}

class TrendingSearchItem extends StatelessWidget {
  const TrendingSearchItem({
    super.key,
    required this.term,
    required this.count,
    required this.onTap,
  });

  final String term;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Iconsax.trend_up,
                color: AppColors.primaryColor,
                size: 18.sp,
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Text(
                term,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.bodyLarge.copyWith(
                  color: AppColors.darkTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
            if (count > 0) ...[
              Text(
                "$count",
                style: context.bodySmall.copyWith(
                  color: AppColors.hintTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(8.w),
            ],
            Icon(
              Iconsax.arrow_right_3,
              color: AppColors.hintTextColor,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
