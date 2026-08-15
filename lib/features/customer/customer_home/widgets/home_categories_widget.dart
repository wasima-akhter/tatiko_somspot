import 'package:som_spot/features/core/category/controller/category_controller.dart';
import 'package:som_spot/features/customer/customer_business_list/arg/customer_business_list_arg_model.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../helper/text_utils/string_extension.dart';
import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
import '../../customer_business_list/controller/customer_business_list_controller.dart';

class HomeCategoriesWidget extends StatelessWidget {
  const HomeCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.to;

    return Obx(() {
      return ApiStatusBuilder(
        status: controller.categoryPaginator.status.value,
        errorMessage: controller.categoryPaginator.errorMessage.value,
        onRetry: () => controller.categoryPaginator.refresh(),
        isLoadingMore:
            controller.categoryPaginator.loadMoreStatus.value ==
            ApiStatus.loading,
        hasMore: controller.categoryPaginator.hasMore.value,
        builder: (_) {
          final categories = controller.categories.length > 7
              ? controller.categories.take(7).toList()
              : controller.categories;

          if (categories.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.categories.tr,
                    style: context.titleLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        AppRouter.route.pushNamed(RoutePath.categoryListScreen),
                    child: Text(
                      AppStrings.seeAll.tr,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(16.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: categories
                      .map(
                        (item) => Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: GestureDetector(
                            onTap: () {
                              if (Get.isRegistered<
                                CustomerBusinessListController
                              >()) {
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.03,
                                        ),
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
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}

/*
class HomeCategoriesWidget extends StatelessWidget {
  const HomeCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = CategoryController.to;
    final controller = HomeController.to;

    return // Category Selector
    Obx(() {
      return ApiStatusBuilder(
        status: categoryController.categoryPaginator.status.value,
        errorMessage: categoryController.categoryPaginator.errorMessage.value,
        onRetry: () => categoryController.categoryPaginator.refresh(),
        isLoadingMore:
            categoryController.categoryPaginator.loadMoreStatus.value ==
            ApiStatus.loading,
        hasMore: categoryController.categoryPaginator.hasMore.value,
        builder: (_) {
          return Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: categoryController.categories.map((category) {
              final isSelected =
                  controller.selectedCategoryId.value == category.id;

              return GestureDetector(
                onTap: () {
                  controller.selectedCategoryId.value = category.id;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 74.w,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 4.w,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor.withValues(alpha: 0.05)
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.backgroundsLinesColor,
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: CustomNetworkImage(
                            imageUrl: category.icon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Gap(8.h),
                      Text(
                        category.name,
                        textAlign: TextAlign.center,
                        style: context.labelSmall.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.darkTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      );
    });
  }
}

*/
