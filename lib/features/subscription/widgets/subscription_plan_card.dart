import 'package:go_router/go_router.dart';

import '../../../core/router/route_path.dart';
import '../../../share/controller/screen_export.dart';
import '../../nav/controller/navigation_controller.dart';
import '../controller/subscription_controller.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionPlanModel plan;

  final bool isSelected;

  final VoidCallback onTap;
  final bool isInfluencer;

  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
    required this.isInfluencer,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = plan.isPopular && isSelected;
    final Color accentColor = isInfluencer
        ? AppColors.purpleAccentColor
        : AppColors.blueAccentColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
                  colors: isInfluencer
                      ? [const Color(0xFF8B5CF6), const Color(0xFFC084FC)]
                      : [const Color(0xFF3B82F6), const Color(0xFF6366F1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isDark ? null : AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: isDark
              ? null
              : Border.all(
                  color: isSelected
                      ? accentColor
                      : AppColors.backgroundsLinesColor,
                  width: isSelected ? 2 : 1,
                ),
          boxShadow: isDark
              ? [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      plan.name,
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.white
                            : AppColors.darkTextColor,
                      ),
                    ),
                  ),
                  if (plan.isPopular)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.white.withValues(alpha: 0.2)
                            : accentColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Iconsax.star1,
                            size: 12.sp,
                            color: isDark
                                ? AppColors.amberYellowColor
                                : accentColor,
                          ),
                          Gap(4.w),
                          Text(
                            'Popular',
                            style: context.bodySmall.copyWith(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.white : accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Gap(12.h),

              // Price
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '\$${plan.price.toStringAsFixed(plan.price.truncateToDouble() == plan.price ? 0 : 2)}',
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.white
                            : AppColors.darkTextColor,
                      ),
                    ),
                    TextSpan(
                      text: plan.priceSuffix,
                      style: context.bodyMedium.copyWith(
                        color: isDark
                            ? AppColors.white.withValues(alpha: 0.7)
                            : AppColors.subtitleTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(8.h),

              // Highlight Feature Banner
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.white.withValues(alpha: 0.12)
                      : (isInfluencer
                                ? AppColors.purpleAccentColor
                                : AppColors.amberYellowColor)
                            .withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isInfluencer ? Iconsax.star1 : Iconsax.flash_1,
                      size: 16.sp,
                      color: isDark
                          ? (isInfluencer
                                ? AppColors.white
                                : AppColors.amberYellowColor)
                          : (isInfluencer
                                ? AppColors.purpleAccentColor
                                : AppColors.amberYellowColor),
                    ),
                    Gap(8.w),
                    Text(
                      plan.highlightFeature,
                      style: context.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.white
                            : AppColors.darkTextColor,
                      ),
                    ),
                    if (plan.extraPostPrice > 0) ...[
                      Expanded(
                        child: Text(
                          '  •  \$${plan.extraPostPrice}/extra post',
                          style: context.bodySmall.copyWith(
                            fontSize: 9,
                            color: isDark
                                ? AppColors.white.withValues(alpha: 0.7)
                                : AppColors.subtitleTextColor,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Gap(16.h),

              // Divider
              Container(
                height: 1,
                color: isDark
                    ? AppColors.white.withValues(alpha: 0.15)
                    : AppColors.backgroundsLinesColor,
              ),
              Gap(16.h),

              // Features
              ...plan.features.map(
                (feature) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 2.h),
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.white.withValues(alpha: 0.2)
                              : AppColors.emeraldGreenColor.withValues(
                                  alpha: 0.1,
                                ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_rounded,
                          size: 14.sp,
                          color: isDark
                              ? AppColors.white
                              : AppColors.emeraldGreenColor,
                        ),
                      ),
                      Gap(12.w),
                      Expanded(
                        child: Text(
                          feature,
                          style: context.bodyMedium.copyWith(
                            color: isDark
                                ? AppColors.white.withValues(alpha: 0.9)
                                : AppColors.darkTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(4.h),

              // Action Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: isDark
                    ? ElevatedButton(
                        onPressed: () {
                          // TODO: Payment integration (Stripe/Moyasar)
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.goNamed(RoutePath.navigationPages);
                          }
                          NavigationControllerMain.to.selectedNavIndex.value =
                              2;
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          foregroundColor: accentColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: Text(
                          isInfluencer
                              ? 'Get ${plan.name} Boost'.tr
                              : 'Subscribe to ${plan.name}'.tr,
                          style: context.titleSmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      )
                    : OutlinedButton(
                        onPressed: () {
                          // TODO: Payment integration (Stripe/Moyasar)
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.goNamed(RoutePath.navigationPages);
                          }
                          NavigationControllerMain.to.selectedNavIndex.value =
                              2;
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isSelected
                                ? accentColor
                                : AppColors.backgroundsLinesColor,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                        ),
                        child: Text(
                          isSelected
                              ? (isInfluencer
                                    ? 'Get ${plan.name} Boost'.tr
                                    : 'Subscribe to ${plan.name}'.tr)
                              : 'Select Plan'.tr,
                          style: context.titleSmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? accentColor
                                : AppColors.subtitleTextColor,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
