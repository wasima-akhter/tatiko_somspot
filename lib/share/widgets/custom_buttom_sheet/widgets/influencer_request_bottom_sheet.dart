import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../features/merchant/merchant_campaign_details/controller/merchant_campaign_details_controller.dart';
import '../../../../features/merchant/merchant_new_campaign/shared/response/merchant_campaign_detail_model.dart';
import '../../../controller/screen_export.dart';
import '../../ui_status_builder/api_status_builder.dart';

class InfluencerRequestBottomSheet extends StatelessWidget {
  final String creatorId;

  const InfluencerRequestBottomSheet({super.key, required this.creatorId});

  @override
  Widget build(BuildContext context) {
    final controller = MerchantCampaignDetailsController.to;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.creator.value?.id != creatorId) {
        controller.loadCreator(creatorId);
      }
    });

    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 30.h),

        child: SafeArea(
          top: false,

          child: ApiStatusBuilder(
            status: controller.creatorStatus.value,
            errorMessage: controller.errorMessage.value,
            onRetry: () {
              controller.loadCreator(creatorId);
            },

            loadingWidget: _buildSkeleton(context),

            builder: (_) {
              final creator = controller.creator.value!;

              return _buildContent(context, creator);
            },
          ),
        ),
      );
    });
  }

  Widget _buildContent(BuildContext context, MerchantCreatorModel creator) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Drag Handle
        Container(
          width: 45.w,
          height: 5.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),

        SizedBox(height: 22.h),

        /// Header
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 28.r,
              child: CustomNetworkImage(
                imageUrl: creator.image,
                boxShape: BoxShape.circle,
              ),
            ),

            SizedBox(width: 14.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    creator.name.capitalizeWords(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    creator.category.capitalizeWords(),
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),

        SizedBox(height: 22.h),

        /// Stats
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: formatCount(creator.followerCount),
                subtitle: AppStrings.followers.tr,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: _StatCard(
                title: "${creator.engagementRate}%",
                subtitle: AppStrings.engage.tr,
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: _StatCard(
                title: creator.doneCount.toString(),
                subtitle: AppStrings.done.tr,
              ),
            ),
          ],
        ),

        SizedBox(height: 24.h),

        /// Bio
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppStrings.pitch.tr,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),

        SizedBox(height: 10.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,

            borderRadius: BorderRadius.circular(16.r),

            border: Border.all(color: Colors.grey.shade300),
          ),

          child: Text(
            creator.bio.capitalizeWords(),
            style: TextStyle(fontSize: 14.sp, height: 1.5),
          ),
        ),

        SizedBox(height: 28.h),
      ],
    );
  }

  String formatCount(int count) {
    if (count >= 1000000) {
      return "${(count / 1000000).toStringAsFixed(1)}M";
    }

    if (count >= 1000) {
      return "${(count / 1000).toStringAsFixed(1)}K";
    }

    return count.toString();
  }

  Widget _buildSkeleton(BuildContext context) {
    return AutoShimmerAnimate(
      isLoading: true,
      duration: const Duration(seconds: 2),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Container(
            width: 45.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),

          SizedBox(height: 22.h),

          Row(
            children: [
              CircleAvatar(radius: 28.r, backgroundColor: Colors.grey.shade300),

              SizedBox(width: 14.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Container(
                      width: 130.w,
                      height: 18.h,
                      color: Colors.grey.shade300,
                    ),

                    SizedBox(height: 8.h),

                    Container(
                      width: 90.w,
                      height: 13.h,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),

              Icon(Icons.close, color: Colors.grey),
            ],
          ),

          SizedBox(height: 22.h),

          Row(
            children: [
              Expanded(child: _ShimmerStatCard()),

              SizedBox(width: 12.w),

              Expanded(child: _ShimmerStatCard()),

              SizedBox(width: 12.w),

              Expanded(child: _ShimmerStatCard()),
            ],
          ),

          SizedBox(height: 24.h),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppStrings.pitch.tr,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),

          SizedBox(height: 10.h),

          Container(
            height: 80.h,
            width: double.infinity,

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),

          SizedBox(height: 28.h),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
              ),

              SizedBox(width: 14.w),

              Expanded(
                child: Container(
                  height: 52.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(14.r),
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

class _StatCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _StatCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),

      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : const Color(0xffF7F8FC),

        borderRadius: BorderRadius.circular(14.r),
      ),

      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 4.h),

          Text(
            subtitle,
            style: TextStyle(color: Colors.grey, fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}

class _ShimmerStatCard extends StatelessWidget {
  const _ShimmerStatCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,

      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(14.r),
      ),
    );
  }
}
