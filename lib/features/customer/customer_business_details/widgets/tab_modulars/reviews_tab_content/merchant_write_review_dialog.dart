import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/dialog/custom_dialog.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../controller/customer_business_details_controller.dart';

class MerchantWriteReviewDialog {
  const MerchantWriteReviewDialog._();

  static void show(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;
    final contentController = TextEditingController();
    double currentRating = 5.0;

    AppDialog.show(
      context: context,
      type: AppDialogType.custom,
      title: AppStrings.writeAReview.tr,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      borderRadius: 16.r,
      maxWidth: 500.w,
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(8.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starVal = index + 1.0;

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
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

              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () async {
                    final content = contentController.text.trim();

                    if (content.isEmpty) {
                      AppToast.error(
                        context: context,
                        message: AppStrings.enterReviewContent.tr,
                      );
                      return;
                    }

                    final success = await controller.postReview(
                      rating: currentRating,
                      review: content,
                    );

                    if (!context.mounted) return;

                    Navigator.of(context).pop();

                    if (success) {
                      AppToast.success(
                        context: context,
                        message: AppStrings.reviewAdded.tr,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Obx(
                    () => controller.postReviewStatus.value == ApiStatus.loading
                        ? const LoadingWidget()
                        : Text(
                            AppStrings.submitReview.tr,
                            style: context.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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
