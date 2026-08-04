import '../../../../share/controller/screen_export.dart';

class InfoBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? time;

  const InfoBox({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xffF7F8FA),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                title,
                style: context.bodySmall.copyWith(color: Colors.grey),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                (time ?? '').isNotEmpty ? ' ($time)' : '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.bodySmall.copyWith(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
