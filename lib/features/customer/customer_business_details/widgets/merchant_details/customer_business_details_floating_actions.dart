import 'package:som_spot/share/controller/screen_export.dart';

import '../../../../../share/widgets/loading/loading_widget.dart';
import '../../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../controller/customer_business_details_controller.dart';

class MerchantDetailsFloatingActions extends StatelessWidget {
  const MerchantDetailsFloatingActions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;

    return Positioned(
      top: MediaQuery.of(context).padding.top + 8.h,
      left: 16.w,
      right: 16.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MerchantDetailsActionButton(
            icon: Icons.arrow_back_ios_new,
            onTap: () => Navigator.of(context).pop(),
          ),

          Obx(() {
            return ApiStatusBuilder(
              status: controller.saveStatus.value,
              errorMessage: controller.saveErrorMessage.value,
              onRetry: controller.toggleBusinessSaved,
              loadingWidget: const LoadingWidget(),
              builder: (context) {
                final isSaved = controller.isBusinessSaved.value;

                return MerchantDetailsActionButton(
                  icon: isSaved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: isSaved ? AppColors.blueAccentColor : null,
                  onTap: controller.toggleBusinessSaved,
                );
              },
            );
          }),
        ],
      ),
    );
  }
}

class MerchantDetailsActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  const MerchantDetailsActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color ?? Colors.white, size: 18.sp),
      ),
    );
  }
}
