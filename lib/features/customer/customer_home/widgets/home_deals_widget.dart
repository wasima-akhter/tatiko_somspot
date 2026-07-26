import 'package:som_spot/features/customer/customer_home/controller/home_deals_controller.dart';
import 'package:som_spot/features/customer/customer_home/widgets/home_shimmer_widgets.dart';
import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

class HomeDealsWidget extends StatelessWidget {
  const HomeDealsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeDealsController.to;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.todaysBestDeals.tr,
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkTextColor,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                AppStrings.seeAll.tr,
                style: context.bodyMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Gap(16.h),
        Obx(() {
          if (controller.isLoading.value) {
            return const BestDealShimmer();
          }

          if (controller.bestDeals.isEmpty) {
            return Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Center(
                child: Text(
                  "No deals available today",
                  style: context.bodyMedium.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ),
            );
          }

          final bestDeal = controller.bestDeals.first;

          return Container(
            height: 180.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CustomNetworkImage(
                    imageUrl: bestDeal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  // Play Icon Overlay (optional visual feature)
                  if (bestDeal.videoUrl != null)
                    Center(
                      child: Container(
                        width: 56.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.primaryColor,
                          size: 36.sp,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
