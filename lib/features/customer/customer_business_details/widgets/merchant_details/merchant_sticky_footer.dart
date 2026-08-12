import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/customer/customer_business_details/shared/model/customer_buiness_details_model.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../../../../../helper/launcher/launcher_helper.dart';
import '../../../../../share/widgets/custom_buttom_sheet/custom_buttom_sheet.dart';
import '../../controller/customer_business_details_controller.dart';

class MerchantStickyFooter extends GetView<CustomerBusinessDetailsController> {
  const MerchantStickyFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.businessStatus.value,
        errorMessage: controller.businessErrorMessage.value,
        onRetry: controller.refreshBusinessDetails,
        builder: (_) {
          final business = controller.business.value!;

          return _buildFooter(context, business: business);
        },
      ),
    );
  }

  Widget _buildFooter(
    BuildContext context, {
    required BusinessDetailsModel business,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: AppColors.backgroundsLinesColor),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewPadding.bottom,
        ),
        child: Row(
          children: [
            // ============================================================
            // Call Button
            // ============================================================
            Expanded(
              child: SizedBox(
                height: 52.h,
                child: OutlinedButton(
                  onPressed: business.phone.trim().isEmpty
                      ? null
                      : () async {
                          AppToast.info(
                            context: context,
                            message:
                                "${AppStrings.calling.tr} ${business.name}...",
                          );

                          debugPrint('"phoneNumber  : ${business.phone}');

                          await LauncherHelper.launchPhoneDialer(
                            context,
                            business.phone.trim(),
                          );
                        },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20.sp,
                      ),
                      Gap(8.w),
                      Text(AppStrings.call.tr),
                    ],
                  ),
                ),
              ),
            ),

            Gap(16.w),

            // ============================================================
            // Directions Button
            // ============================================================
            Expanded(
              child: SizedBox(
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    // Use the business data here for your directions flow.
                    //
                    // If showDirectionsBottomSheet currently accepts
                    // MerchantModel, update it to accept BusinessDetailsModel
                    // instead, since this screen now works directly with
                    // BusinessDetailsModel.
                    showDirectionsBottomSheet(context, business: business);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.near_me_outlined,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 20.sp,
                      ),
                      Gap(8.w),
                      Text(AppStrings.directions.tr),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
