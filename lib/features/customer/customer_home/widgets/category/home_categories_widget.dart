import 'package:som_spot/features/core/category/controller/category_controller.dart';

import '../../../../../share/export/screen_export.dart';
import '../../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../../utils/enum/app_enum.dart';
import 'home_category_item_card.dart';

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
                    behavior: HitTestBehavior.opaque,
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
                          child: HomeCategoryCard(item: item),
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
