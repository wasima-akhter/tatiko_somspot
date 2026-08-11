import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/custom_buttom_sheet/custom_buttom_sheet.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../merchant_new_campaign/shared/response/merchant_campaign_detail_model.dart';

class MerchantCampaignInfluencerCard extends StatelessWidget {
  final CampaignApplicationModel application;

  const MerchantCampaignInfluencerCard({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    final creator = application.creator;

    final influencer = InfluencerModel(
      name: creator.name ?? "",
      category: creator.category?.name ?? "",
      image: creator.profileImage ?? "",
      followers: "0",
      engagement: "0%",
      completedCampaigns: "0",
      pitch: "",
    );

    debugPrint('creator.profileImage: ${creator.profileImage}');

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                child: (creator.profileImage.isNotEmpty)
                    ? CustomNetworkImage(
                        imageUrl: creator.profileImage,
                        boxShape: BoxShape.circle,
                      )
                    : SizedBox.shrink(),
              ),

              Gap(12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      creator.name ?? "",
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    Gap(2.h),

                    Text(
                      "• ${creator.category?.name ?? ""}", // translation from backend should show acc to lang
                      style: context.bodySmall.copyWith(
                        color: AppColors.subtitleTextColor,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  AppStrings.assigned.tr,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),

          Gap(12.h),

          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: () {
                if (creator.id.isEmpty) return;
                showInfluencerRequestBottomSheet(
                  context,
                  creatorId: creator.id,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  AppStrings.viewProfile.tr,
                  style: context.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfluencerModel {
  final String name;
  final String category;
  final String image;
  final String followers;
  final String engagement;
  final String completedCampaigns;
  final String pitch;

  const InfluencerModel({
    required this.name,
    required this.category,
    required this.image,
    required this.followers,
    required this.engagement,
    required this.completedCampaigns,
    required this.pitch,
  });
}
