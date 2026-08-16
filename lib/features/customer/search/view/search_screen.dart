import 'package:som_spot/features/customer/search/controller/search_controller.dart';
import 'package:som_spot/features/customer/search/widgets/recent_search/recent_search_section.dart';
import 'package:som_spot/features/customer/search/widgets/search_result/no_search_result_widget.dart';
import 'package:som_spot/share/widgets/refresh_indicator/refresh_indicator.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../widgets/search_result/search_result_card.dart';
import '../widgets/trending_search_section/trending_search_section.dart';

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
                // ---------------------------------------------------------------------------
                // Search Result Card
                // ---------------------------------------------------------------------------

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
                  AppStrings.search.tr,
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
                  behavior: HitTestBehavior.opaque,
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
                          AppStrings.reset.tr,
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
                hintText: AppStrings.searchBusinessesOrDeals.tr,
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
              behavior: HitTestBehavior.opaque,
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
    return CustomRefreshIndicator(
      onRefresh: () async {
        await controller.loadRecentSearches();
        await controller.loadTrendingSearches();
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          color: AppColors.backgroundColorNew,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------------------------------------------------------------------
              // Recent Searches
              // ---------------------------------------------------------------------------
              RecentSearchesSection(),

              // ---------------------------------------------------------------------------
              // Trending
              // ---------------------------------------------------------------------------
              TrendingSearchesSection(),
            ],
          ),
        ),
      ),
    );
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
        loadingWidget: const SearchResultsShimmer(),
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

              return SearchResultCard(item: item);
            },
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // No Search Results
  // ---------------------------------------------------------------------------

  Widget _buildNoSearchResults(BuildContext context) {
    return NoSearchResultWidget();
  }
}
