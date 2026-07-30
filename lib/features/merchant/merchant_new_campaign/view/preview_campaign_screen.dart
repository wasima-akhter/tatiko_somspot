import '../../../../share/controller/screen_export.dart';
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

        title: const Text("Preview Campaign"),
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

                title: "Campaign Overview",

                children: [
                  _row("Name", controller.campaignNameController.text),

                  _row("About", controller.requirementsController.text),

                  _row("Objective", controller.selectedObjective.value),

                  _row("Content Type", controller.selectedContentType.value),

                  _row("Offer", controller.selectedOfferName),

                  _row(
                    "Duration",
                    "${controller.startDateController.text} - ${controller.endDateController.text}",
                  ),

                  _row("Video Length", "${controller.selectedVideoLength}s"),
                ],
              ),

              Gap(12.h),

              _card(
                context,

                title: "Influencer Info",

                children: [
                  _row("Influencer Category", controller.selectedCategoryName),

                  _row("Target Creator", "$creatorCount Creators"),

                  _row("Selected Package", controller.selectedPackageName),

                  _row("Package Price", controller.selectedPackagePrice),

                  Divider(),

                  _row(
                    "Total Campaign Cost",

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

                title: "Content Requirements",

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

                      text: "Back to Edit",
                    ),
                  ),

                  Gap(12.w),

                  Expanded(
                    child: CustomButton(
                      isLoading:
                          controller.submitLoading.value == ApiStatus.loading,
                      onTap: controller.onSubmit,

                      text: "Submit",
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
