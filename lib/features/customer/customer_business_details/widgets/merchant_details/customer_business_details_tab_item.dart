import 'package:som_spot/share/export/screen_export.dart';

import '../../controller/customer_business_details_controller.dart';

class MerchantDetailsTabItem extends StatelessWidget {
  final int index;
  final String title;

  const MerchantDetailsTabItem({
    super.key,
    required this.index,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;

    return Obx(() {
      final isSelected = controller.activeTabIndex.value == index;

      return Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            controller.activeTabIndex.value = index;
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: context.bodyMedium.copyWith(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.subtitleTextColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    });
  }
}
