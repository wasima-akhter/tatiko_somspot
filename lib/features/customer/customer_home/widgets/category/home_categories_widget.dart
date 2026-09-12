import '../../../../../share/export/screen_export.dart';
import '../../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../../utils/enum/app_enum.dart';
import '../../../../core/category/binding/category_binding_helper.dart';
import 'home_category_item_card.dart';

class HomeCategoriesWidget extends StatelessWidget {
  const HomeCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryBindings.customerController;

    return Obx(() {
      return ApiStatusBuilder(
        status: controller.categoryPaginator.status.value,
        errorMessage: controller.categoryPaginator.errorMessage.value,
        onRetry: () => controller.categoryPaginator.refresh(),

        noDataWidget: noCategoriesPlaceholder(
          context,
          onTapRetry: () => controller.categoryPaginator.refresh(),
        ),
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

Widget noCategoriesPlaceholder(
  BuildContext context, {
  required VoidCallback onTapRetry,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppStrings.category.tr,
        style: context.titleLarge.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextColor,
        ),
      ),

      Gap(12.h),

      Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.backgroundsLinesColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.category_outlined,
                size: 20.sp,
                color: AppColors.primaryColor,
              ),
            ),

            Gap(12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "No categories available",
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkTextColor,
                    ),
                  ),

                  Gap(4.h),

                  Text(
                    "Categories will appear here once they are added.",
                    style: context.bodyMedium.copyWith(
                      color: AppColors.subtitleTextColor,
                      height: 1.4,
                    ),
                  ),

                  Gap(10.h),

                  SizedBox(
                    height: 30.h,
                    child: TextButton.icon(
                      onPressed: onTapRetry,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: AppColors.primaryColor,
                      ),
                      icon: Icon(Icons.refresh_rounded, size: 14.sp),
                      label: Text(
                        AppStrings.tryAgain.tr,
                        style: context.bodySmall.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
