import '../../../../share/controller/screen_export.dart';

class MerchantPreviewCampaignScreen extends StatelessWidget {
  const MerchantPreviewCampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),

        child: Column(
          children: [
            Gap(10.h),

            _card(
              context,

              title: "Campaign Overview",

              children: [
                _row("Name", "Sunset Coffee Promotion"),

                _row("Objective", "Brand Awareness"),

                _row("Content Type", "Reel"),

                _row("Duration", "15 Jul-22 Jul, 2026"),
              ],
            ),

            Gap(12.h),

            _card(
              context,

              title: "Creators & Requirement",

              children: [
                _row("Influencer Category", "Lifestyle"),

                _row("Target Creator", "5 Creators"),

                _row("Selected Package", "\$7"),

                Divider(),

                _row("Total Campaign Cost", "\$35", bold: true),
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
                    onTap: () {
                      AppRouter.route.goNamed(
                        RoutePath.merchantNewCampaignScreen,
                      );
                    },
                    text: "Submit",
                  ),
                ),
              ],
            ),

            Gap(20.h),
          ],
        ),
      ),
    );
  }

  Widget _card(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.all(12.w),

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

        children: [
          Text(label),

          Text(
            value,

            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
