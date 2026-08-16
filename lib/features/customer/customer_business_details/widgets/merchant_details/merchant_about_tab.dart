import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';

import '../../controller/customer_business_details_controller.dart';
import '../tab_modulars/about_tab_content/merchant_about_details_card.dart';
import '../tab_modulars/about_tab_content/merchant_about_gallery.dart';
import '../tab_modulars/about_tab_content/merchant_about_rating.dart';
import '../tab_modulars/about_tab_content/merchant_about_skeleton.dart';

class MerchantAboutTab extends GetView<CustomerBusinessDetailsController> {
  const MerchantAboutTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.businessStatus.value,
        errorMessage: controller.businessErrorMessage.value,
        loadingWidget: const MerchantAboutSkeleton(),
        onRetry: controller.refreshBusinessDetails,
        builder: (_) {
          final business = controller.business.value!;

          return CustomRefreshIndicator(
            onRefresh: controller.refreshBusinessDetails,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (business.description.trim().isNotEmpty) ...[
                    Text(
                      business.description.trim(),
                      style: context.bodyMedium.copyWith(
                        color: AppColors.subtitleTextColor,
                        height: 1.5,
                      ),
                    ),
                    Gap(16.h),
                  ],

                  const MerchantAboutDetailsCard(),

                  const MerchantAboutGallery(),

                  const MerchantAboutRating(),

                  Gap(24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
