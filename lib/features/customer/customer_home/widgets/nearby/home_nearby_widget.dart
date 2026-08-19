import 'package:som_spot/features/customer/customer_home/widgets/nearby/nearby_business_card.dart';
import 'package:som_spot/share/export/screen_export.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';
import 'package:som_spot/share/widgets/ui_status_builder/api_status_builder.dart';
import 'package:som_spot/utils/enum/app_enum.dart';

import '../../controller/home_controller.dart';
import 'nearby_empty_state.dart';

class HomeNearbyWidget extends StatefulWidget {
  const HomeNearbyWidget({super.key});

  @override
  State<HomeNearbyWidget> createState() => _HomeNearbyWidgetState();
}

class _HomeNearbyWidgetState extends State<HomeNearbyWidget> {
  final controller = HomeController.to;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.refreshNearbyBusinesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.nearbyYou.tr,
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.darkTextColor,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => AppRouter.route.pushNamed(
                RoutePath.customerBusinessListScreen,
              ),
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

        Obx(
          () => ApiStatusBuilder(
            status: controller.nearbyBusinessesPaginator.status.value,
            errorMessage:
                controller.nearbyBusinessesPaginator.errorMessage.value,
            noDataWidget: NearbyEmptyState(
              icon: Icons.location_off_outlined,
              title: AppStrings.noNearbyPlacesYet.tr,
              message: AppStrings.noNearbyPlacesMessage.tr,
              onRetry: controller.loadNearbyBusinesses,
            ),
            onRetry: controller.loadNearbyBusinesses,
            isLoadingMore:
                controller.nearbyBusinessesPaginator.loadMoreStatus.value ==
                ApiStatus.loading,
            hasMore: controller.nearbyBusinessesPaginator.hasMore.value,
            builder: (_) {
              if (controller.nearbyBusinessesPaginator.items.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.noNearbyMerchantsFound.tr,
                      style: context.bodyMedium.copyWith(
                        color: AppColors.subtitleTextColor,
                      ),
                    ),
                  ),
                );
              }

              return CustomRefreshIndicator(
                onRefresh: controller.refreshNearbyBusinesses,
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: controller.nearbyBusinessesScrollController,
                  itemCount: controller.nearbyBusinesses.length,
                  separatorBuilder: (context, index) => Gap(16.h),
                  itemBuilder: (context, index) {
                    final item = controller.nearbyBusinesses[index];

                    return NearbyBusinessCard(item: item);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
