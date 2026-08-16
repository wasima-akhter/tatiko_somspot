import '../../../../../../share/export/screen_export.dart';
import '../../../controller/customer_business_details_controller.dart';
import 'merchant_about_info_row.dart';

class MerchantAboutOpeningHours extends StatelessWidget {
  const MerchantAboutOpeningHours({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;

    return Obx(() {
      final business = controller.business.value;

      if (business == null) {
        return const SizedBox.shrink();
      }

      final isOpen = business.isOpen;

      String? subtitle;

      if (isOpen && business.closesAt != null) {
        subtitle =
            '${AppStrings.closesAt.tr} ${formatMerchantTime(business.closesAt!)}';
      } else if (!isOpen && business.opensAt != null) {
        subtitle =
            '${AppStrings.opensAt.tr} ${formatMerchantTime(business.opensAt!)}';
      }

      return MerchantAboutInfoRow(
        icon: Icons.access_time,
        title: isOpen ? AppStrings.openNow.tr : AppStrings.closed.tr,
        subtitle: subtitle,
        titleColor: isOpen ? AppColors.success : AppColors.error,
      );
    });
  }
}

String formatMerchantTime(String time) {
  try {
    final parts = time.split(':');

    if (parts.length < 2) {
      return time;
    }

    int hour = int.parse(parts[0]);
    final minute = parts[1];

    final period = hour >= 12 ? 'PM' : 'AM';

    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour -= 12;
    }

    return '$hour:$minute $period';
  } catch (_) {
    return time;
  }
}
