import '../../../../../helper/text_utils/string_extension.dart';
import '../../../../../share/export/screen_export.dart';
import '../../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../../core/category/model/category_model.dart';
import '../../../customer_business_list/arg/customer_business_list_arg_model.dart';
import '../../../customer_business_list/controller/customer_business_list_controller.dart';

class HomeCategoryCard extends StatelessWidget {
  final CategoryModel item;

  const HomeCategoryCard({super.key, required this.item});

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CustomNetworkImage(
                  imageUrl: item.icon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Gap(4.h),
          SizedBox(
            width: 70.w,
            child: Text(
              item.name.capitalizeWords(),
              style: context.titleSmall,
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
