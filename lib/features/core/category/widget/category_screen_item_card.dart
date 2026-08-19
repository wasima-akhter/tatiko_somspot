import '../../../../helper/text_utils/string_extension.dart';
import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../customer/customer_business_list/arg/customer_business_list_arg_model.dart';
import '../../../customer/customer_business_list/controller/customer_business_list_controller.dart';
import '../model/category_model.dart';

class CategoryScreenItemCard extends StatelessWidget {
  final CategoryModel item;
  const CategoryScreenItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (Get.isRegistered<CustomerBusinessListController>()) {
          Get.delete<CustomerBusinessListController>();
        }
        AppRouter.route.pushNamed(
          RoutePath.customerBusinessListScreen,
          extra: CustomerBusinessListArgModel(
            categoryId: item.id,
            categoryName: item.name,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: CustomNetworkImage(
                    imageUrl: item.icon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Gap(8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                item.name.capitalizeWords(),
                style: context.titleSmall.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkTextColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
