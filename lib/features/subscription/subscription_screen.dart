import 'package:som_spot/features/nav/controller/navigation_controller.dart';

import '../../share/export/screen_export.dart';
import 'widgets/subscription_key_concept_banner.dart';
import 'widgets/subscription_plan_list.dart';
import 'widgets/subscription_step_item.dart';
import 'widgets/subscription_tab_selector.dart';
import 'widgets/subscription_usage_card.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
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
            const SubscriptionPlanList(), Gap(8.h),

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
    return SubscriptionKeyConceptBanner();
  }

  // ══════════════════════════════════════════════════════════
  // Tab Selector
  // ══════════════════════════════════════════════════════════
  Widget _buildTabSelector(BuildContext context) {
    return SubscriptionTabSelector();
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
                behavior: HitTestBehavior.opaque,
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
    return SubscriptionUsageCard();
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
    return SubscriptionStepItem(
      desc: desc,
      step: step,
      title: title,
      isLast: isLast,
    );
  }
}
