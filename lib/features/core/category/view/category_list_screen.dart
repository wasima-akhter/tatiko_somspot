import 'package:som_spot/features/core/category/controller/category_controller.dart';
import 'package:som_spot/features/customer/customer_business_list/arg/customer_business_list_arg_model.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../../helper/text_utils/string_extension.dart';
import '../../../../share/controller/screen_export.dart';
import '../../../customer/customer_business_list/controller/customer_business_list_controller.dart';

class CategoryListScreen extends GetView<CategoryController> {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.backgroundColorNew,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          AppStrings.categories.tr,
          style: context.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkTextColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => ApiStatusBuilder(
            status: controller.categoryPaginator.status.value,
            errorMessage: controller.categoryPaginator.errorMessage.value,
            onRetry: () => controller.categoryPaginator.refresh(),
            isLoadingMore:
                controller.categoryPaginator.loadMoreStatus.value ==
                ApiStatus.loading,
            hasMore: controller.categoryPaginator.hasMore.value,
            builder: (_) {
              return GridView.builder(
                shrinkWrap: true,
                controller: controller.categoryScrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.85,
                ),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final item = controller.categories[index];
                  return GestureDetector(
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
                              color: AppColors.primaryColor.withValues(
                                alpha: 0.08,
                              ),
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
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
