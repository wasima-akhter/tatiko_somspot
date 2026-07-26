import 'package:som_spot/features/auth/complete_business_profile/controller/complete_business_profile_controller.dart';
import 'package:som_spot/share/controller/screen_export.dart';
import 'package:som_spot/share/widgets/text_field/custom_text_field.dart';

import '../../../../core/category/controller/category_controller.dart';

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

    final categoryController = CategoryController.to;

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

          Text(
            AppStrings.category.tr,

            style: context.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextColor,
            ),
          ),

          Gap(12.h),

          // Category Selector
          Obx(() {
            if (categoryController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

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
                        Icon(
                          _getCategoryIcon(category.icon),

                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.subtitleTextColor,

                          size: 24.sp,
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
          }),

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

  IconData _getCategoryIcon(String icon) {
    switch (icon) {
      case "restaurant":
        return Icons.restaurant_outlined;

      case "grocery":
        return Icons.shopping_basket_outlined;

      case "pharmacy":
        return Icons.local_pharmacy_outlined;

      case "supermarket":
        return Icons.shopping_cart_outlined;

      case "cafe":
        return Icons.local_cafe_outlined;

      case "electronics":
        return Icons.phone_android_outlined;

      default:
        return Icons.store_outlined;
    }
  }
}
