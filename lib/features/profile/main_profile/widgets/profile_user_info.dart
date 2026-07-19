import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';

import '../../../../helper/text_utils/string_extension.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../../utils/extension/base_extension.dart';
import '../controller/profile_controller.dart';

class ProfileUserInfo extends StatelessWidget {
  const ProfileUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfileScreenController.to;

    return Obx(() {
      return ApiStatusBuilder(
        status: controller.profileLoading.value,
        errorMessage: controller.errorMessage.value,
        onRetry: controller.getProfile,
        builder: (context) => Row(
          children: [
            Container(
              width: 56.w,
              height: 56.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.w),
              ),
              child: ClipOval(
                child: controller.userAvatar.value.isEmpty
                    ? Icon(Iconsax.user, color: Colors.white, size: 30.sp)
                    : CustomNetworkImage(
                        imageUrl: controller.userAvatar.value,
                        boxShape: BoxShape.circle,
                      ),
              ),
            ),

            Gap(12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.userName.value.capitalizeWords(),
                    style: context.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(2.h),

                  Text(
                    controller.userEmail.value,
                    style: context.bodyMedium.copyWith(
                      color: Colors.white.withValues(alpha: .85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
