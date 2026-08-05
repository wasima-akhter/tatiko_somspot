import 'package:som_spot/features/influencer_all/influencer_wallet/helper/influencer_wallet_helper.dart';

import '../../../../share/controller/screen_export.dart';
import '../controller/influencer_wallet_controller.dart';

class WalletFilterTabs extends StatelessWidget {
  const WalletFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = InfluencerWalletController.to;

    return Obx(() {
      final selectedIndex = controller.periods.indexOf(
        controller.selectedPeriod.value,
      );

      return Container(
        height: 42.h,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,

              alignment: Alignment(
                -1 + (selectedIndex * (2 / (controller.periods.length - 1))),
                0,
              ),

              child: FractionallySizedBox(
                widthFactor: 1 / controller.periods.length,

                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Row(
              children: controller.periods.map((period) {
                final isSelected = controller.selectedPeriod.value == period;

                return Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,

                    onTap: () {
                      controller.changePeriod(period);
                    },

                    child: Center(
                      child: Text(
                        period.displayName,

                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,

                          color: isSelected
                              ? const Color(0xff4EA9FF)
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }
}
