import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../controller/customer_business_details_controller.dart';

class MerchantAboutGallery extends StatelessWidget {
  const MerchantAboutGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerBusinessDetailsController.to;

    return Obx(() {
      final business = controller.business.value;

      if (business == null || business.gallery.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(24.h),

          Text(
            AppStrings.gallery.tr,
            style: context.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),

          Gap(12.h),

          SizedBox(
            height: 100.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: business.gallery.length,
              separatorBuilder: (_, _) => Gap(12.w),
              itemBuilder: (_, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CustomNetworkImage(
                    imageUrl: business.gallery[index],
                    width: 100.w,
                    height: 100.h,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
