import '../../../share/export/screen_export.dart';
import '../../../share/widgets/refresh_indicator/refresh_indicator.dart';
import '../controller/other_controller.dart';
import '../widgets/help_support_faq_section.dart';
import '../widgets/help_support_form_card.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      title: AppStrings.helpSupport.tr,

      body: SafeArea(
        child: CustomRefreshIndicator(
          onRefresh: OtherController.to.refreshFaq,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),

            controller: OtherController.to.faqScrollController,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HelpSupportFormCard(),

                Gap(28.h),

                const HelpSupportFaqSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
