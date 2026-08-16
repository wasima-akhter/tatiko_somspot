import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import 'trending_influencer.dart';

class TrendingInfluencerCard extends StatelessWidget {
  const TrendingInfluencerCard({
    super.key,
    required this.influencer,
    required this.onTap,
  });

  final TrendingInfluencer influencer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 125.w,
        padding: EdgeInsets.fromLTRB(8.w, 10.h, 8.w, 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProfileImage(context),

            Gap(12.h),

            Text(
              influencer.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkTextColor,
              ),
            ),

            Gap(2.h),

            Text(
              influencer.category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.bodySmall.copyWith(
                color: const Color(0xff9BA6B5),
                fontSize: 11.sp,
                letterSpacing: -0.1,
              ),
            ),

            Gap(7.h),

            _buildOffer(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryColor, width: 1),
          ),
          child: CustomNetworkImage(
            imageUrl: influencer.image,
            boxShape: BoxShape.circle,
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          bottom: -5.h,
          left: 3,
          right: 3,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              '50K',
              textAlign: TextAlign.center,
              style: context.bodySmall.copyWith(
                color: Colors.white,
                fontSize: 8.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOffer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 243, 255),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        'Buy 1 Get 1 Free',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: context.bodySmall.copyWith(
          color: AppColors.primaryColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
