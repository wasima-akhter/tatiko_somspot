import '../../../../../share/export/screen_export.dart';
import '../widgets/recent_searches.dart';
import '../widgets/trending_search.dart';

class InfluencerSearchScreen extends StatelessWidget {
  const InfluencerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.softBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.softBackgroundColor,
        elevation: 0,

        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, size: 18.sp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        title: Text(
          AppStrings.search.tr,
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),

        centerTitle: false,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.w),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // Text(
                    //   "Search",
                    //   style: context.headlineSmall.copyWith(
                    //     fontWeight: FontWeight.w600,
                    //     color: AppColors.darkTextColor,
                    //   ),
                    // ),

                    // Gap(16.h),
                    TextField(
                      decoration: InputDecoration(
                        hintText: AppStrings.searchBusinessesDeals.tr,

                        hintStyle: context.bodySmall.copyWith(
                          color: Colors.grey,
                        ),

                        prefixIcon: Icon(
                          Iconsax.search_normal,
                          size: 18.sp,
                          color: Colors.grey,
                        ),

                        filled: true,

                        fillColor: AppColors.softBackgroundColor,

                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),

                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Gap(20.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [RecentSearches(), Gap(22.h), TrendingSearch()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
