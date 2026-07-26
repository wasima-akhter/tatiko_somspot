import '../../../../share/controller/screen_export.dart';
import '../controller/merchant_pricing_controller.dart';

class MerchantPricingPackagesScreen extends StatelessWidget {
  const MerchantPricingPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MerchantPricingController.to;
    return ScaffoldWrapper(
      title: "Pricing Packages",

      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),

              itemCount: controller.packages.length,

              separatorBuilder: (_, _) => Gap(12.h),

              itemBuilder: (context, index) {
                final item = controller.packages[index];

                return Container(
                  padding: EdgeInsets.all(12.w),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(10.r),

                    border: Border.all(color: const Color(0xffDCE8F5)),
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              item.title,
                              style: context.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Gap(4.h),

                            Text(
                              item.subtitle,
                              style: context.bodySmall.copyWith(
                                color: Colors.grey,
                              ),
                            ),

                            Gap(4.h),

                            Text(item.description, style: context.bodySmall),
                          ],
                        ),
                      ),

                      Text(
                        item.price,
                        style: context.titleMedium.copyWith(
                          color: const Color(0xff2699FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),

            child: CustomButton(
              onTap: () {
                AppRouter.route.pushNamed(
                  RoutePath.mrchantPreviewCampaignScreen,
                );
              },

              text: "Preview",
            ),
          ),
        ],
      ),
    );
  }
}
