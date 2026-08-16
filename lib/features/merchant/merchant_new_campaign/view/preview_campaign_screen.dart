import '../../../../share/export/screen_export.dart';
import '../../../../utils/enum/app_enum.dart';
import '../controller/merchant_new_campaign_controller.dart';

class MerchantPreviewCampaignScreen extends StatelessWidget {
  const MerchantPreviewCampaignScreen({super.key});

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
            AppRouter.route.pop();
          },
        ),

        title: Text(AppStrings.previewCampaign.tr),
      ),

      body: Obx(() {
        final creatorCount =
            int.tryParse(controller.creatorCountController.text) ?? 0;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),

          child: Column(
            children: [
              Gap(10.h),

              _card(
                context,

                title: AppStrings.campaignOverview.tr,

                children: [
                  _row(
                    AppStrings.name.tr,
                    controller.campaignNameController.text,
                  ),

                  _row(
                    AppStrings.about.tr,
                    controller.requirementsController.text,
                  ),

                  _row(
                    AppStrings.objective.tr,
                    controller.selectedObjective.value,
                  ),

                  _row(
                    AppStrings.contentType.tr,
                    controller.selectedContentType.value,
                  ),

                  _row(AppStrings.offer.tr, controller.selectedOfferName),

                  _row(
                    AppStrings.duration.tr,
                    "${controller.startDateController.text} - ${controller.endDateController.text}",
                  ),

                  _row(
                    AppStrings.videoLength.tr,
                    "${controller.selectedVideoLength}s",
                  ),
                ],
              ),

              Gap(12.h),

              _card(
                context,

                title: AppStrings.influencerInfo.tr,

                children: [
                  _row(
                    AppStrings.influencerCategory.tr,
                    controller.selectedCategoryName,
                  ),

                  _row(
                    AppStrings.targetInfluencers.tr,
                    "$creatorCount ${AppStrings.influencer.tr}",
                  ),

                  _row(
                    AppStrings.selectedPackage.tr,
                    controller.selectedPackageName,
                  ),

                  _row(
                    AppStrings.packagePrice.tr,
                    controller.selectedPackagePrice,
                  ),

                  Divider(),

                  _row(
                    AppStrings.totalCampaignCost.tr,

                    _calculateTotal(
                      creatorCount,
                      controller.selectedPackagePrice,
                    ),

                    bold: true,
                  ),
                ],
              ),

              Gap(12.h),

              _card(
                context,

                title: AppStrings.contentRequirements.tr,

                children: [
                  Text(
                    controller.requirementsController.text,

                    style: context.bodySmall,
                  ),
                ],
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isOutlined: true,

                      onTap: () {
                        AppRouter.route.pop();
                      },

                      text: AppStrings.backToEdit.tr,
                    ),
                  ),

                  Gap(12.w),

                  Expanded(
                    child: CustomButton(
                      isLoading:
                          controller.submitLoading.value == ApiStatus.loading,
                      onTap: controller.onSubmit,

                      text: AppStrings.submit.tr,
                    ),
                  ),
                ],
              ),

              Gap(20.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _card(
    BuildContext context, {

    required String title,

    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(10.r),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,

            style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
          ),

          Gap(10.h),

          ...children,
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool bold = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Expanded(child: Text(label)),

          Expanded(
            child: Text(
              value,

              textAlign: TextAlign.right,

              style: TextStyle(
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateTotal(int creators, String price) {
    final amount =
        double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

    return "\$${(amount * creators).toStringAsFixed(0)}";
  }
}
