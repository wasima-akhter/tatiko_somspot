import 'package:som_spot/share/controller/screen_export.dart';

import '../controller/offer_controller.dart';
import '../../shared/helper/offer_helper.dart';

class OffersHeader extends StatelessWidget {
  const OffersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OffersController.to;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + 16.h,
        left: 20.w,
        right: 20.w,
        bottom: 24.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.offers.tr,
                style: context.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.blueAccentColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IconButton(
                  onPressed: () {
                    AppRouter.route.pushNamed(RoutePath.createOfferScreen);
                  },
                  icon: const Icon(Icons.add, color: AppColors.white),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.w),
                ),
              ),
            ],
          ),
          Gap(20.h),

          SizedBox(
            height: 42.h,
            child: Stack(
              children: [
                Obx(
                  () => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    controller: controller.tabScrollController,
                    child: Row(
                      children: OfferStatus.values.map((status) {
                        return Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: _buildTabPill(
                            context: context,
                            title: status.title,
                            count: (controller.statusCounts[status] ?? 0)
                                .toString(),
                            isActive: controller.selectedStatus.value == status,
                            onTap: () => controller.changeStatus(status),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                Obx(
                  () =>
                      controller.showLeft.value ? LeftFade() : const SizedBox(),
                ),

                Obx(
                  () => controller.showRight.value
                      ? RightFade()
                      : const SizedBox(),
                ),

                /// Left fade

                /// Right fade
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabPill({
    required BuildContext context,
    required String title,
    required String count,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.blueAccentColor
              : AppColors.softBackgroundColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: context.bodyMedium.copyWith(
                color: isActive ? AppColors.white : AppColors.darkTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.white.withValues(alpha: 0.2)
                    : AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                count,
                style: context.bodySmall.copyWith(
                  color: isActive
                      ? AppColors.white
                      : AppColors.subtitleTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeftFade extends StatelessWidget {
  const LeftFade({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: 24.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.white, AppColors.white.withValues(alpha: 0)],
            ),
          ),

          // child: Icon(Icons.arrow_back_ios),
        ),
      ),
    );
  }
}

class RightFade extends StatelessWidget {
  const RightFade({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 24.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [AppColors.white, AppColors.white.withValues(alpha: 0)],
            ),
          ),
        ),
      ),
    );
  }
}
