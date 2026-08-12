import 'package:som_spot/features/customer/customer_business_details/controller/customer_business_details_controller.dart';

import '../../../../../share/controller/screen_export.dart';
import '../../response/customer_search_response.dart';
import 'search_result_info.dart';
import 'search_result_logo.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({super.key, required this.item});
  final CustomerSearchResultModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Get.isRegistered<CustomerBusinessDetailsController>()) {
          Get.delete<CustomerBusinessDetailsController>();
        }
        AppRouter.route.pushNamed(
          RoutePath.customerBusinessDetailsScreen,

          extra: item.id,
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 8.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Row(
          children: [
            SearchResultLogo(imageUrl: item.logo),
            Gap(12.w),
            Expanded(child: SearchResultInfo(item: item)),
            Gap(6.w),
            Icon(
              Iconsax.arrow_right_3,
              color: AppColors.hintTextColor,
              size: 17.sp,
            ),
          ],
        ),
      ),
    );
  }
}
