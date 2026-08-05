import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/color/app_colors.dart';
import '../controller/influencer_wallet_controller.dart';
import '../helper/influencer_wallet_helper.dart';

class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({super.key});

  final String amount = "\$1,240.00";

  @override
  Widget build(BuildContext context) {
    final controller = InfluencerWalletController.to;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff8A2BE2), Color(0xff4EA9FF)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Earnings this period",
            style: TextStyle(color: Colors.white70, fontSize: 11.sp),
          ),

          SizedBox(height: 6.h),

          Text(
            amount,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 31.sp,
            ),
          ),

          Divider(color: Colors.white.withValues(alpha: .25), thickness: 1),

          SizedBox(height: 14.h),

          Obx(() {
            return Row(
              children: [
                Expanded(
                  child: _walletButton(
                    title: "Withdraw",
                    isActive:
                        controller.selectedTab.value ==
                        InfluencerWalletTab.withdraw,
                    onPressed: () =>
                        controller.changeTab(InfluencerWalletTab.withdraw),
                  ),
                ),

                SizedBox(width: 10.w),

                Expanded(
                  child: _walletButton(
                    title: "Analytics",
                    isActive:
                        controller.selectedTab.value ==
                        InfluencerWalletTab.analytics,
                    onPressed: () =>
                        controller.changeTab(InfluencerWalletTab.analytics),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _walletButton({
    required String title,
    required bool isActive,
    required VoidCallback onPressed,
  }) {
    return isActive
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xff4EA9FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.purpleAccentColor,
              ),
            ),
          )
        : OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 12.h),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          );
  }
}
