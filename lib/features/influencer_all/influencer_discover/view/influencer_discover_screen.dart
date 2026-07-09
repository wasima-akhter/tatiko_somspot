import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:som_spot/utils/color/app_colors.dart';

import '../controller/influencer_discover_controller.dart';
import '../widgets/discover_category_tabs.dart';
import '../widgets/discover_header.dart';
import '../widgets/influencer_campaign_card.dart';

class InfluencerDiscoverScreen extends StatefulWidget {
  const InfluencerDiscoverScreen({super.key});

  @override
  State<InfluencerDiscoverScreen> createState() =>
      _InfluencerDiscoverScreenState();
}

class _InfluencerDiscoverScreenState extends State<InfluencerDiscoverScreen> {
  final InfluencerDiscoverController controller = Get.put(
    InfluencerDiscoverController(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.softBackgroundColor,

        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),

          slivers: [
            SliverToBoxAdapter(child: DiscoverHeader()),
            SliverPersistentHeader(
              pinned: true,

              delegate: DiscoverTabsDelegate(
                child: DiscoverCategoryTabs(controller: controller),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),

              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final campaign = controller.campaigns[index];

                  return AutoShimmerAnimate(
                    isLoading: controller.isLoading.value,

                    duration: const Duration(milliseconds: 4200),

                    layeredSkeleton: true,

                    child: InfluencerCampaignCard(campaign: campaign),
                  );
                }, childCount: controller.campaigns.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
