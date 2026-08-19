import 'package:som_spot/features/core/category/controller/category_controller.dart';
import 'package:som_spot/features/core/category/widget/category_screen_item_card.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../../share/export/screen_export.dart';

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
              return CustomRefreshIndicator(
                onRefresh: () => controller.categoryPaginator.refresh(),
                child: GridView.builder(
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
                    return CategoryScreenItemCard(item: item);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
