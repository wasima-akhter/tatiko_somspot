/*

3.2 Trending Influencers / Creators Carousel
Route: GET {{baseUrl}}/creator/trending?limit=10
Auth: Public
Query Filters: limit=10
Success Response (200 OK):
{
  "statusCode": 200,
  "success": true,
  "message": "Trending creators retrieved",
  "data": [
    {
      "_id": "6a7965d5f792519d4eada805",
      "user": {
        "_id": "6a7965d5f792519d4eada804",
        "name": "Ahmed Hassan",
        "profile_image": "https://cdn.somspot.so/profiles/ahmed_hassan.png"
      },
      "bio": "Mogadishu's top food reviewer & creator",
      "category": {
        "_id": "6a7965d4f792519d4eada7fe",
        "name": "Food Creator",
        "slug": "food-creator",
        "icon": "https://cdn.somspot.so/icons/food-creator.png"
      },
      "followerCount": 50000,
      "engagementRate": 8.5
    }
  ]
}

*/

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../../utils/enum/app_enum.dart';
import '../controller/home_controller.dart';
import 'recommended_content_card.dart';
import 'recommended_content_empty_state.dart';
import 'recommended_content_shimmer.dart';
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
        SectionHeader(
          title: AppStrings.trendingInfluencer.tr,
          onSeeAll: () {
            // Navigate to all influencers
          },
        ),

        Gap(12.h),

        _buildTrendingInfluencers(context),

        Gap(22.h),

        SectionHeader(
          title: AppStrings.recommendedByContent.tr,
          onSeeAll: () {
            // Navigate to all recommended content
          },
        ),

        Gap(12.h),

        Obx(() => _buildRecommendedContent(context)),
      ],
    );
  }

  Widget _buildRecommendedContent(BuildContext context) {
    final controller = HomeController.to;

    if (controller.contentStatus.value == ApiStatus.noDataFound) {
      return RecommendedContentEmptyState(
        onRetry: controller.fetchCreatorContent,
      );
    }

    return ApiStatusBuilder(
      status: controller.contentStatus.value,
      errorMessage: controller.contentError,
      onRetry: () => controller.fetchCreatorContent(),
      loadingWidget: const RecommendedContentShimmer(),
      builder: (context) {
        return Column(
          children: controller.contents.map((content) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: RecommendedContentCard(content: content),
            );
          }).toList(),
        );
      },
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
