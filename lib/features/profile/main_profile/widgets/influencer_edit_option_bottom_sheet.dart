import '../../../../share/export/screen_export.dart';

class InfluencerEditOptionBottomSheet extends StatelessWidget {
  const InfluencerEditOptionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),

      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              AppStrings.editProfile.tr,
              style: context.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.darkTextColor,
              ),
            ),

            Gap(24.h),

            CustomButton(
              text: AppStrings.basicInformation.tr,

              onTap: () {
                Navigator.pop(context);

                AppRouter.route.pushNamed(RoutePath.editProfileScreen);
              },
            ),

            Gap(16.h),

            CustomButton(
              text: AppStrings.influencerInformation.tr,
              onTap: () {
                Navigator.pop(context);

                AppRouter.route.pushNamed(RoutePath.editInfluencerScreen);
              },
            ),

            Gap(12.h),
          ],
        ),
      ),
    );
  }
}
