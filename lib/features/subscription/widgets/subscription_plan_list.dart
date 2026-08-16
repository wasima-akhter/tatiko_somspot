import '../../../share/export/screen_export.dart';
import '../controller/subscription_controller.dart';
import 'subscription_plan_card.dart';

class SubscriptionPlanList extends StatelessWidget {
  const SubscriptionPlanList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SubscriptionController.to;

    return Obx(() {
      return Column(
        children: List.generate(controller.currentPlans.length, (index) {
          final plan = controller.currentPlans[index];

          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: SubscriptionPlanCard(
              plan: plan,
              isSelected: controller.selectedPlanIndex.value == index,
              isInfluencer: controller.isInfluencerTab,
              onTap: () => controller.selectPlan(index),
            ),
          );
        }),
      );
    });
  }
}
