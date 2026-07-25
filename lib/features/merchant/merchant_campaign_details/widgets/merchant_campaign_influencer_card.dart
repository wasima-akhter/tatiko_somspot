import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/custom_buttom_sheet/custom_buttom_sheet.dart';

class MerchantCampaignInfluencerCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const MerchantCampaignInfluencerCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    const mockInfluencer = InfluencerModel(
      name: "Ahmed Hassan",
      category: "Food Creator",
      image: "https://i.pravatar.cc/300?img=12",
      followers: "50K",
      engagement: "4.2%",
      completedCampaigns: "12",
      pitch:
          "I run the biggest food review page in Mogadishu. My audience loves discovering new restaurants and BOGO deals always perform great with them.",
    );
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
                backgroundImage: NetworkImage(data["avatar"]),
              ),

              Gap(12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["name"],
                      style: context.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    Gap(2.h),

                    Text(
                      "• ${data["category"]}",
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
                  "Assigned",
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
                showInfluencerRequestBottomSheet(
                  context,
                  influencer: mockInfluencer,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "View Profile",
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
