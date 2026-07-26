import 'package:som_spot/features/customer/customer_home/controller/home_category_controller.dart';
import 'package:som_spot/share/controller/screen_export.dart';

class HomeCategoriesWidget extends StatelessWidget {
  const HomeCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeCategoryController.to;

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
        SizedBox(
          height: 96.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: controller.categories.length,
            separatorBuilder: (context, index) => Gap(16.w),
            itemBuilder: (context, index) {
              final item = controller.categories[index];
              return GestureDetector(
                onTap: () {
                  AppRouter.route.pushNamed(
                    RoutePath.categoryMerchantsScreen,
                    extra: item.name,
                  );
                },
                child: Column(
                  children: [
                    Container(
                      width: 64.w,
                      height: 64.h,
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
                      child: Center(
                        child: Icon(
                          item.icon,
                          color: AppColors.primaryColor,
                          size: 28.sp,
                        ),
                      ),
                    ),
                    Gap(8.h),
                    Text(
                      item.name,
                      style: context.bodySmall.copyWith(
                        color: AppColors.darkTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
