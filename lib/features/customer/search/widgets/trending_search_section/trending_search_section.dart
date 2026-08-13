import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';

import '../../../../../share/controller/screen_export.dart';
import '../../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../controller/search_controller.dart';

Widget buildTrendingSearches(BuildContext context) {
  return const TrendingSearchesSection();
}

class TrendingSearchesSection extends StatelessWidget {
  const TrendingSearchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SearchScreenController.to;

    return Obx(() {
      return ApiStatusBuilder(
        status: controller.trendingSearchStatus.value,
        errorMessage: controller.trendingSearchErrorMessage.value,
        onRetry: controller.loadTrendingSearches,
        loadingWidget: const TrendingSearchesSectionShimmer(),
        noDataWidget: const SizedBox.shrink(),
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TrendingSearchesHeader(),
              Gap(12.h),
              const TrendingSearchesList(),
              Gap(20.h),
            ],
          );
        },
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

class TrendingSearchesSectionShimmer extends StatelessWidget {
  const TrendingSearchesSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildHeader(), Gap(12.h), _buildItems(), Gap(20.h)],
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        _shimmerBox(width: 18.sp, height: 18.sp, radius: 4.r),
        Gap(8.w),
        _shimmerBox(width: 105.w, height: 15.h, radius: 4.r),
      ],
    );
  }

  Widget _buildItems() {
    return Column(
      children: [
        _buildItem(termWidth: 110.w, countWidth: 20.w),
        Gap(10.h),
        _buildItem(termWidth: 145.w, countWidth: 24.w),
        Gap(10.h),
        _buildItem(termWidth: 95.w, countWidth: 18.w),
        Gap(10.h),
        _buildItem(termWidth: 130.w, countWidth: 22.w),
      ],
    );
  }

  Widget _buildItem({required double termWidth, required double countWidth}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
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
      child: Row(
        children: [
          _shimmerBox(width: 36.w, height: 36.w, radius: 8.r),

          Gap(12.w),

          Expanded(
            child: _shimmerBox(width: termWidth, height: 14.h, radius: 4.r),
          ),

          Gap(12.w),

          _shimmerBox(width: countWidth, height: 12.h, radius: 4.r),

          Gap(8.w),

          _shimmerBox(width: 16.sp, height: 16.sp, radius: 4.r),
        ],
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    required double radius,
  }) {
    return AutoShimmerAnimate(
      isLoading: true,
      baseColor: AppColors.navBarColor.withValues(alpha: 0.1),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.grayTabBgColor,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
