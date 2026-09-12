import 'package:som_spot/features/auth/complete_business_profile/controller/complete_business_profile_controller.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../../utils/enum/app_enum.dart';
import '../../../../core/category/controller/category_controller.dart';
import '../../../../customer/customer_home/widgets/category/home_categories_widget.dart';

class BusinessCategory {
  final String labelKey;
  final IconData icon;

  const BusinessCategory({required this.labelKey, required this.icon});
}

class BusinessInfoStep extends StatelessWidget {
  const BusinessInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CompleteBusinessProfileController.to;

    final categoryController = Get.find<CategoryController>(
      tag: 'businessProfileCategory',
    );

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Gap(8.h),

          Text(
            AppStrings.tellUsAboutBusiness.tr,
            style: context.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkTextColor,
            ),
          ),

          Gap(8.h),

          Text(
            AppStrings.businessDiscoverSubtitle.tr,
            style: context.bodyLarge.copyWith(
              color: AppColors.subtitleTextColor,
              height: 1.5,
            ),
          ),

          Gap(24.h),

          CustomTextField(
            controller: controller.businessNameController,

            title: AppStrings.businessName.tr,

            hintText: AppStrings.enterBusinessName.tr,

            textInputAction: TextInputAction.next,
          ),

          Gap(24.h),

          // Category Selector
          Obx(
            () => ApiStatusBuilder(
              status: categoryController.categoryPaginator.status.value,
              errorMessage:
                  categoryController.categoryPaginator.errorMessage.value,
              onRetry: categoryController.refreshCategories,
              isLoadingMore:
                  categoryController.categoryPaginator.loadMoreStatus.value ==
                  ApiStatus.loading,
              hasMore: categoryController.categoryPaginator.hasMore.value,
              builder: (_) {
                final categories = categoryController.categories;

                if (categories.isEmpty) {
                  return noCategoriesPlaceholder(
                    context,
                    onTapRetry: () => categoryController.refreshCategories(),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.category.tr,
                      style: context.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkTextColor,
                      ),
                    ),
                    Gap(12.h),
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: categories.map((category) {
                        return Obx(() {
                          final isSelected =
                              controller.selectedCategoryId.value ==
                              category.id;
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
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
                                    ? AppColors.primaryColor.withValues(
                                        alpha: 0.05,
                                      )
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
                                    width: 28.w,
                                    height: 28.w,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withValues(
                                              alpha: 0.12,
                                            ),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          3.r,
                                        ),
                                        child: CustomNetworkImage(
                                          imageUrl: category.icon,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(8.h),
                                  Text(
                                    category.name,
                                    textAlign: TextAlign.center,
                                    style: context.labelMedium.copyWith(
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
                        });
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
          Gap(24.h),

          CustomTextField(
            controller: controller.shortDescriptionController,

            title: AppStrings.shortDescription.tr,

            hintText: AppStrings.businessDescriptionHint.tr,

            maxLines: 4,

            minLines: 3,

            textInputAction: TextInputAction.done,
          ),

          Gap(32.h),
        ],
      ),
    );
  }
}
