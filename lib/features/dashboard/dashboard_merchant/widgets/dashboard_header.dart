import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../common_components/dash_common_header.dart';
import '../../../common_components/dash_common_header_cont.dart';
import '../controller/dashboard_merchant_controller.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardMerchantController.to;
    final profileController = controller.profileController;
    return DashCommonHeaderCont(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => ApiStatusBuilder(
              status: profileController.profileLoading.value,
              errorMessage: profileController.errorMessage.value,
              onRetry: profileController.getProfile,
              builder: (_) {
                return DashboardCommonHeaderSec(
                  data: DashboardHeaderModel(
                    userName: controller.userName,
                    userProfileImage: controller.userProfileImage,
                    userAddress: controller.userAddress,
                  ),
                );
              },
            ),
          ),
          Gap(16.h),
          _CreateOfferSection(),
        ],
      ),
    );
  }
}

class _CreateOfferSection extends StatelessWidget {
  const _CreateOfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => AppRouter.route.pushNamed(RoutePath.createOfferScreen),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.1),
          side: const BorderSide(color: Colors.white, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: 18.sp),
            Gap(8.w),
            Text(
              AppStrings.createOffer.tr,
              style: context.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
