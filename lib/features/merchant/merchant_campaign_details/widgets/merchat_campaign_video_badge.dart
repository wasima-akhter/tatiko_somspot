import 'package:som_spot/helper/text_utils/string_extension.dart';

import '../../../../share/controller/screen_export.dart';

class MerchantCampaignVideoBadge extends StatelessWidget {
  const MerchantCampaignVideoBadge({super.key, required this.platform});

  final String platform;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.play_arrow_rounded, color: Colors.white, size: 14.sp),
          Gap(3.w),
          Text(
            platform.capitalizeWords(),
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
