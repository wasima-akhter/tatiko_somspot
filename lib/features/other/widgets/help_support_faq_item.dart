import 'package:som_spot/share/controller/screen_export.dart';

import '../controller/other_controller.dart';

class HelpSupportFaqItem extends StatelessWidget {
  final FaqModel faq;

  const HelpSupportFaqItem({super.key, required this.faq});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.backgroundsLinesColor.withValues(alpha: 0.8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 4.r,
            offset: Offset(0, 1.h),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.primaryColor,
          collapsedIconColor: AppColors.hintTextColor,

          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),

          childrenPadding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
          ),

          title: Text(
            faq.question,
            style: context.titleSmall.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              color: AppColors.darkTextColor,
            ),
          ),

          children: [
            Text(
              faq.answer,
              style: context.bodyMedium.copyWith(
                color: AppColors.subtitleTextColor,
                fontSize: 12.sp,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
