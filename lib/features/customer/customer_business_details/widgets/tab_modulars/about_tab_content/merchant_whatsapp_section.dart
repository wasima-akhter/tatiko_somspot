import 'package:auto_shimmer_animate/auto_shimmer_animate.dart';
import 'package:som_spot/share/export/screen_export.dart';

import '../../../../../../core/custom_assets/assets.gen.dart';
import '../../../../../../helper/launcher/launcher_helper.dart';
import '../../../../../../utils/enum/app_enum.dart';
import '../../../controller/customer_business_details_controller.dart';

class MerchantAboutWhatsApp extends StatelessWidget {
  const MerchantAboutWhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;

    return Obx(() {
      final status = controller.businessStatus.value;
      final business = controller.business.value;

      if (status == ApiStatus.loading && business == null) {
        return const MerchantAboutWhatsAppSkeleton();
      }

      if (business == null || business.whatsapp.trim().isEmpty) {
        return const SizedBox.shrink();
      }

      final whatsapp = business.whatsapp.trim();

      debugPrint('whatsapp: $whatsapp');

      return Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              LauncherHelper.launchWhatsApp(context, whatsapp);
            },
            child: Assets.icons.whatsapps.svg(height: 35.w, width: 35.w),
          ),
          Gap(2.h),
          Text(
            whatsapp,
            style: context.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextColor,
            ),
          ),
        ],
      );
    });
  }
}

class MerchantAboutWhatsAppSkeleton extends StatelessWidget {
  const MerchantAboutWhatsAppSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),

              child: AutoShimmerAnimate(isLoading: true, child: Container()),
            ),
          ],
        ),
      ],
    );
  }
}
