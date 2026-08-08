import 'dart:math';

import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../share/controller/screen_export.dart';
import '../response/influencer_wallet_response.dart';

class EarningsTrendChart extends StatelessWidget {
  final List<EarningsTrendModel>? earningsTrend;
  final bool isLoading;

  const EarningsTrendChart({
    super.key,
    required this.earningsTrend,
    this.isLoading = false,
  });

  List<_ChartData> get chartData {
    if (earningsTrend == null || earningsTrend!.isEmpty) {
      // fallback placeholder
      return [
        _ChartData(AppStrings.jan, 0),
        _ChartData(AppStrings.feb.tr, 0),
        _ChartData(AppStrings.mar.tr, 0),
        _ChartData(AppStrings.apr.tr, 0),
        _ChartData(AppStrings.may.tr, 0),
        _ChartData(AppStrings.jun.tr, 0),
      ];
    }

    return earningsTrend!
        .map((e) => _ChartData(e.label ?? "", (e.total ?? 0).toDouble()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final data = chartData;

    final maxValue = data.map((e) => e.value).reduce(max);
    final hasData = earningsTrend != null && earningsTrend!.isNotEmpty;

    return AutoShimmerAnimate(
      isLoading: isLoading,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  AppStrings.earningsTrend.tr,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTextColor,
                  ),
                ),

                const Spacer(),

                Icon(Iconsax.dollar_circle, size: 14.sp, color: Colors.grey),

                SizedBox(width: 4.w),

                Text(
                  AppStrings.monthly.tr,
                  style: context.bodySmall.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            hasData
                ? SizedBox(
                    height: 150.h,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,

                        maxY: max(10, (maxValue * 1.2).ceilToDouble()),

                        gridData: const FlGridData(show: false),

                        borderData: FlBorderData(show: false),

                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),

                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),

                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),

                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 26,

                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();

                                if (index >= data.length) {
                                  return const SizedBox();
                                }

                                return Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Text(
                                    data[index].month,
                                    style: context.bodySmall.copyWith(
                                      color: Colors.grey,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        barGroups: List.generate(data.length, (index) {
                          final item = data[index];

                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: item.value,

                                width: 40.w,

                                borderRadius: BorderRadius.circular(6.r),

                                color: index == data.length - 1
                                    ? AppColors.purpleAccentColor
                                    : const Color(0xffE4CFFB),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  )
                : _buildEmptyState(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      height: 150.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.softBackgroundColor.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 44.h,
            width: 44.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xffE9D8FF), Color(0xffDCEBFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Iconsax.chart_21,
              size: 22.sp,
              color: AppColors.purpleAccentColor,
            ),
          ),

          Gap(10.h),

          Text(
            AppStrings.noEarningsDataYet.tr,
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.darkTextColor,
            ),
          ),

          Gap(4.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              AppStrings.completeCampaignsAndTasks.tr,
              textAlign: TextAlign.center,
              style: context.bodySmall.copyWith(
                color: AppColors.subtitleTextColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  final String month;
  final double value;

  _ChartData(this.month, this.value);
}
