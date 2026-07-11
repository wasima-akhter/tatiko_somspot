import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/color/app_colors.dart';
import '../../../../utils/extension/base_extension.dart';
import '../widgets/back_to_tasks_button.dart';
import '../widgets/caption_section.dart';
import '../widgets/submission_info_card.dart';
import '../widgets/submitted_video_section.dart';
import '../widgets/verification_banner.dart';

class InfluencerYourSubmissionScreen extends StatelessWidget {
  const InfluencerYourSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.softBackgroundColor,
        elevation: 0,

        leading: Icon(Iconsax.arrow_left_2, size: 22.sp),

        title: Text(
          "Your Submission",
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),
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
                      child: Column(
                        children: [
                          const VerificationBanner(
                            status: SubmissionStatus.verified,
                          ),

                          SizedBox(height: 14.h),

                          const SubmissionInfoCard(),

                          SizedBox(height: 14.h),

                          const SubmittedVideoSection(),

                          SizedBox(height: 14.h),

                          const CaptionSection(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const BackToTasksButton(),
          ],
        ),
      ),
    );
  }
}
