import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import '../widgets/apply_button.dart';
import '../widgets/campaign_banner.dart';
import '../widgets/campaign_info_cards.dart';
import '../widgets/deliverables_section.dart';
import '../widgets/requirements_section.dart';

class InfluencerCampaignDetailsScreen extends StatelessWidget {
  const InfluencerCampaignDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.softBackgroundColor,
        elevation: 0,

        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, size: 22.sp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        title: Text(
          "Campaign Details",
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),

        centerTitle: false,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(16.r),

                          border: Border.all(
                            color: Colors.grey.withValues(alpha: .12),
                          ),
                        ),

                        child: Column(
                          children: [CampaignBanner(), CampaignInfoCards()],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    sliver: SliverToBoxAdapter(child: DeliverablesSection()),
                  ),

                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverToBoxAdapter(child: RequirementsSection()),
                  ),
                ],
              ),
            ),

            const ApplyButton(),
          ],
        ),
      ),
    );
  }
}
