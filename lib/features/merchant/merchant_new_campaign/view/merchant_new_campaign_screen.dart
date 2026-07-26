import '../../../../share/controller/screen_export.dart';
import '../../../../share/widgets/dropdown/custom_dropdown_field.dart';
import '../../../../share/widgets/text_field/custom_text_field.dart';
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

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Gap(20),
                  CustomTextField(
                    title: "Campaign Name",
                    hintText: "e.g Buy 1 Get 1 Free Promo",
                    controller: controller.campaignNameController,
                  ),

                  SizedBox(height: 16.h),

                  CampaignSectionTitle(title: "Objective"),

                  SizedBox(height: 8.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: controller.objectives.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

                          selected: controller.selectedObjective.value == item,

                          onTap: () {
                            controller.selectObjective(item);
                          },
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 16.h),

                  CampaignSectionTitle(title: "Content Type"),

                  SizedBox(height: 8.h),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: controller.contentTypes.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              controller.selectedContentType.value == item,

                          onTap: () {
                            controller.selectContentType(item);
                          },
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 16.h),

                  CampaignSectionTitle(title: "Influencer Category"),

                  SizedBox(height: 8.h),

                  CustomDropdownField<String>(
                    hintText: "Select Category",

                    items: controller.categories,

                    value: controller.selectedCategory.value.isEmpty
                        ? null
                        : controller.selectedCategory.value,

                    isRequired: true,

                    onChanged: (value) {
                      controller.selectedCategory.value = value ?? '';
                    },
                  ),

                  SizedBox(height: 16.h),
                  CampaignNumberField(
                    label: "Target Number of Creators",
                    hint: "Enter number of creators",
                    controller: controller.creatorCountController,
                    min: 1,
                    // max: 50,
                  ),
                  SizedBox(height: 16.h),

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

          CampaignBottomButtons(onNext: controller.onTapNext),
        ],
      ),
    );
  }
}
