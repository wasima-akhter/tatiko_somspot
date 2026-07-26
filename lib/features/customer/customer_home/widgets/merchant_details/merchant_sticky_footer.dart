import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:som_spot/features/customer/customer_home/model/merchant_model.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/helper/launcher/launcher_helper.dart';
import 'package:som_spot/share/widgets/custom_buttom_sheet/custom_buttom_sheet.dart';

class MerchantStickyFooter extends StatelessWidget {
  final MerchantModel merchant;

  const MerchantStickyFooter({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: AppColors.backgroundsLinesColor)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // Call Button
          Expanded(
            child: SizedBox(
              height: 52.h,
              child: OutlinedButton(
                onPressed: () {
                  AppToast.info(
                    context: context,
                    message: "${AppStrings.calling.tr} +252 61 234 5678...",
                  );
                  LauncherHelper.launchPhoneDialer(context, '+252612345678');
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
                    Text(
                      AppStrings.call.tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Gap(16.w),
          // Directions Button
          Expanded(
            child: SizedBox(
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  showDirectionsBottomSheet(
                    context,
                    merchant: merchant,
                  );
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
                    Text(
                      AppStrings.directions.tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
