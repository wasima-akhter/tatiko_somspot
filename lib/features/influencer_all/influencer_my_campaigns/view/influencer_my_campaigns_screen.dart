import '../../../../share/controller/screen_export.dart';
import '../controller/influencer_my_campaigns_controller.dart';
import '../widgets/my_campaign_card.dart';
import '../widgets/my_campaign_tab_switcher.dart';

class InfluencerMyCampaignsScreen extends StatelessWidget {
  const InfluencerMyCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InfluencerMyCampaignsController.to;
    return ScaffoldWrapper(
      backgroundColor: AppColors.softBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.softBackgroundColor,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, size: 18.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.myCampaigns.tr,
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverToBoxAdapter(
                child: Obx(
                  () => CampaignTabSwitcher(
                    activeCount: controller.activeCampaigns.length,
                    completedCount: controller.completedCampaigns.length,
                    isActiveSelected: controller.isActive.value,
                    onChanged: controller.changeTab,
                  ),
                ),
              ),
            ),

            Obx(
              () => SliverPadding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 18.h,
                  bottom: 20.h,
                ),
                sliver: SliverList.builder(
                  itemCount: controller.campaigns.length,
                  itemBuilder: (_, index) => Padding(
                    padding: EdgeInsets.only(bottom: 14.h),
                    child: MyCampaignCard(
                      campaign: controller.campaigns[index],
                    ),
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
