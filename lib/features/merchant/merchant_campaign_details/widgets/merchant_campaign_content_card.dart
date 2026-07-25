import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/share/widgets/button/custom_button.dart';
import 'package:som_spot/share/widgets/network_image/custom_network_image.dart';

import '../../../../share/controller/screen_export.dart';

class MerchantCampaignContentCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const MerchantCampaignContentCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRouter.route.pushNamed(
        RoutePath.merchantCampaignContentDetailsScreen,
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.6,
              child: CustomNetworkImage(
                imageUrl: data["image"],
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.r,

                        child: CustomNetworkImage(
                          boxShape: BoxShape.circle,
                          imageUrl: data["image"],
                        ),
                      ),

                      Gap(6.w),

                      Text(
                        data["creator"],
                        style: context.bodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        " • ${data["time"]}",
                        style: context.bodySmall.copyWith(
                          color: AppColors.subtitleTextColor,
                        ),
                      ),
                    ],
                  ),

                  Gap(8.h),

                  Text(data["caption"], style: context.bodyMedium),

                  Gap(14.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: "Reject",
                          isOutlined: true,
                          outlineColor: Colors.red,
                          foregroundColor: Colors.red,
                          onTap: () {},
                        ),
                      ),

                      Gap(12.w),

                      Expanded(
                        child: CustomButton(onTap: () {}, text: "Approve"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
