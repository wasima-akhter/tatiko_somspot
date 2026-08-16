import 'package:som_spot/features/customer/customer_business_list/controller/customer_business_list_controller.dart';
import 'package:som_spot/features/customer/customer_business_list/widget/customer_business_item_card.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../../../share/export/screen_export.dart';

class CustomerBusinessListScreen
    extends GetView<CustomerBusinessListController> {
  const CustomerBusinessListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: controller.categoryInfo?.categoryName ?? AppStrings.business.tr,
      onPressed: () => AppRouter.route.pop(),
      body: SafeArea(
        child: Obx(
          () => ApiStatusBuilder(
            status: controller.businessListPaginator.status.value,
            errorMessage: controller.categoryInfo == null
                ? AppStrings.noBusinessesFoundUnderCategory.tr
                : controller.businessListPaginator.errorMessage.value,
            onRetry: () => controller.businessListPaginator.refresh(),
            isLoadingMore:
                controller.businessListPaginator.loadMoreStatus.value ==
                ApiStatus.loading,
            hasMore: controller.businessListPaginator.hasMore.value,
            builder: (_) {
              return RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () => controller.refreshBusinesses(),
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: controller.businessListScrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  itemCount: controller.businesses.length,
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) {
                    final item = controller.businesses[index];
                    return CustomerBusinessItemCard(item: item);
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
