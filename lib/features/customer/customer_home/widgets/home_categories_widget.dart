import 'package:som_spot/features/customer/customer_home/controller/home_category_controller.dart';

import '../../../../helper/text_utils/string_extension.dart';
import '../../../../share/controller/screen_export.dart';

class HomeCategoriesWidget extends StatelessWidget {
  const HomeCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeCategoryController.to;

    final categories = controller.categories.length > 7
        ? controller.categories.take(7).toList()
        : controller.categories;

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
              onTap: () {},
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
                        AppRouter.route.pushNamed(
                          RoutePath.categoryMerchantsScreen,
                          extra: item.name,
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
                              child: Center(
                                child: Icon(
                                  item.icon,
                                  color: AppColors.primaryColor,
                                  size: 22.sp,
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
  }
}
