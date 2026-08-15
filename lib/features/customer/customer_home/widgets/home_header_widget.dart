import 'package:som_spot/features/customer/customer_home/controller/home_controller.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../helper/text_utils/string_helper.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(
        16.w,
        MediaQuery.of(context).padding.top + 16.h,
        16.w,
        24.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Profile Image - reactive
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
                      imageUrl: controller.userProfileImage.value,
                      boxShape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Gap(12.w),
              // Greeting Text - reactive
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getGreeting(),
                      style: context.bodyMedium.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap(2.h),
                    Obx(
                      () => Text(
                        controller.userName.value,
                        style: context.titleLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Notification Bell
              GestureDetector(
                onTap: () => AppRouter.route.pushNamed(RoutePath.alertScreen),
                child: Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Iconsax.notification,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                      Positioned(
                        top: 12.h,
                        right: 12.w,
                        child: Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Gap(16.h),
          // Location Row - reactive
          Row(
            children: [
              Icon(Iconsax.location, color: Colors.white, size: 18.sp),
              Gap(6.w),
              Expanded(
                child: Obx(
                  () => Text(
                    controller.userAddress.value,
                    style: context.bodyMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(16.h),
          // Search Row
          GestureDetector(
            onTap: () => NavigationControllerMain.to.selectedNavIndex.value = 1,
            child: Container(
              height: 52.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Icon(
                    Iconsax.search_normal,
                    color: AppColors.hintTextColor,
                    size: 20.sp,
                  ),
                  Gap(8.w),
                  Expanded(child: Text(AppStrings.searchPlaceholder.tr)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
