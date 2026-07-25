import '../../../../share/controller/screen_export.dart';

class MerchantCampaignVideoBadge extends StatelessWidget {
  const MerchantCampaignVideoBadge({super.key, required this.platform});

  final String platform;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .75),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_arrow_rounded, color: Colors.white, size: 13.sp),
          Gap(3.w),
          Text(
            platform,
            style: context.bodySmall.copyWith(
              color: Colors.white,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }
}
