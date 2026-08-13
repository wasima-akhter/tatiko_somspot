import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/features/customer/customer_business_details/controller/customer_business_details_controller.dart';

import '../../../../../share/controller/screen_export.dart';
import '../../response/customer_search_response.dart';
import 'search_result_info.dart';
import 'search_result_logo.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({super.key, required this.item});
  final CustomerSearchResultModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Get.isRegistered<CustomerBusinessDetailsController>()) {
          Get.delete<CustomerBusinessDetailsController>();
        }
        AppRouter.route.pushNamed(
          RoutePath.customerBusinessDetailsScreen,

          extra: item.id,
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 8.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Row(
          children: [
            SearchResultLogo(imageUrl: item.logo),
            Gap(12.w),
            Expanded(child: SearchResultInfo(item: item)),
            Gap(6.w),
            Icon(
              Iconsax.arrow_right_3,
              color: AppColors.hintTextColor,
              size: 17.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultCardShimmer extends StatelessWidget {
  const SearchResultCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 8.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildLogo(),

          Gap(12.w),

          Expanded(child: _buildInfo()),

          Gap(6.w),

          _shimmerBox(width: 17.sp, height: 17.sp, radius: 4.r),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return _shimmerBox(width: 56.w, height: 56.w, radius: 10.r);
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Business name
        _shimmerBox(width: 135.w, height: 14.h, radius: 4.r),

        Gap(8.h),

        // Category / location
        _shimmerBox(width: 95.w, height: 11.h, radius: 4.r),

        Gap(7.h),

        // Additional information
        _shimmerBox(width: 115.w, height: 10.h, radius: 4.r),
      ],
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

class SearchResultsShimmer extends StatelessWidget {
  const SearchResultsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
      itemCount: 3,
      separatorBuilder: (_, _) => Gap(12.h),
      itemBuilder: (_, _) => const SearchResultCardShimmer(),
    );
  }
}
