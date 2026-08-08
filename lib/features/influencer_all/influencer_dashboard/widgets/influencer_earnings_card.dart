import 'package:som_spot/features/influencer_all/influencer_dashboard/response/influencer_dashboard_response.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/share/controller/screen_export.dart';

class InfluencerEarningsCard extends StatelessWidget {
  final InfluencerDashboardModel? data;
  final bool isLoading;

  const InfluencerEarningsCard({super.key, this.data, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: const LinearGradient(
          colors: [
            Color(0xff4FA8FF),
            Color.fromARGB(255, 98, 69, 245),
            Color(0xff8B2CF5),
          ],
          begin: Alignment(-0.8, 0.5),
          end: Alignment(-0.5, -1.8),
          stops: [0.0, 0.55, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 87, 81, 93).withValues(alpha: 0.5),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.totalEarnings.tr,
            style: context.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: .85),
              fontSize: 11.sp,
            ),
          ),

          SizedBox(height: 4.h),

          Text(
            isLoading
                ? "\$0"
                : "\$${data?.totalEarnings.toStringAsFixed(2) ?? "0.00"}",
            style: context.headlineMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24.sp,
            ),
          ),

          SizedBox(height: 16.h),

          Container(height: 1, color: Colors.white.withValues(alpha: .25)),

          SizedBox(height: 12.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.pending.tr,
                    style: context.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: .8),
                      fontSize: 10.sp,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  Text(
                    isLoading
                        ? "\$0.00"
                        : "\$${data?.pendingPayout.toStringAsFixed(2) ?? "0.00"}",
                    style: context.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  NavigationControllerMain.to.goToTabWallet();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 7.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    AppStrings.withdraw.tr,
                    style: context.bodySmall.copyWith(
                      color: AppColors.purpleAccentColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
