import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/features/influencer_all/influencer_task_screen/controller/influencer_task_controller.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import '../../influencer_task_screen/helper/influencer_task_helper.dart';
import '../helper/my_campaigns_helper.dart';

class MyCampaignCard extends StatelessWidget {
  final CampaignModel campaign;

  const MyCampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    final isCompleted = campaign.status == CampaignStatus.completed;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withValues(alpha: .12)),
      ),
      child: Row(
        children: [
          Container(
            height: 52.w,
            width: 52.w,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: .25),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Iconsax.video, color: AppColors.primaryColor),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  campaign.brand,
                  style: context.titleSmall.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  campaign.title,
                  style: context.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 4.h),
                Text(
                  isCompleted
                      ? AppStrings.completed.tr
                      : AppStrings.inProgress.tr,
                  style: context.bodySmall.copyWith(
                    color: isCompleted ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: 70.w,
            height: 42.h,
            child: CustomButton(
              text: AppStrings.view.tr,
              onTap: () {
                AppRouter.route.pushReplacementNamed(RoutePath.navigationPages);
                NavigationControllerMain.to.goToTabTasks();
                if (Get.isRegistered<InfluencerTaskController>()) {
                  InfluencerTaskController.to.selectedTab.value = isCompleted
                      ? InfluencerTaskTab.completed
                      : InfluencerTaskTab.active;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
