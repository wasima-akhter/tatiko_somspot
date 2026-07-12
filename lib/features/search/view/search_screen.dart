import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/features/search/controller/search_controller.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class SearchScreen extends GetView<SearchScreenController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // White Header Container with Search Bar
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(24.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search",
                      style: context.titleLarge.copyWith(
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.sp,
                      ),
                    ),
                    Gap(16.h),
                    // Search Bar Field
                    Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: AppColors.bgSecondaryButtonColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.backgroundsLinesColor,
                          width: 1.w,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.search_normal,
                            color: AppColors.hintTextColor,
                            size: 20.sp,
                          ),
                          Gap(12.w),
                          Expanded(
                            child: TextField(
                              onSubmitted: (value) {
                                controller.addRecentSearch(value);
                              },
                              decoration: InputDecoration(
                                hintText: "Search businesses deals...",
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                hintStyle: context.bodyMedium.copyWith(
                                  color: AppColors.hintTextColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                              style: context.bodyMedium.copyWith(
                                color: AppColors.darkTextColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Blue background container details as per design
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                color: AppColors.primaryColor.withValues(alpha: 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recent Searches Row
                    Obx(() {
                      if (controller.rxRecentSearches.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.clock,
                                    color: AppColors.darkTextColor,
                                    size: 18.sp,
                                  ),
                                  Gap(8.w),
                                  Text(
                                    "Recent Searches",
                                    style: context.titleMedium.copyWith(
                                      color: AppColors.darkTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => controller.clearRecentSearches(),
                                child: Text(
                                  "Clear",
                                  style: context.bodyMedium.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(12.h),
                          // Chips wrap
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: controller.rxRecentSearches.map((item) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                    color: AppColors.backgroundsLinesColor,
                                    width: 1.w,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 8.h,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item,
                                      style: context.bodyMedium.copyWith(
                                        color: AppColors.darkTextColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          Gap(24.h),
                        ],
                      );
                    }),

                    // Trending Now Section
                    Row(
                      children: [
                        Icon(
                          Iconsax.trend_up,
                          color: AppColors.darkTextColor,
                          size: 18.sp,
                        ),
                        Gap(8.w),
                        Text(
                          "Trending Now",
                          style: context.titleMedium.copyWith(
                            color: AppColors.darkTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                    Gap(12.h),

                    // Trending List Cards
                    Obx(() {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.rxTrendingItems.length,
                        separatorBuilder: (context, index) => Gap(12.h),
                        itemBuilder: (context, index) {
                          final item = controller.rxTrendingItems[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 6.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(12.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 36.w,
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Iconsax.trend_up,
                                    color: AppColors.primaryColor,
                                    size: 18.sp,
                                  ),
                                ),
                                Gap(12.w),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: context.bodyLarge.copyWith(
                                      color: AppColors.darkTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Iconsax.arrow_right_3,
                                  color: AppColors.hintTextColor,
                                  size: 16.sp,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                    Gap(20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
