import 'package:som_spot/features/claims/controller/claims_controller.dart';
import 'package:som_spot/features/claims/widgets/offer_claimed_dialog.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../share/controller/screen_export.dart';

class ClaimsScreen extends StatelessWidget {
  const ClaimsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClaimsController());

    return ScaffoldWrapper(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(AppStrings.myClaims.tr),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            children: [
              Gap(12.h),

              // Switch Tab Capsule Bar (Businesses / Offers Style)
              Container(
                height: 48.h,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: AppColors.backgroundsLinesColor,
                    width: 1,
                  ),
                ),
                child: Obx(() {
                  final isTab0 = controller.tabIndex.value == 0;
                  return Row(
                    children: [
                      // Active Tab
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeTab(0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isTab0
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              AppStrings.active.tr,
                              style: context.bodyMedium.copyWith(
                                color: isTab0
                                    ? Colors.white
                                    : AppColors.subtitleTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Expired Tab
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.changeTab(1),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: !isTab0
                                  ? AppColors.primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              AppStrings.expired.tr,
                              style: context.bodyMedium.copyWith(
                                color: !isTab0
                                    ? Colors.white
                                    : AppColors.subtitleTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Gap(24.h),

              // Scrollable Claims Content
              Expanded(
                child: Obx(() {
                  final isTab0 = controller.tabIndex.value == 0;
                  final list = isTab0
                      ? controller.activeClaims
                      : controller.expiredClaims;

                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.ticket_expired,
                            color: AppColors.hintTextColor,
                            size: 48.sp,
                          ),
                          Gap(12.h),
                          Text(
                            "No claims found",
                            style: context.titleSmall.copyWith(
                              color: AppColors.subtitleTextColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: list.length,
                    padding: EdgeInsets.only(bottom: 20.h),
                    itemBuilder: (context, index) {
                      final claim = list[index];
                      return _buildClaimCard(context, claim);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClaimCard(BuildContext context, ClaimItem claim) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.backgroundsLinesColor.withValues(alpha: 0.8),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Opacity(
        opacity: claim.isActive ? 1.0 : 0.65,
        child: Row(
          children: [
            // Business Image Left
            Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.backgroundsLinesColor,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11.r),
                child: CustomNetworkImage(imageUrl: claim.businessImage),
              ),
            ),
            Gap(12.w),

            // Claim Details Center
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    claim.businessName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall.copyWith(
                      color: AppColors.subtitleTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 11.sp,
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    claim.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleSmall.copyWith(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                  Gap(4.h),
                  Row(
                    children: [
                      Icon(
                        Iconsax.clock,
                        size: 12.sp,
                        color: claim.isActive
                            ? Colors.red.shade400
                            : AppColors.hintTextColor,
                      ),
                      Gap(4.w),
                      Text(
                        claim.expireDate,
                        style: context.bodySmall.copyWith(
                          color: claim.isActive
                              ? Colors.red.shade400
                              : AppColors.hintTextColor,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(12.w),

            // View Action Button Right
            if (claim.isActive)
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => OfferClaimedDialog(
                      claimCode: claim.claimCode,
                      businessName: claim.businessName,
                      offerTitle: claim.title,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 70.w,
                  height: 32.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    AppStrings.view.tr,
                    style: context.titleSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              )
            else
              Container(
                width: 70.w,
                height: 32.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.backgroundsLinesColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  AppStrings.expired.tr,
                  style: context.titleSmall.copyWith(
                    color: AppColors.hintTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
