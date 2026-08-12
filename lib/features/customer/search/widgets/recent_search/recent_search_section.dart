import '../../../../../share/controller/screen_export.dart';
import '../../../../../share/widgets/loading/loading_widget.dart';
import '../../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../controller/search_controller.dart';
import '../../response/customer_search_response.dart';

class RecentSearchesSection extends StatelessWidget {
  const RecentSearchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SearchScreenController.to;

    return Obx(() {
      return ApiStatusBuilder(
        status: controller.recentSearchStatus.value,
        errorMessage: controller.recentSearchErrorMessage.value,
        onRetry: controller.loadRecentSearches,
        loadingWidget: const LoadingWidget(),
        noDataWidget: const NoRecentSearchWidget(),
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const RecentSearchContent(), Gap(24.h)],
          );
        },
      );
    });
  }
}

class RecentSearchContent extends StatelessWidget {
  const RecentSearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SearchScreenController.to;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RecentSearchHeader(onClear: controller.clearRecentSearches),
        Gap(8.h),
        RecentSearchList(
          searches: controller.recentSearches,
          onSearchTap: (term) {
            controller.searchController.text = term;
            controller.search(term);
          },
        ),
      ],
    );
  }
}

class RecentSearchHeader extends StatelessWidget {
  const RecentSearchHeader({super.key, required this.onClear});

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Iconsax.clock, color: AppColors.darkTextColor, size: 18.sp),
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
          onTap: onClear,
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
    );
  }
}

class RecentSearchList extends StatelessWidget {
  const RecentSearchList({
    super.key,
    required this.searches,
    required this.onSearchTap,
  });

  final List<RecentSearchModel> searches;
  final ValueChanged<String> onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: searches.map((item) {
        return RecentSearchItem(
          term: item.term,
          onTap: () => onSearchTap(item.term),
        );
      }).toList(),
    );
  }
}

class RecentSearchItem extends StatelessWidget {
  const RecentSearchItem({super.key, required this.term, required this.onTap});

  final String term;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.backgroundsLinesColor,
            width: 1.w,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Iconsax.clock, size: 13.sp, color: AppColors.hintTextColor),
            Gap(6.w),
            Text(
              term,
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
  }
}

class NoRecentSearchWidget extends StatelessWidget {
  const NoRecentSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.backgroundsLinesColor,
            width: 1.w,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 52.h,
              width: 52.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.clock,
                size: 24.sp,
                color: AppColors.primaryColor,
              ),
            ),
            Gap(12.h),
            Text(
              "No Recent Searches",
              style: context.titleMedium.copyWith(
                color: AppColors.darkTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(4.h),
            Text(
              "Your recent searches will appear here",
              style: context.bodyMedium.copyWith(
                color: AppColors.hintTextColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
