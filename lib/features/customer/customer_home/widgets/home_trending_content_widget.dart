import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
import '../controller/home_controller.dart';
import 'recommended_content/recommended_content_card.dart';
import 'recommended_content/recommended_content_empty_state.dart';
import 'recommended_content/recommended_content_shimmer.dart';
import 'section_header.dart';
import 'trending_influencer.dart';
import 'trending_influencer_card.dart';

class HomeTrendingContentWidget extends StatelessWidget {
  const HomeTrendingContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SectionHeader(
        //   title: AppStrings.trendingInfluencer.tr,
        //   onSeeAll: () {
        //     // Navigate to all influencers
        //   },
        // ),

        // Gap(12.h),

        // _buildTrendingInfluencers(context),
        Gap(22.h),

        SectionHeader(
          title: AppStrings.recommendedByContent.tr,
          onSeeAll: () {
            // Navigate to all recommended content
          },
        ),

        Gap(12.h),

        _buildRecommendedContent(context),
      ],
    );
  }

  Widget _buildRecommendedContent(BuildContext context) {
    final controller = HomeController.to;

    return Obx(
      () => ApiStatusBuilder(
        status: controller.creatorContentPaginator.status.value,
        errorMessage: controller.creatorContentPaginator.errorMessage.value,
        onRetry: controller.loadCreatorContent,
        loadingWidget: const RecommendedContentShimmer(),
        isLoadingMore:
            controller.creatorContentPaginator.loadMoreStatus.value ==
            ApiStatus.loading,
        hasMore: controller.creatorContentPaginator.hasMore.value,
        noDataWidget: RecommendedContentEmptyState(
          onRetry: controller.loadCreatorContent,
        ),
        builder: (context) {
          if (controller.contents.isEmpty) {
            return RecommendedContentEmptyState(
              onRetry: controller.loadCreatorContent,
            );
          }

          final contentList = controller.contents.take(2).toList();

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: contentList.length,
            separatorBuilder: (_, _) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final content = contentList[index];

              return RecommendedContentCard(content: content);
            },
          );
        },
      ),
    );
  }

  Widget _buildTrendingInfluencers(BuildContext context) {
    final influencers = [
      const TrendingInfluencer(
        name: 'Ahmed Hassan',
        category: 'Food Creator',
        image: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
      const TrendingInfluencer(
        name: 'Ahmed Hassan',
        category: 'Food Creator',
        image: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
      const TrendingInfluencer(
        name: 'Mohamed Ali',
        category: 'Lifestyle',
        image: 'https://randomuser.me/api/portraits/men/40.jpg',
      ),
      const TrendingInfluencer(
        name: 'Sara Ahmed',
        category: 'Fashion Creator',
        image: 'https://randomuser.me/api/portraits/women/44.jpg',
      ),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: influencers.map((influencer) {
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: TrendingInfluencerCard(
              influencer: influencer,
              onTap: () {
                // Open influencer profile
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
