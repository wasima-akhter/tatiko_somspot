import 'package:som_spot/share/controller/screen_export.dart';

import '../controller/other_controller.dart';
import 'help_support_faq_item.dart';

class HelpSupportFaqSection extends StatelessWidget {
  const HelpSupportFaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OtherController.to;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "FAQ",
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
            color: AppColors.darkTextColor,
          ),
        ),

        SizedBox(height: 12.h),

        ...controller.faqs.map(
          (faq) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: HelpSupportFaqItem(faq: faq),
          ),
        ),
      ],
    );
  }
}
