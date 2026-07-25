import '../../../../core/router/routes.dart';
import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/video/video_overlay.dart';
import '../controller/merchat_campaign_content_details_controller.dart';
import '../widgets/merchant_campaign_content_preview_card.dart';

class MerchantCampaignContentDetailsScreen
    extends GetView<MerchantCampaignContentDetailsController> {
  const MerchantCampaignContentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = controller.content;

    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,

      appBar: AppBar(
        backgroundColor: AppColors.backgroundColorNew,
        elevation: 0,
        leading: IconButton(
          onPressed: () => AppRouter.route.pop(),
          icon: Icon(Iconsax.arrow_left_2, size: 18.sp),
        ),
        title: Text(
          "Buy 1 Get 1 Free Promo",
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: MerchantCampaignContentPreviewCard(
            image: data["image"] as String,
            storeName: data["storeName"] as String,
            title: data["title"] as String,
            description: data["description"] as String,
            platform: data["platform"] as String,
            onPlay: () {
              AppVideoOverlay.show(
                context,
                videoUrl: "http://files.inqscribe.com/samples/IS_Intro.mp4",
                title: "Buy 1 Get 1 Free Promo",
              );
            },
          ),
        ),
      ),
    );
  }
}
