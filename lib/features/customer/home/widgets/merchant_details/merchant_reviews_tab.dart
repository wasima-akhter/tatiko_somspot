import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/customer/home/controller/merchant_details_controller.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/widgets/dialog/custom_dialog.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class MerchantReviewsTab extends StatelessWidget {
  final MerchantDetailsController controller;

  const MerchantReviewsTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Score summary and "Write Review" row
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "4.8",
                          style: context.headlineLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkTextColor,
                          ),
                        ),
                        Gap(8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < 4
                                      ? Icons.star
                                      : Icons.star_half_rounded,
                                  color: AppColors.orangeSecondaryAccentColor,
                                  size: 16.sp,
                                );
                              }),
                            ),
                            Gap(4.h),
                            Text(
                              "124 ${AppStrings.reviewsLabel.tr}",
                              style: context.bodySmall.copyWith(
                                color: AppColors.subtitleTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _showWriteReviewDialog(context, controller),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    side: const BorderSide(color: AppColors.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                  ),
                  child: Text(
                    AppStrings.writeReview.tr,
                    style: context.bodySmall.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(12.h),

          // Reviews List
          Obx(() {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: controller.reviews.length,
              separatorBuilder: (context, index) => Gap(16.h),
              itemBuilder: (context, index) {
                final review = controller.reviews[index];
                return Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Row
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage: NetworkImage(review.userAvatar),
                          ),
                          Gap(12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.userName,
                                  style: context.bodyMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.darkTextColor,
                                  ),
                                ),
                                Gap(2.h),
                                Text(
                                  review.dateAgo,
                                  style: context.bodySmall.copyWith(
                                    color: AppColors.subtitleTextColor,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: List.generate(5, (starIdx) {
                              return Icon(
                                Icons.star,
                                color: starIdx < review.rating.floor()
                                    ? AppColors.orangeSecondaryAccentColor
                                    : AppColors.backgroundsLinesColor,
                                size: 14.sp,
                              );
                            }),
                          ),
                        ],
                      ),
                      Gap(12.h),
                      // Content
                      Text(
                        review.content,
                        style: context.bodyMedium.copyWith(
                          color: AppColors.darkTextColor,
                          height: 1.4,
                        ),
                      ),
                      Gap(12.h),
                      // Helpful Button
                      GestureDetector(
                        onTap: () => controller.toggleHelpful(review.id),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: review.isHelpful
                                ? AppColors.primaryColor.withValues(alpha: 0.1)
                                : AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.thumb_up_alt_outlined,
                                size: 14.sp,
                                color: review.isHelpful
                                    ? AppColors.primaryColor
                                    : AppColors.subtitleTextColor,
                              ),
                              Gap(6.w),
                              Text(
                                "${AppStrings.helpful.tr} (${review.helpfulCount})",
                                style: context.bodySmall.copyWith(
                                  color: review.isHelpful
                                      ? AppColors.primaryColor
                                      : AppColors.subtitleTextColor,
                                  fontWeight: review.isHelpful
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  void _showWriteReviewDialog(
    BuildContext context,
    MerchantDetailsController controller,
  ) {
    final nameController = TextEditingController();
    final contentController = TextEditingController();
    double currentRating = 5.0;

    AppDialog.show(
      context: context,
      type: AppDialogType.custom,
      title: AppStrings.writeAReview.tr,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      borderRadius: 16.r,
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(8.h),
              // Rating selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starVal = index + 1.0;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentRating = starVal;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: Icon(
                        Icons.star,
                        color: starVal <= currentRating
                            ? AppColors.orangeSecondaryAccentColor
                            : AppColors.backgroundsLinesColor,
                        size: 32.sp,
                      ),
                    ),
                  );
                }),
              ),
              Gap(20.h),

              // Name Field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: AppStrings.yourName.tr,
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
              Gap(12.h),

              // Review Content Field
              TextField(
                controller: contentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: AppStrings.tellUsExperience.tr,
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(16.r),
                ),
              ),
              Gap(24.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (contentController.text.trim().isEmpty) {
                      AppToast.error(
                        context: context,
                        message: AppStrings.enterReviewContent.tr,
                      );
                      return;
                    }
                    controller.addReview(
                      nameController.text,
                      currentRating,
                      contentController.text,
                    );
                    Navigator.of(context).pop();
                    AppToast.success(
                      context: context,
                      message: AppStrings.reviewAdded.tr,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.submitReview.tr,
                    style: context.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
