import 'package:som_spot/features/offers/offers_list/controller/offer_controller.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';

import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/dropdown/custom_dropdown_field.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../controller/merchant_new_campaign_controller.dart';
import '../widgets/campaign_bottom_buttons.dart';
import '../widgets/campaign_date_field.dart';
import '../widgets/campaign_option_chip.dart';
import '../widgets/campaign_section_title.dart';
import '../widgets/campaign_text_field.dart';

class MerchantNewCampaignScreen extends StatelessWidget {
  const MerchantNewCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MerchantNewCampaignController.to;

    return ScaffoldWrapper(
      backgroundColor: const Color(0xffF5FAFF),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, size: 18.sp),
          onPressed: () {
            AppRouter.route.goNamed(RoutePath.navigationPages);
          },
        ),

        title: Text(
          "New Campaign",
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),

        centerTitle: false,
      ),
      body: Obx(
        () => ApiStatusBuilder(
          status: controller.pageStatus.value,

          errorMessage: controller.errorMessage.value,
          loadingWidget: CampaignLoadingView(),

          onRetry: controller.loadInitialData,

          builder: (context) {
            return Column(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),

                  child: Form(
                    key: controller.formKey,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Gap(20),

                        // Campaign Name
                        CustomTextField(
                          title: "Campaign Name",
                          hintText: "e.g Buy 1 Get 1 Free Promo",
                          controller: controller.campaignNameController,
                        ),

                        SizedBox(height: 16.h),

                        // Objective
                        CampaignSectionTitle(title: "Objective"),

                        SizedBox(height: 8.h),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),

                          itemCount: controller.objectives.length,

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.w,
                                mainAxisSpacing: 8.h,
                                childAspectRatio: 3.5,
                              ),

                          itemBuilder: (context, index) {
                            final item = controller.objectives[index];

                            return Obx(
                              () => CampaignOptionChip(
                                title: item,

                                selected:
                                    controller.selectedObjective.value == item,

                                onTap: () {
                                  controller.selectObjective(item);
                                },
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 8.h),

                        // Content Type
                        CampaignSectionTitle(title: "Content Type"),

                        SizedBox(height: 8.h),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),

                          itemCount: controller.contentTypes.length,

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.w,
                                mainAxisSpacing: 8.h,
                                childAspectRatio: 3.5,
                              ),

                          itemBuilder: (context, index) {
                            final item = controller.contentTypes[index];

                            return Obx(
                              () => CampaignOptionChip(
                                title: item,

                                selected:
                                    controller.selectedContentType.value ==
                                    item,

                                onTap: () {
                                  controller.selectContentType(item);
                                },
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 8.h),

                        // Offer
                        CampaignSectionTitle(title: "Select Offer"),

                        SizedBox(height: 8.h),

                        Obx(
                          () => CustomDropdownField<String>(
                            hintText: "Select Offer",

                            isRequired: true,

                            value: controller.selectedOfferId.value.isEmpty
                                ? null
                                : controller.selectedOfferId.value,

                            items: OffersController.to.paginator.items
                                .map((e) => e.id)
                                .toList(),

                            labelBuilder: (id) {
                              return OffersController.to.paginator.items
                                      .firstWhereOrNull((e) => e.id == id)
                                      ?.title ??
                                  "";
                            },

                            onChanged: controller.selectOffer,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Category
                        CampaignSectionTitle(title: "Influencer Category"),

                        SizedBox(height: 8.h),

                        Obx(() {
                          final categories = controller.categories;

                          return CustomDropdownField<String>(
                            hintText: "Select Category",

                            isRequired: true,

                            value: controller.selectedCategory.value.isEmpty
                                ? null
                                : controller.selectedCategory.value,

                            items: categories.map((e) => e.id).toList(),

                            labelBuilder: (id) {
                              return categories
                                      .firstWhereOrNull((e) => e.id == id)
                                      ?.name ??
                                  "";
                            },

                            onChanged: controller.selectCategory,
                          );
                        }),

                        SizedBox(height: 16.h),

                        // Creator Count
                        CampaignNumberField(
                          label: "Target Number of Creators",

                          hint: "Enter number of creators",

                          controller: controller.creatorCountController,

                          min: 1,
                        ),

                        SizedBox(height: 16.h),

                        // Dates
                        Row(
                          children: [
                            Expanded(
                              child: CampaignDateField(
                                label: "Start Date",

                                controller: controller.startDateController,
                              ),
                            ),

                            SizedBox(width: 12.w),

                            Expanded(
                              child: CampaignDateField(
                                label: "End Date",

                                controller: controller.endDateController,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        // Requirements
                        CustomTextField(
                          title: "Content Requirements",

                          hintText: "e.g 1 TikTok Video, 2 Instagram Stories",

                          controller: controller.requirementsController,

                          maxLines: 5,

                          minLines: 3,
                        ),

                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),

                CampaignBottomButtons(onNext: controller.onCampaignNext),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CampaignLoadingView extends StatelessWidget {
  const CampaignLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LoadingWidget(),

          SizedBox(height: 16.h),

          Text("Preparing campaign form...", style: context.bodyMedium),
        ],
      ),
    );
  }
}
