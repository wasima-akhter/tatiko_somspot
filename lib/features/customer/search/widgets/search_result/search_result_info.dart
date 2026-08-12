import '../../../../../share/controller/screen_export.dart';
import '../../response/customer_search_response.dart';
import 'search-result_rating.dart';

class SearchResultInfo extends StatelessWidget {
  const SearchResultInfo({super.key, required this.item});
  final CustomerSearchResultModel item;
  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: context.bodySmall.copyWith(color: AppColors.subtitleTextColor),
        ),
        Gap(6.h),
        SearchResultRating(
          rating: item.ratingAvg,
          ratingCount: item.ratingCount,
        ),
        Gap(5.h),
        Text(
          item.address,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.bodySmall.copyWith(color: AppColors.subtitleTextColor),
        ),
      ],
    );
  }
}
