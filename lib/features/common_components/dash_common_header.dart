import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/router/route_path.dart';
import '../../utils/app_strings/app_strings.dart';
import '../../utils/color/app_colors.dart';
import '../../utils/extension/base_extension.dart';

class DashboardCommonHeaderSec extends StatelessWidget {
  const DashboardCommonHeaderSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  ),
                ),
                Gap(12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.goodMorning.tr,
                      style: context.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    Text(
                      'Jorge Walton',
                      style: context.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(RoutePath.alertScreen);
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
              child: Text(
                'Maka Al Mukarama, Mogadishu',
                style: context.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
