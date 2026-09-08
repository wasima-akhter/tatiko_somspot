import 'package:som_spot/features/merchant/merchant_new_campaign/shared/helper/campaign_helper.dart';
import 'package:som_spot/features/offers/offers_list/controller/offer_controller.dart';
import 'package:som_spot/helper/text_utils/string_extension.dart';
import 'package:som_spot/share/widgets/loading/loading_widget.dart';

import '../../../../share/export/screen_export.dart';
import '../../../../share/widgets/dropdown/custom_dropdown_field.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';
import '../../../../share/widgets/ui_status_builder/api_status_builder.dart';
import '../../../core/business/controller/business-controller.dart';
import '../../../core/category/binding/category_binding_helper.dart';
import '../controller/merchant_new_campaign_controller.dart';
import '../widgets/campaign_bottom_buttons.dart';
import '../widgets/campaign_date_field.dart';
import '../widgets/campaign_option_chip.dart';
import '../widgets/campaign_section_title.dart';
import '../widgets/campaign_text_field.dart';
import '../widgets/empty_states.dart';

class MerchantNewCampaignScreen extends StatefulWidget {
  const MerchantNewCampaignScreen({super.key});

  @override
  State<MerchantNewCampaignScreen> createState() =>
      _MerchantNewCampaignScreenState();
}

class _MerchantNewCampaignScreenState extends State<MerchantNewCampaignScreen> {
  final categoryController = CategoryBindings.campaignController;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await categoryController.loadInitialCategories();
      await OffersController.to.loadOffers();
      BusinessController.to.refreshBusinesses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = MerchantNewCampaignController.to;

    return ScaffoldWrapper(
      backgroundColor: const Color(0xffF5FAFF),
      title: AppStrings.newCampaign.tr,
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
                          title: AppStrings.campaignName.tr,
                          hintText: AppStrings.campaignNameHint.tr,
                          controller: controller.campaignNameController,
                        ),

                        SizedBox(height: 16.h),

                        // Objective
                        CampaignSectionTitle(title: AppStrings.objective.tr),

                        SizedBox(height: 8.h),

                        if (controller.objectives.isEmpty)
                          CampaignEmptyState(
                            message:
                                'No campaign objectives are available right now.',
                          )
                        else
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
                                  title: item.displayName.capitalizeWords(),
                                  selected:
                                      controller.selectedObjective.value ==
                                      item,
                                  onTap: () {
                                    controller.selectObjective(item);
                                  },
                                ),
                              );
                            },
                          ),
                        SizedBox(height: 8.h),

                        // Content Type
                        CampaignSectionTitle(title: AppStrings.contentType.tr),

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
                                title: item.displayName.capitalizeWords(),

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
                        CampaignSectionTitle(title: AppStrings.selectOffer.tr),

                        SizedBox(height: 8.h),

                        Obx(() {
                          final offers = OffersController.to.paginator.items;

                          if (offers.isEmpty) {
                            return const CampaignEmptyState(
                              message:
                                  'No offers are available. Please create an offer first.',
                            );
                          }

                          return CustomDropdownField<String>(
                            hintText: AppStrings.selectOffer.tr,
                            isRequired: true,
                            value: controller.selectedOfferId.value.isEmpty
                                ? null
                                : controller.selectedOfferId.value,
                            items: offers.map((e) => e.id).toList(),
                            labelBuilder: (id) {
                              return offers
                                      .firstWhereOrNull((e) => e.id == id)
                                      ?.title ??
                                  "";
                            },
                            onChanged: controller.selectOffer,
                          );
                        }),

                        SizedBox(height: 16.h),

                        // Category
                        CampaignSectionTitle(
                          title: AppStrings.influencerCategory.tr,
                        ),

                        SizedBox(height: 8.h),
                        Obx(() {
                          final categories = controller.categories;

                          if (categories.isEmpty) {
                            return const CampaignEmptyState(
                              message:
                                  'No influencer categories are available right now.',
                            );
                          }

                          return CustomDropdownField<String>(
                            hintText: AppStrings.selectCategory.tr,
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
                          label: AppStrings.targetNumberOfInfluencers.tr,

                          hint: AppStrings.enterNumberOfInfluencers.tr,

                          controller: controller.creatorCountController,

                          min: 1,
                        ),

                        SizedBox(height: 16.h),

                        // Dates
                        Row(
                          children: [
                            Expanded(
                              child: CampaignDateField(
                                label: AppStrings.startDate.tr,

                                controller: controller.startDateController,
                              ),
                            ),

                            SizedBox(width: 12.w),

                            Expanded(
                              child: CampaignDateField(
                                label: AppStrings.endDate.tr,

                                controller: controller.endDateController,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16.h),

                        // Requirements
                        CustomTextField(
                          title: AppStrings.contentRequirements.tr,

                          hintText: AppStrings.contentRequirementsHint.tr,

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

          Text(AppStrings.preparingCampaignForm.tr, style: context.bodyMedium),
        ],
      ),
    );
  }
}
