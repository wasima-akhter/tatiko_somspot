import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

class AnalyticsHeader extends StatefulWidget {
  const AnalyticsHeader({super.key});

  @override
  State<AnalyticsHeader> createState() => _AnalyticsHeaderState();
}

class _AnalyticsHeaderState extends State<AnalyticsHeader> {
  final ValueNotifier<int> _selectedTabIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    _selectedTabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Text(
            AppStrings.analytics.tr,
            style: context.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(20.h),
          ValueListenableBuilder<int>(
            valueListenable: _selectedTabIndex,
            builder: (context, selectedIndex, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildTabPill(
                      context: context,
                      title: AppStrings.last7Days.tr,
                      isActive: selectedIndex == 0,
                      onTap: () => _selectedTabIndex.value = 0,
                    ),
                    Gap(12.w),
                    _buildTabPill(
                      context: context,
                      title: AppStrings.last30Days.tr,
                      isActive: selectedIndex == 1,
                      onTap: () => _selectedTabIndex.value = 1,
                    ),
                    Gap(12.w),
                    _buildTabPill(
                      context: context,
                      title: AppStrings.last90Days.tr,
                      isActive: selectedIndex == 2,
                      onTap: () => _selectedTabIndex.value = 2,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabPill({
    required BuildContext context,
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.blueAccentColor : AppColors.softBackgroundColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          title,
          style: context.bodyMedium.copyWith(
            color: isActive ? AppColors.white : AppColors.subtitleTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
