import 'package:som_spot/share/export/screen_export.dart';

import 'help_support_form.dart';
import 'help_support_online_status.dart';

class HelpSupportFormCard extends StatelessWidget {
  const HelpSupportFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.backgroundsLinesColor.withValues(alpha: 0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.emailUsOnline.tr,
            style: context.titleMedium.copyWith(
              fontSize: 15.sp,
              color: AppColors.darkTextColor,
            ),
          ),

          SizedBox(height: 12.h),

          const HelpSupportOnlineStatus(),

          SizedBox(height: 16.h),

          const HelpSupportForm(),
        ],
      ),
    );
  }
}
