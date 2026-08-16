import '../../../share/export/screen_export.dart';
import '../widgets/help_support_faq_section.dart';
import '../widgets/help_support_form_card.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      backgroundColor: AppColors.softBackgroundColor,

      appBar: AppBar(
        backgroundColor: AppColors.softBackgroundColor,
        elevation: 0,

        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, size: 18.sp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        title: Text(
          AppStrings.helpSupport.tr,
          style: context.titleMedium.copyWith(fontWeight: FontWeight.w600),
        ),

        centerTitle: false,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
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
    );
  }
}
