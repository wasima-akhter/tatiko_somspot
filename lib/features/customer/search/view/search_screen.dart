import 'package:som_spot/features/customer/search/controller/search_controller.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/network_image/custom_network_image.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
import '../response/customer_search_response.dart';

class SearchScreen extends GetView<SearchScreenController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      appBar: AppBar(toolbarHeight: 0, backgroundColor: AppColors.white),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: Obx(() {
                if (controller.isSearchActive.value) {
                  return _buildSearchResults(context);
                }

                return _buildDefaultSearchContent(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Search",
                  style: context.titleLarge.copyWith(
                    color: AppColors.darkTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
              ),

              Obx(() {
                if (!controller.isSearchActive.value) {
                  return const SizedBox.shrink();
                }

                return GestureDetector(
                  onTap: controller.resetSearch,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Iconsax.refresh,
                          color: AppColors.primaryColor,
                          size: 15.sp,
                        ),
                        Gap(5.w),
                        Text(
                          "Reset",
                          style: context.bodySmall.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),

          Gap(16.h),

          _buildSearchField(context),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Search Field
  // ---------------------------------------------------------------------------

  Widget _buildSearchField(BuildContext context) {
    return Container(
      height: 52.h,
      decoration: BoxDecoration(
        color: AppColors.bgSecondaryButtonColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.backgroundsLinesColor, width: 1.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Icon(
            Iconsax.search_normal,
            color: AppColors.hintTextColor,
            size: 20.sp,
          ),

          Gap(12.w),

          Expanded(
            child: TextField(
              controller: controller.searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                controller.search(value);
              },
              decoration: InputDecoration(
                hintText: "Search businesses or deals...",
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintStyle: context.bodyMedium.copyWith(
                  color: AppColors.hintTextColor,
                  fontSize: 14.sp,
                ),
              ),
              style: context.bodyMedium.copyWith(
                color: AppColors.darkTextColor,
                fontSize: 14.sp,
              ),
            ),
          ),

          Obx(() {
            if (!controller.isSearchActive.value) {
              return const SizedBox.shrink();
            }

            return GestureDetector(
              onTap: controller.resetSearch,
              child: Icon(
                Iconsax.close_circle,
                color: AppColors.hintTextColor,
                size: 19.sp,
              ),
            );
          }),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Default State
  // Recent + Trending
  // ---------------------------------------------------------------------------

  Widget _buildDefaultSearchContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        color: AppColors.primaryColor.withValues(alpha: 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecentSearches(context),
            _buildTrendingSearches(context),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Recent Searches
  // ---------------------------------------------------------------------------

  Widget _buildRecentSearches(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ApiStatusBuilder(
            status: controller.clearRecentSearchStatus.value,
            errorMessage: controller.clearRecentSearchErrorMessage.value,
            onRetry: controller.clearRecentSearches,
            loadingWidget: SizedBox(
              height: 20.h,
              width: 20.h,
              child: Padding(
                padding: EdgeInsets.all(2.w),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            noDataWidget: const Text("data"),
            builder: (_) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Iconsax.clock,
                            color: AppColors.darkTextColor,
                            size: 18.sp,
                          ),
                          Gap(8.w),
                          Text(
                            "Recent Searches",
                            style: context.titleMedium.copyWith(
                              color: AppColors.darkTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),

                      GestureDetector(
                        onTap: controller.clearRecentSearches,
                        child: Text(
                          "Clear",
                          style: context.bodyMedium.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  //
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: controller.recentSearches.map((item) {
                      return GestureDetector(
                        onTap: () {
                          controller.searchController.text = item.term;
                          controller.search(item.term);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: AppColors.backgroundsLinesColor,
                              width: 1.w,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 13.w,
                            vertical: 8.h,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Iconsax.clock,
                                size: 13.sp,
                                color: AppColors.hintTextColor,
                              ),
                              Gap(6.w),
                              Text(
                                item.term,
                                style: context.bodyMedium.copyWith(
                                  color: AppColors.darkTextColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),

          Gap(24.h),
        ],
      );
    });
  }

  // ---------------------------------------------------------------------------
  // Trending
  // ---------------------------------------------------------------------------

  Widget _buildTrendingSearches(BuildContext context) {
    return Obx(() {
      if (controller.trendingSearchStatus.value == ApiStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.trendingSearches.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.trend_up,
                color: AppColors.darkTextColor,
                size: 18.sp,
              ),
              Gap(8.w),
              Text(
                "Trending Now",
                style: context.titleMedium.copyWith(
                  color: AppColors.darkTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),

          Gap(12.h),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.trendingSearches.length,
            separatorBuilder: (_, _) => Gap(10.h),
            itemBuilder: (context, index) {
              final item = controller.trendingSearches[index];

              return GestureDetector(
                onTap: () {
                  controller.search(item.term);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 6.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Iconsax.trend_up,
                          color: AppColors.primaryColor,
                          size: 18.sp,
                        ),
                      ),

                      Gap(12.w),

                      Expanded(
                        child: Text(
                          item.term,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodyLarge.copyWith(
                            color: AppColors.darkTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),

                      if (item.count > 0) ...[
                        Text(
                          "${item.count}",
                          style: context.bodySmall.copyWith(
                            color: AppColors.hintTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gap(8.w),
                      ],

                      Icon(
                        Iconsax.arrow_right_3,
                        color: AppColors.hintTextColor,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          Gap(20.h),
        ],
      );
    });
  }

  // ---------------------------------------------------------------------------
  // Search Results State
  // ---------------------------------------------------------------------------

  Widget _buildSearchResults(BuildContext context) {
    return Obx(
      () => ApiStatusBuilder(
        status: controller.searchStatus.value,
        errorMessage: controller.searchErrorMessage.value,
        onRetry: () {
          controller.search(controller.searchController.text);
        },
        builder: (_) {
          if (controller.searchResults.isEmpty) {
            return _buildNoSearchResults(context);
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
            itemCount: controller.searchResults.length,
            separatorBuilder: (_, _) => Gap(12.h),
            itemBuilder: (context, index) {
              final item = controller.searchResults[index];

              return _buildSearchResultCard(context, item);
            },
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Search Result Card
  // ---------------------------------------------------------------------------

  Widget _buildSearchResultCard(
    BuildContext context,
    CustomerSearchResultModel item,
  ) {
    return GestureDetector(
      onTap: () {
        AppRouter.route.pushNamed(RoutePath.merchantDetailsScreen, extra: item);
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 8.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CustomNetworkImage(
                imageUrl: item.logo,
                width: 72.w,
                height: 72.w,
                fit: BoxFit.cover,
              ),
            ),

            Gap(12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleMedium.copyWith(
                      color: AppColors.darkTextColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Gap(4.h),

                  Text(
                    item.category?.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),

                  Gap(6.h),

                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: AppColors.orangeSecondaryAccentColor,
                        size: 15.sp,
                      ),
                      Gap(4.w),
                      Text(
                        item.ratingAvg.toStringAsFixed(1),
                        style: context.bodySmall.copyWith(
                          color: AppColors.darkTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(5.w),
                      Text(
                        "(${item.ratingCount})",
                        style: context.bodySmall.copyWith(
                          color: AppColors.hintTextColor,
                        ),
                      ),
                    ],
                  ),

                  Gap(5.h),

                  Text(
                    item.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall.copyWith(
                      color: AppColors.subtitleTextColor,
                    ),
                  ),
                ],
              ),
            ),

            Gap(6.w),

            Icon(
              Iconsax.arrow_right_3,
              color: AppColors.hintTextColor,
              size: 17.sp,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // No Search Results
  // ---------------------------------------------------------------------------

  Widget _buildNoSearchResults(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 62.w,
              height: 62.w,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.search_status,
                color: AppColors.primaryColor,
                size: 28.sp,
              ),
            ),

            Gap(14.h),

            Text(
              "No results found",
              textAlign: TextAlign.center,
              style: context.titleMedium.copyWith(
                color: AppColors.darkTextColor,
                fontWeight: FontWeight.w700,
              ),
            ),

            Gap(6.h),

            Text(
              "We couldn't find anything matching your search.",
              textAlign: TextAlign.center,
              style: context.bodySmall.copyWith(
                color: AppColors.subtitleTextColor,
                height: 1.4,
              ),
            ),

            Gap(16.h),

            SizedBox(
              height: 40.h,
              child: OutlinedButton.icon(
                onPressed: controller.resetSearch,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: BorderSide(color: AppColors.primaryColor, width: 1.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
                icon: Icon(Iconsax.refresh, size: 16.sp),
                label: Text(
                  "Reset Search",
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
    );
  }
}
