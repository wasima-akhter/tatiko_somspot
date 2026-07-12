import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';

class EarningsTrendChart extends StatelessWidget {
  EarningsTrendChart({super.key});

  final List<_ChartData> chartData = [
    _ChartData("May", 4),
    _ChartData("Jun", 7),
    _ChartData("Jul", 5),
    _ChartData("Aug", 8),
    _ChartData("Sep", 7),
    _ChartData("Oct", 8),
  ];

  @override
  Widget build(BuildContext context) {
    final double maxValue = chartData.map((e) => e.value).reduce(max);

    return Container(
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
                "Earnings Trend",
                style: context.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextColor,
                ),
              ),
              const Spacer(),
              Icon(Iconsax.dollar_circle, size: 14.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                "Monthly",
                style: context.bodySmall.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          SizedBox(
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
                        if (value.toInt() >= chartData.length) {
                          return const SizedBox();
                        }

                        return Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            chartData[value.toInt()].month,
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

                barGroups: List.generate(chartData.length, (index) {
                  final item = chartData[index];

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: item.value,
                        width: 40.w,

                        borderRadius: BorderRadius.circular(6.r),
                        color: index == chartData.length - 1
                            ? AppColors.purpleAccentColor
                            : const Color(0xffE4CFFB),
                      ),
                    ],
                  );
                }),
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
