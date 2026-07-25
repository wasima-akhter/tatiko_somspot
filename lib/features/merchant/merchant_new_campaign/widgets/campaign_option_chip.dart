import '../../../../share/controller/screen_export.dart';

class CampaignOptionChip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const CampaignOptionChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),

        decoration: BoxDecoration(
          color: selected ? const Color(0xff45A7F5) : const Color(0xffDCEEFF),

          borderRadius: BorderRadius.circular(10.r),
        ),

        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.sp,

              color: selected ? Colors.white : Colors.black87,

              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
