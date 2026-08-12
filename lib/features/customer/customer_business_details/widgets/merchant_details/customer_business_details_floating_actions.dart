import 'package:som_spot/features/customer/customer_home/model/merchant_model.dart';
import 'package:som_spot/helper/toast/toast_helper.dart';
import 'package:som_spot/share/controller/screen_export.dart';

class MerchantDetailsFloatingActions extends StatelessWidget {
  const MerchantDetailsFloatingActions({super.key});

  @override
  Widget build(BuildContext context) {
    final merchant = mockMerchants.first;

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
          MerchantDetailsActionButton(
            icon: Icons.bookmark_border_rounded,
            onTap: () {
              AppToast.success(
                context: context,
                message: '${merchant.title} ${AppStrings.savedToBookmarks.tr}',
              );
            },
          ),
        ],
      ),
    );
  }
}

class MerchantDetailsActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MerchantDetailsActionButton({
    super.key,
    required this.icon,
    required this.onTap,
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
        child: Icon(icon, color: Colors.white, size: 18.sp),
      ),
    );
  }
}
