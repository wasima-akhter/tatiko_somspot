import '../../../../share/controller/screen_export.dart';

class MerchantCampaignHeader extends StatelessWidget {
  const MerchantCampaignHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 22.h),

      decoration: BoxDecoration(
        color: AppColors.primaryColor,

        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  //
                  AppRouter.route.goNamed(RoutePath.navigationPages);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),

              Gap(8.w),

              Text(
                "Influencer Campaigns",
                style: context.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          Gap(18.h),

          Text(
            "Reach new customers through trusted local creators",
            style: context.bodySmall.copyWith(color: Colors.white),
          ),

          Gap(18.h),

          Row(
            children: [
              _stat(context, "Active campaign", "10"),

              Gap(12.w),

              _stat(context, "In Review", "03"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(BuildContext context, String title, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(12.r),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(title, style: context.bodySmall),

            Gap(4.h),

            Text(
              value,
              style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
