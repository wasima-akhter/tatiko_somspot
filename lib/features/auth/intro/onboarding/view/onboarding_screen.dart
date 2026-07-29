import 'package:som_spot/core/service/datasource/local/app_storage.dart';
import 'package:som_spot/features/auth/intro/onboarding/widgets/onboarding_page_card.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../../../../utils/common_controller/common_controller.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final _controller = Get.find<OnboardingController>();

  Future<void> _completeOnboarding() async {
    await AppStorage.to.setSeenOnboarding(true);

    AppRouter.route.goNamed(RoutePath.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorNew,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      _controller.onboardingList.length,
                      (index) => buildDot(index, context),
                    ),
                  ),

                  GestureDetector(
                    onTap: _completeOnboarding,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor.withValues(alpha: 0.5),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        AppStrings.skip.tr,
                        style: context.labelMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller.pageController,
                itemCount: _controller.onboardingList.length,

                onPageChanged: (index) {
                  _controller.currentIndex.value = index;
                },

                itemBuilder: (context, index) {
                  return OnboardingPageCard(
                    model: _controller.onboardingList[index],
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: Obx(() {
                final isLast =
                    _controller.currentIndex.value ==
                    _controller.onboardingList.length - 1;

                return CustomButton(
                  text: isLast
                      ? (CommonController.to.isInfluencer
                            ? AppStrings.startEarning.tr
                            : AppStrings.getStarted.tr)
                      : AppStrings.next.tr,

                  onTap: () async {
                    if (isLast) {
                      await _completeOnboarding();
                    } else {
                      _controller.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Obx(() {
        final isActive = _controller.currentIndex.value == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),

          height: 8,

          width: isActive ? 24 : 8,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            color: isActive
                ? AppColors.primaryColor
                : AppColors.primaryColor.withValues(alpha: 0.2),
          ),
        );
      }),
    );
  }
}
