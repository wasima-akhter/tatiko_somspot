import 'package:som_spot/features/customer/customer_business_details/widgets/merchant_details/merchant_header_backdrop.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../widgets/merchant_details/customer_business_details_content.dart';
import '../widgets/merchant_details/customer_business_details_floating_actions.dart';
import '../widgets/merchant_details/merchant_sticky_footer.dart';

class CustomerBusinessDetailsScreen extends StatelessWidget {
  const CustomerBusinessDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,

      bottomNavigationBar: Container(
        // padding: EdgeInsets.only(bottom: bottomPadding(context) + 10),
        child: MerchantStickyFooter(),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MerchantHeaderBackdrop(),
                  Gap(16.h),
                  Expanded(child: const MerchantDetailsContent()),
                ],
              ),
            ),
          ),

          const MerchantDetailsFloatingActions(),

          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: MerchantStickyFooter(),
          // ),
        ],
      ),
    );
  }
}
