import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/features/nav/controller/navigation_controller.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';
import 'package:som_spot/utils/color/app_colors.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final ValueNotifier<int> _selectedTabIndex = ValueNotifier<int>(0);
  final ValueNotifier<int> _selectedPlanIndex = ValueNotifier<int>(1);

  // ── Subscription Plans ──
  final List<_PlanData> _subscriptionPlans = [
    _PlanData(
      name: 'Starter (Free)',
      price: 0.0,
      priceSuffix: ' /mo',
      freeHotDeals: 0,
      extraPostPrice: 5,
      features: [
        'Business profile listing',
        'Customer reviews',
        'Up to 5 photos',
        'Basic search visibility',
      ],
      highlightFeature: 'Free forever',
      isPopular: false,
    ),
    _PlanData(
      name: 'Growth',
      price: 9.99,
      priceSuffix: ' /mo',
      freeHotDeals: 5,
      extraPostPrice: 5,
      features: [
        'Verified badge',
        'Better search ranking',
        '25 photos/videos',
        'Basic analytics',
        'Promotional posts',
        '5 free Hot Deals / month',
      ],
      highlightFeature: '5 free Hot Deals included',
      isPopular: true,
    ),
    _PlanData(
      name: 'Premium',
      price: 29.99,
      priceSuffix: ' /mo',
      freeHotDeals: 10,
      extraPostPrice: 3,
      features: [
        'Top placement',
        'Featured listing',
        'Advanced analytics',
        'Unlimited media',
        'Multiple branches support',
        'Priority support',
        '10 free Hot Deals / month',
      ],
      highlightFeature: '10 free Hot Deals included',
      isPopular: false,
    ),
  ];

  // ── Influencer Boost Plans ──
  final List<_PlanData> _influencerBoostPlans = [
    _PlanData(
      name: 'Basic',
      price: 49.0,
      priceSuffix: ' /campaign',
      freeHotDeals: 0,
      extraPostPrice: 0,
      features: [
        'Influencer visit to your business',
        'High-quality content creation',
        'Basic social media post',
      ],
      highlightFeature: 'Great for new businesses',
      isPopular: false,
    ),
    _PlanData(
      name: 'Growth',
      price: 99.0,
      priceSuffix: ' /campaign',
      freeHotDeals: 0,
      extraPostPrice: 0,
      features: [
        'Multiple posts across platforms',
        'Detailed business reviews',
        'Collaborative promotion',
        'Higher audience reach',
      ],
      highlightFeature: 'Most popular for growth',
      isPopular: true,
    ),
    _PlanData(
      name: 'Premium',
      price: 249.0,
      priceSuffix: '+ /campaign',
      freeHotDeals: 0,
      extraPostPrice: 0,
      features: [
        'Top influencers collaboration',
        'Professional video production',
        'Full campaign management',
        'Guaranteed engagement metrics',
      ],
      highlightFeature: 'Complete marketing suite',
      isPopular: false,
    ),
  ];

  @override
  void dispose() {
    _selectedTabIndex.dispose();
    _selectedPlanIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.softBackgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.goNamed(RoutePath.navigationPages);
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
            color: AppColors.darkTextColor,
          ),
        ),
        title: Text(
          AppStrings.subscriptionBilling.tr,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Current Plan Status Card ──
            _buildCurrentPlanCard(context),
            Gap(24.h),

            // ── Key Concept Banner ──
            _buildKeyConceptBanner(context),
            Gap(24.h),

            // ── Hot Deal Usage Card ──
            _buildUsageCard(context),
            Gap(28.h),

            // ── Choose Plan Header ──
            Text(
              AppStrings.upgrade.tr,
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextColor,
              ),
            ),
            Gap(4.h),
            Text(
              'Choose a plan that fits your business'.tr,
              style: context.bodyMedium.copyWith(
                color: AppColors.subtitleTextColor,
              ),
            ),
            Gap(16.h),

            // ── Tab Selector ──
            _buildTabSelector(context),
            Gap(24.h),

            // ── Plan Cards ──
            ValueListenableBuilder<int>(
              valueListenable: _selectedTabIndex,
              builder: (context, tabIndex, _) {
                final currentPlans = tabIndex == 0
                    ? _subscriptionPlans
                    : _influencerBoostPlans;
                return ValueListenableBuilder<int>(
                  valueListenable: _selectedPlanIndex,
                  builder: (context, selectedIndex, _) {
                    return Column(
                      children: List.generate(currentPlans.length, (index) {
                        final plan = currentPlans[index];
                        final isSelected = selectedIndex == index;
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: _buildPlanCard(
                            context: context,
                            plan: plan,
                            isSelected: isSelected,
                            isInfluencer: tabIndex == 1,
                            onTap: () => _selectedPlanIndex.value = index,
                          ),
                        );
                      }),
                    );
                  },
                );
              },
            ),
            Gap(8.h),

            // ── How It Works Section ──
            _buildHowItWorksSection(context),
            Gap(24.h),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  // Key Concept Banner
  // ══════════════════════════════════════════════════════════
  Widget _buildKeyConceptBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.backgroundsLinesColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.lamp_on,
                color: AppColors.amberYellowColor,
                size: 22.sp,
              ),
              Gap(8.w),
              Text(
                'Key Concept'.tr,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkTextColor,
                ),
              ),
            ],
          ),
          Gap(16.h),
          _buildConceptRow(
            context,
            Iconsax.flash_1,
            AppColors.orangeColor,
            'Hot Deals',
            'drive engagement with your customers.'.tr,
          ),
          Gap(12.h),
          _buildConceptRow(
            context,
            Iconsax.star1,
            AppColors.purpleAccentColor,
            'Influencers',
            'drive high-impact business acquisition.'.tr,
          ),
          Gap(12.h),
          _buildConceptRow(
            context,
            Iconsax.crown1,
            AppColors.blueAccentColor,
            'Subscriptions',
            'drive continuous recurring revenue.'.tr,
          ),
        ],
      ),
    );
  }

  Widget _buildConceptRow(
    BuildContext context,
    IconData icon,
    Color color,
    String title,
    String desc,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 2.h),
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14.sp, color: color),
        ),
        Gap(12.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title ',
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkTextColor,
                  ),
                ),
                TextSpan(
                  text: desc,
                  style: context.bodyMedium.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════
  // Tab Selector
  // ══════════════════════════════════════════════════════════
  Widget _buildTabSelector(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _selectedTabIndex,
      builder: (context, selectedIndex, _) {
        return Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.backgroundsLinesColor),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectedTabIndex.value = 0;
                    _selectedPlanIndex.value = 1; // Default to Growth
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: selectedIndex == 0
                          ? AppColors.blueAccentColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Subscriptions'.tr,
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: selectedIndex == 0
                            ? AppColors.white
                            : AppColors.subtitleTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectedTabIndex.value = 1;
                    _selectedPlanIndex.value = 1; // Default to Growth
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: selectedIndex == 1
                          ? AppColors.purpleAccentColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Influencer Boost'.tr,
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: selectedIndex == 1
                            ? AppColors.white
                            : AppColors.subtitleTextColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ══════════════════════════════════════════════════════════
  // Current Plan Card (gradient hero)
  // ══════════════════════════════════════════════════════════
  Widget _buildCurrentPlanCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blueAccentColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  AppStrings.currentPlan.tr,
                  style: context.bodySmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Iconsax.crown1,
                color: AppColors.white.withValues(alpha: 0.8),
                size: 28.sp,
              ),
            ],
          ),
          Gap(16.h),
          Text(
            'Growth Plan', // backend theke ashbe
            style: context.headlineSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          Gap(4.h),
          Text(
            'Renews on Jul 5, 2026'.tr, // backend theke ashbe
            style: context.bodySmall.copyWith(
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
          Gap(16.h),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '\$9.99', // Updated to 9.99
                      style: context.headlineMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    TextSpan(
                      text: ' /mo',
                      style: context.bodyMedium.copyWith(
                        color: AppColors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.goNamed(RoutePath.navigationPages);
                  }
                  NavigationControllerMain.to.selectedNavIndex.value = 2;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'Manage'.tr,
                    style: context.bodySmall.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
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

  // ══════════════════════════════════════════════════════════
  // Hot Deal Usage Card
  // ══════════════════════════════════════════════════════════
  Widget _buildUsageCard(BuildContext context) {
    // Ekhon static — backend theke ashbe
    const int used = 3;
    const int total = 5; // Growth plan has 5 free posts
    const double progress = used / total;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.backgroundsLinesColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.amberYellowColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Iconsax.flash_1,
                  color: AppColors.amberYellowColor,
                  size: 20.sp,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hot Deal Posts This Month'.tr,
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Gap(2.h),
                    Text(
                      '$used of $total free posts used'.tr,
                      style: context.bodySmall.copyWith(
                        color: AppColors.subtitleTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(16.h),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8.h,
              backgroundColor: AppColors.softSlateBgColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 1.0 ? AppColors.error : AppColors.blueAccentColor,
              ),
            ),
          ),
          Gap(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.blueAccentColor.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.info_circle,
                  size: 16.sp,
                  color: AppColors.blueAccentColor,
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    'Extra posts after free limit: \$5 each'.tr,
                    style: context.bodySmall.copyWith(
                      color: AppColors.blueAccentColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════
  // Plan Card
  // ══════════════════════════════════════════════════════════
  Widget _buildPlanCard({
    required BuildContext context,
    required _PlanData plan,
    required bool isSelected,
    required bool isInfluencer,
    required VoidCallback onTap,
  }) {
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
                      Text(
                        '  •  \$${plan.extraPostPrice}/extra post',
                        style: context.bodySmall.copyWith(
                          color: isDark
                              ? AppColors.white.withValues(alpha: 0.7)
                              : AppColors.subtitleTextColor,
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

  // ══════════════════════════════════════════════════════════
  // How It Works Section
  // ══════════════════════════════════════════════════════════
  Widget _buildHowItWorksSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.backgroundsLinesColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How Hot Deal Posting Works'.tr,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),
          Gap(16.h),
          _buildStepItem(
            context,
            step: '1',
            title: 'Choose a plan'.tr,
            desc: 'Select a subscription that fits your needs'.tr,
          ),
          _buildStepItem(
            context,
            step: '2',
            title: 'Post hot deals'.tr,
            desc: 'Use your free posts each month'.tr,
          ),
          _buildStepItem(
            context,
            step: '3',
            title: 'Need more?'.tr,
            desc: 'Pay per extra post after your free limit'.tr,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(
    BuildContext context, {
    required String step,
    required String title,
    required String desc,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: AppColors.blueAccentColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  step,
                  style: context.bodySmall.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 30.h,
                color: AppColors.blueAccentColor.withValues(alpha: 0.2),
              ),
          ],
        ),
        Gap(14.w),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkTextColor,
                  ),
                ),
                Gap(2.h),
                Text(
                  desc,
                  style: context.bodySmall.copyWith(
                    color: AppColors.subtitleTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Plan Data Model ──
class _PlanData {
  final String name;
  final double price;
  final String priceSuffix;
  final int freeHotDeals;
  final int extraPostPrice;
  final List<String> features;
  final String highlightFeature;
  final bool isPopular;

  const _PlanData({
    required this.name,
    required this.price,
    required this.priceSuffix,
    required this.freeHotDeals,
    required this.extraPostPrice,
    required this.features,
    required this.highlightFeature,
    this.isPopular = false,
  });
}
