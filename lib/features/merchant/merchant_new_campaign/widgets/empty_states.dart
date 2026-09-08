import '../../../../share/export/screen_export.dart';

class CampaignEmptyState extends StatelessWidget {
  final String message;

  const CampaignEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 20.sp,
            color: AppColors.subtitleTextColor,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: context.bodyMedium.copyWith(
                color: AppColors.subtitleTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
