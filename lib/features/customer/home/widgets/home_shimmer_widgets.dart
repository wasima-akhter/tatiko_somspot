import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

/// Reusable base shimmer wrapper to maintain visual consistency
class BaseShimmer extends StatelessWidget {
  final Widget child;

  const BaseShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[50]!,
      period: const Duration(milliseconds: 1500),
      child: child,
    );
  }
}

/// Shimmer loader matching Category Items
class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => Gap(16.w),
        itemBuilder: (context, index) {
          return BaseShimmer(
            child: Column(
              children: [
                Container(
                  width: 64.w,
                  height: 64.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                Gap(8.h),
                Container(
                  width: 48.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Shimmer loader matching Today's Best Deal banner
class BestDealShimmer extends StatelessWidget {
  const BestDealShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Container(
        height: 180.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
    );
  }
}

/// Shimmer loader matching Top Deals Row
class TopDealShimmer extends StatelessWidget {
  const TopDealShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        1, // We render one standard height card shimmer
        (index) => BaseShimmer(
          child: Container(
            width: double.infinity,
            height: 110.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        ),
      ),
    );
  }
}

/// Shimmer loader matching Nearby Merchant list items
class NearbyMerchantShimmer extends StatelessWidget {
  const NearbyMerchantShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        2, // Shimmer list displays 2 skeleton cards
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: BaseShimmer(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.r),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 180.w,
                          height: 16.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        Gap(8.h),
                        Container(
                          width: 80.w,
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        Gap(12.h),
                        Row(
                          children: [
                            Container(
                              width: 14.w,
                              height: 14.h,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Gap(4.w),
                            Container(
                              width: 45.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            Gap(16.w),
                            Container(
                              width: 14.w,
                              height: 14.h,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Gap(4.w),
                            Container(
                              width: 60.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
