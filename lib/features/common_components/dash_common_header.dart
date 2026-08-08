import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../helper/text_utils/string_helper.dart';
import '../../share/controller/screen_export.dart';
import '../../share/widgets/network_image/custom_network_image.dart';

class DashboardHeaderModel {
  final RxString userName;
  final RxString userProfileImage;
  final RxString userAddress;

  DashboardHeaderModel({
    required this.userName,
    required this.userProfileImage,
    required this.userAddress,
  });
}

class DashboardCommonHeaderSec extends StatelessWidget {
  final DashboardHeaderModel data;

  const DashboardCommonHeaderSec({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Obx(
                    () => Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.w),
                      ),
                      child: ClipOval(
                        child: CustomNetworkImage(
                          imageUrl: data.userProfileImage.value,
                          boxShape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  Gap(12.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getGreeting(),
                          style: context.bodySmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),

                        Obx(
                          () => Text(
                            data.userName.value.isEmpty
                                ? AppStrings.user.tr.toUpperCase()
                                : data.userName.value.capitalizeWords(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.titleLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                AppRouter.route.pushNamed(RoutePath.alertScreen);
              },
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Badge(
                  backgroundColor: AppColors.redColor,
                  smallSize: 8,
                  child: Icon(
                    Iconsax.notification,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),

        Gap(16.h),

        Row(
          children: [
            Icon(
              Iconsax.location,
              color: Colors.white.withValues(alpha: 0.9),
              size: 16.sp,
            ),

            Gap(6.w),

            Expanded(
              child: Obx(
                () => Text(
                  data.userAddress.value.isEmpty
                      ? AppStrings.loadingLocation.tr
                      : data.userAddress.value,
                  style: context.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Shimmer
class DashboardCommonHeaderSecShimmer extends StatelessWidget {
  const DashboardCommonHeaderSecShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipOval(
                  child: AutoShimmerAnimate(
                    isLoading: true,
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                Gap(12.w),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getGreeting(),
                      style: context.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),

                    Gap(6.h),

                    AutoShimmerAnimate(
                      isLoading: true,
                      child: Container(
                        width: 120.w,
                        height: 18.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Badge(
                backgroundColor: AppColors.redColor,
                smallSize: 8,
                child: Icon(
                  Iconsax.notification,
                  size: 20.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        Gap(16.h),

        Row(
          children: [
            Icon(
              Iconsax.location,
              color: Colors.white.withValues(alpha: 0.9),
              size: 16.sp,
            ),
            Gap(6.w),
            Expanded(
              child: AutoShimmerAnimate(
                isLoading: true,
                child: Container(
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
