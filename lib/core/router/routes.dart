import 'package:som_spot/features/alerts/view/alerts_screen.dart';
import 'package:som_spot/features/auth/active/active_otp_screen.dart';
import 'package:som_spot/features/auth/complete_business_profile/view/application_submitted_screen.dart';
import 'package:som_spot/features/auth/complete_business_profile/view/application_under_review_screen.dart';
import 'package:som_spot/features/auth/complete_business_profile/view/complete_business_profile_screen.dart';
import 'package:som_spot/features/auth/completed_profile_influencer/view/influencer_info_complete_screen.dart';
import 'package:som_spot/features/auth/forget/forget_password_screen.dart';
import 'package:som_spot/features/auth/forget_otp/forgetotp_screen.dart';
import 'package:som_spot/features/auth/intro/choose_language/view/choose_language_screen.dart';
import 'package:som_spot/features/auth/intro/onboarding/view/onboarding_screen.dart';
import 'package:som_spot/features/auth/intro/splash/splash_screen.dart';
import 'package:som_spot/features/auth/intro/wellcome/view/welcome_screen.dart';
import 'package:som_spot/features/auth/login/login_screen.dart';
import 'package:som_spot/features/auth/reset/reset_password_screen.dart';
import 'package:som_spot/features/auth/sign_up/sign_up_screen.dart';
import 'package:som_spot/features/business_info/view/business_info_screen.dart';
import 'package:som_spot/features/core/category/category_binding.dart';
import 'package:som_spot/features/core/category/view/category_list_screen.dart';
import 'package:som_spot/features/customer/claims/view/claims_screen.dart';
import 'package:som_spot/features/customer/customer_business_list/binding/customer_business_list_binding.dart';
import 'package:som_spot/features/customer/customer_business_list/view/customer_business_list_screen.dart';
import 'package:som_spot/features/customer/customer_home/view/top_deals_screen.dart';
import 'package:som_spot/features/influencer_all/influencer_dashboard/view/influencer_dashboard_screen.dart';
import 'package:som_spot/features/influencer_all/influencer_discover/view/influencer_discover_screen.dart';
import 'package:som_spot/features/influencer_all/influencer_task_screen/view/influencer_task_screen.dart';
import 'package:som_spot/features/merchant/edit_offer/view/edit_offer_screen.dart';
import 'package:som_spot/features/merchant/merchant_campaign_details/view/merchant_campaign_details_screen.dart';
import 'package:som_spot/features/merchant/merchant_campaigns/view/merchant_campaigns_screen.dart';
import 'package:som_spot/features/merchant/merchant_new_campaign/view/merchant_new_campaign_screen.dart';
import 'package:som_spot/features/merchant/merchant_new_campaign/view/preview_campaign_screen.dart';
import 'package:som_spot/features/nav/navigation_page.dart';
import 'package:som_spot/features/offers/offer_details/view/offer_details_screen.dart';
import 'package:som_spot/features/offers/shared/binding/create_offer_binding.dart';
import 'package:som_spot/features/offers/shared/response/offers_response.dart';
import 'package:som_spot/features/other/view/about_somsport_screen.dart';
import 'package:som_spot/features/other/view/change_password_screen.dart';
import 'package:som_spot/features/other/view/help_and_support_screen.dart';
import 'package:som_spot/features/other/view/privacy_policy_screen.dart';
import 'package:som_spot/features/other/view/terms_and_conditions_screen.dart';
import 'package:som_spot/features/profile/edit_profile/view/edit_influencer_profile_screen.dart';
// Feature screens imports
import 'package:som_spot/features/profile/edit_profile/view/edit_profile_screen.dart';
import 'package:som_spot/features/profile/main_profile/view/profile_screen.dart';
import 'package:som_spot/features/subscription/subscription_screen.dart';
import 'package:som_spot/share/controller/screen_export.dart';

import '../../features/auth/complete_business_profile/binding/complete_business_profile_binding.dart'
    show CompleteBusinessProfileBinding;
import '../../features/auth/completed_profile_customer_merchandiser/binding/complete_profile_binding.dart';
import '../../features/auth/completed_profile_customer_merchandiser/view/completed_profile_customer_args.dart';
import '../../features/auth/completed_profile_customer_merchandiser/view/completed_profile_customer_screen.dart';
import '../../features/auth/completed_profile_influencer/binding/influencer_complete_profile_binding.dart';
import '../../features/auth/completed_profile_influencer/view/completed_profile_influencer_screen.dart';
import '../../features/auth/core/binding/auth_binding.dart';
import '../../features/auth/intro/choose_role/view/choose_role_screen.dart';
import '../../features/auth/intro/onboarding/binding/onboard_binding.dart';
import '../../features/customer/customer_business_details/shared/binding/customer_business_details_binding.dart';
import '../../features/customer/customer_business_details/view/customer_business_details_screen.dart';
import '../../features/customer/customer_business_list/arg/customer_business_list_arg_model.dart';
import '../../features/customer/customer_home/binding/home_binding.dart';
import '../../features/customer/customer_offer_claim/controller/customer_offer_claim_controller.dart';
import '../../features/customer/customer_offer_claim/helper/customer_offer_claim_helper.dart';
import '../../features/customer/customer_offer_claim/view/customer_offer_claim_screen.dart';
import '../../features/influencer_all/binding/influencer_binding.dart';
import '../../features/influencer_all/core/influencer_tasks/response/influencer_tasks_response.dart';
import '../../features/influencer_all/influencer_apply_campaign/view/influencer_apply_campaign_screen.dart';
import '../../features/influencer_all/influencer_campaign_details/view/influencer_campaign_details_screen.dart';
import '../../features/influencer_all/influencer_my_campaigns/view/influencer_my_campaigns_screen.dart';
import '../../features/influencer_all/influencer_publish_proof/binding/influencer_publush_proof_binding.dart';
import '../../features/influencer_all/influencer_publish_proof/view/influencer_publish_proof_screen.dart';
import '../../features/influencer_all/influencer_search/view/influencer_search_screen.dart';
import '../../features/influencer_all/influencer_submit_content/args/submit_content_args.dart';
import '../../features/influencer_all/influencer_submit_content/view/influencer_submit_content_screen.dart';
import '../../features/influencer_all/influencer_wallet/view/influencer_wallet_screen.dart';
import '../../features/influencer_all/influencer_your_submission/args/influencer_submission_args.dart';
import '../../features/influencer_all/influencer_your_submission/view/influencer_your_submission_screen.dart';
import '../../features/merchant/create_offer/view/create_offer_screen.dart';
import '../../features/merchant/merchant_campaign_details/view/merchant_campaign_content_details_screen.dart';
import '../../features/merchant/merchant_new_campaign/shared/binding/merchant_new_campaign_binding.dart';
import '../../features/merchant/merchant_new_campaign/view/pricing_packages_screen.dart';
import '../../features/nav/binding/navigation_binding.dart';
import '../../features/offers/offer_details/helper/offer_details_arg_model.dart';
import '../../features/offers/shared/binding/edit_offer_binding.dart';
import '../../features/offers/shared/binding/offer_details_binding.dart';
import '../../features/other/controller/other_binding.dart';
import '../../features/profile/binding/profile_binding.dart';
import '../../features/subscription/binding/subscription_binding.dart';
import '../../features/success/success_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.splashScreen.addBasePath,

    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      // =====================================================
      // INITIAL ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.splashScreen,
        path: RoutePath.splashScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const SplashScreen(),
            state: state,
          );
        },
      ),

      // =====================================================
      // ONBOARDING ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.chooseLanguageScreen,
        path: RoutePath.chooseLanguageScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: ChooseLanguageScreen(),
          );
        },
      ),

      GoRoute(
        name: RoutePath.chooseRoleScreen,
        path: RoutePath.chooseRoleScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: OnboardingBinding(),
              child: ChooseRoleScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.onboardingScreen,
        path: RoutePath.onboardingScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: OnboardingBinding(),
              child: OnboardingScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.welcomeScreen,
        path: RoutePath.welcomeScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: const WelcomeScreen(),
          );
        },
      ),

      // =====================================================
      // AUTHENTICATION ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.loginScreen,
        path: RoutePath.loginScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: AuthBinding(),
              child: const LoginScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.signUpScreen,
        path: RoutePath.signUpScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: AuthBinding(),
              child: const SignUpScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.forgetPasswordScreen,
        path: RoutePath.forgetPasswordScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: AuthBinding(),
              child: const ForgetPasswordScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.resetPasswordScreen,
        path: RoutePath.resetPasswordScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: AuthBinding(),
              child: ResetPasswordScreen(email: state.extra as String?),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.activeOtpScreen,
        path: RoutePath.activeOtpScreen.addBasePath,
        pageBuilder: (context, state) {
          final email = state.extra as String?;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: AuthBinding(),
              child: ActiveOtpScreen(email: email),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.forgetOtpScreen,
        path: RoutePath.forgetOtpScreen.addBasePath,
        pageBuilder: (context, state) {
          final email = state.extra as String?;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: AuthBinding(),
              child: ForgetOtpScreen(email: email),
            ),
          );
        },
      ),

      // =====================================================
      // MAIN NAVIGATION
      // =====================================================
      GoRoute(
        name: RoutePath.navigationPages,
        path: RoutePath.navigationPages.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: NavigationBinding(),
              child: const NavigationPage(),
            ),
            state: state,
          );
        },
      ),
      // =====================================================
      // PROFILE ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.profileScreen,
        path: RoutePath.profileScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: NavigationBinding(),
              child: const ProfileScreen(),
            ),
            state: state,
          );
        },
      ),
      ////
      GoRoute(
        name: RoutePath.editProfileScreen,
        path: RoutePath.editProfileScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: ProfileBinding(),
              child: const EditProfileScreen(),
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.editInfluencerScreen,
        path: RoutePath.editInfluencerScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: EditInfluencerBinding(),
              child: const EditInfluencerScreen(),
            ),
            state: state,
          );
        },
      ),

      ////
      GoRoute(
        name: RoutePath.completeBusinessProfileScreen,
        path: RoutePath.completeBusinessProfileScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: CompleteBusinessProfileBinding(),
              child: const CompleteBusinessProfileScreen(),
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.completedProfileCustomerScreen,
        path: RoutePath.completedProfileCustomerScreen.addBasePath,
        pageBuilder: (context, state) {
          final args = state.extra as CompletedProfileCustomerArgs;

          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: CompleteProfileBinding(),
              child: CompletedProfileCustomerScreen(args: args),
            ),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.completedProfileInfluencerScreen,
        path: RoutePath.completedProfileInfluencerScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: InfluencerCompleteProfileBinding(),
              child: const CompletedProfileInfluencerScreen(),
            ),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.influencerInfoComplete,
        path: RoutePath.influencerInfoComplete.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: InfluencerCompleteProfileBinding(),
              child: const InfluencerInfoCompleteScreen(),
            ),
            state: state,
          );
        },
      ),

      // =====================================================
      // APPLICATION STATUS ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.applicationSubmittedScreen,
        path: RoutePath.applicationSubmittedScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const ApplicationSubmittedScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.applicationUnderReviewScreen,
        path: RoutePath.applicationUnderReviewScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const ApplicationUnderReviewScreen(),
            state: state,
          );
        },
      ),

      // =====================================================
      // STATIC INFORMATION ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.claimsScreen,
        path: RoutePath.claimsScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const ClaimsScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.helpAndSupportScreen,
        path: RoutePath.helpAndSupportScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: HelpAndSupportScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.aboutSomSpotScreen,
        path: RoutePath.aboutSomSpotScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: OtherBinding(),
              child: const AboutSomSpotScreen(),
            ),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.privacyPolicyScreen,
        path: RoutePath.privacyPolicyScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: OtherBinding(),
              child: const PrivacyPolicyScreen(),
            ),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.termsAndConditionsScreen,
        path: RoutePath.termsAndConditionsScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: OtherBinding(),
              child: const TermsAndConditionsScreen(),
            ),
            state: state,
          );
        },
      ),

      // =====================================================
      // ACCOUNT SETTINGS ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.subscriptionScreen,
        path: RoutePath.subscriptionScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: SubscriptionBinding(),
              child: const SubscriptionScreen(),
            ),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.changePasswordScreen,
        path: RoutePath.changePasswordScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: AuthBinding(),
              child: const ChangePasswordScreen(),
            ),
            state: state,
          );
        },
      ),

      // =====================================================
      // CUSTOMER  ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.categoryListScreen,
        path: RoutePath.categoryListScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: CategoryBinding(),
              child: const CategoryListScreen(),
            ),
          );
        },
      ),

      //
      GoRoute(
        name: RoutePath.customerBusinessDetailsScreen,
        path: RoutePath.customerBusinessDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          final businessId = state.extra as String;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: CustomerBusinessDetailsBinding(businessId: businessId),
              child: const CustomerBusinessDetailsScreen(),
            ),
          );
        },
      ),

      //
      GoRoute(
        name: RoutePath.topDealsScreen,
        path: RoutePath.topDealsScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: HomeBinding(),
              child: const TopDealsScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.customerBusinessListScreen,
        path: RoutePath.customerBusinessListScreen.addBasePath,
        pageBuilder: (context, state) {
          final categoryInfo = (state.extra as CustomerBusinessListArgModel?);

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: CustomerBusinessListBinding(categoryInfo: categoryInfo),
              child: CustomerBusinessListScreen(),
            ),
          );
        },
      ),

      // =====================================================
      // MERCHANT ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.merchantCampaignsScreen,
        path: RoutePath.merchantCampaignsScreen.addBasePath,
        pageBuilder: (context, state) {
          // final merchant = state.extra as MerchantModel;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: MerchantCampaignsBinding(),
              child: MerchantCampaignScreen(),
            ),
          );
        },
      ),
      GoRoute(
        name: RoutePath.merchantCampaignDetailsScreen,
        path: RoutePath.merchantCampaignDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          final campaignId = state.extra as String;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: MerchantCampaignDetailsBinding(campaignId: campaignId),
              child: const MerchantCampaignDetailsScreen(),
            ),
          );
        },
      ),
      GoRoute(
        name: RoutePath.merchantCampaignContentDetailsScreen,
        path: RoutePath.merchantCampaignContentDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          // final merchant = state.extra as MerchantModel;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: MerchantCampaignContentDetailsBinding(),
              child: MerchantCampaignContentDetailsScreen(
                contentId: state.extra as String,
              ),
            ),
          );
        },
      ),
      GoRoute(
        name: RoutePath.merchantNewCampaignScreen,
        path: RoutePath.merchantNewCampaignScreen.addBasePath,
        pageBuilder: (context, state) {
          // final merchant = state.extra as MerchantModel;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: MerchantNewCampaignBinding(),
              child: MerchantNewCampaignScreen(),
            ),
          );
        },
      ),
      GoRoute(
        name: RoutePath.merchantPricingPackagesScreen,
        path: RoutePath.merchantPricingPackagesScreen.addBasePath,
        pageBuilder: (context, state) {
          // final merchant = state.extra as MerchantModel;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: MerchantPricingBinding(),
              child: MerchantPricingPackagesScreen(),
            ),
          );
        },
      ),
      GoRoute(
        name: RoutePath.mrchantPreviewCampaignScreen,
        path: RoutePath.mrchantPreviewCampaignScreen.addBasePath,
        pageBuilder: (context, state) {
          // final merchant = state.extra as MerchantModel;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: MerchantPricingBinding(),
              child: MerchantPreviewCampaignScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.offerDetailsScreen,
        path: RoutePath.offerDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          final args = state.extra;

          if (args is! OfferDetailsArgs) {
            return _buildPageWithAnimation(
              state: state,
              child: const SizedBox.shrink(),
            );
          }

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              key: ValueKey('${args.offerId}_${args.isFromClaim}'),
              binding: OfferDetailsBinding(args),
              child: const OfferDetailsScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.offerClaimScreen,
        path: RoutePath.offerClaimScreen.addBasePath,
        pageBuilder: (context, state) {
          final args = state.extra as OfferClaimArgs;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              key: ValueKey(args.claimCode),
              binding: BindingsBuilder(() {
                Get.put(OfferClaimController(claimCode: args.claimCode));
              }),
              child: const OfferClaimScreen(),
            ),
          );
        },
      ),
      // GoRoute(
      //   name: RoutePath.claimedOfferDetailsScreen,
      //   path: RoutePath.claimedOfferDetailsScreen.addBasePath,
      //   pageBuilder: (context, state) {
      //     final deal = state.extra as DealModel;

      //     return _buildPageWithAnimation(
      //       state: state,
      //       child: BindingWrapper(
      //         binding: HomeBinding(),
      //         child: ClaimedOfferDetailsScreen(deal: deal),
      //       ),
      //     );
      //   },
      // ),

      // =====================================================
      // BUSINESS ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.createOfferScreen,
        path: RoutePath.createOfferScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: CreateOfferBinding(),
              child: const CreateOfferScreen(),
            ),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.editOfferScreen,
        path: RoutePath.editOfferScreen.addBasePath,
        pageBuilder: (context, state) {
          final deal = state.extra as OfferModel;

          return _buildPageWithAnimation(
            child: BindingWrapper(
              binding: EditOfferBinding(),
              child: EditOfferScreen(offer: deal),
            ),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.businessInfoScreen,
        path: RoutePath.businessInfoScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const BusinessInfoScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.alertScreen,
        path: RoutePath.alertScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const AlertsScreen(),
            state: state,
          );
        },
      ),

      //customer

      // =====================================================
      // INFLUENCER ROUTES
      // =====================================================

      // Dashboard
      GoRoute(
        name: RoutePath.influencerDashboardScreen,
        path: RoutePath.influencerDashboardScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: NavigationBinding(),
              child: const InfluencerDashboardScreen(),
            ),
          );
        },
      ),

      // Discovery
      GoRoute(
        name: RoutePath.influencerDiscoverScreen,
        path: RoutePath.influencerDiscoverScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: NavigationBinding(),
              child: const InfluencerDiscoverScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.influencerSearchScreen,
        path: RoutePath.influencerSearchScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: InfluencerBinding(),
              child: const InfluencerSearchScreen(),
            ),
          );
        },
      ),

      // Tasks & Wallet
      GoRoute(
        name: RoutePath.influencerTaskScreen,
        path: RoutePath.influencerTaskScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: NavigationBinding(),
              child: const InfluencerTaskScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.influencerWalletScreen,
        path: RoutePath.influencerWalletScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: NavigationBinding(),
              child: const InfluencerWalletScreen(),
            ),
          );
        },
      ),

      // Campaign Management
      GoRoute(
        name: RoutePath.influencerCampaignDetailsScreen,
        path: RoutePath.influencerCampaignDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: InfluencerBinding(),
              child: const InfluencerCampaignDetailsScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.influencerApplyCampaignScreen,
        path: RoutePath.influencerApplyCampaignScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: InfluencerBinding(),
              child: const ApplyCampaignScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.influencerMyCampaigns,
        path: RoutePath.influencerMyCampaigns.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: InfluencerBinding(),
              child: InfluencerMyCampaignsScreen(),
            ),
          );
        },
      ), // =====================================================
      // INFLUENCER CONTENT SUBMISSION ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.influencerSubmitContentScreen,
        path: RoutePath.influencerSubmitContentScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: InfluencerBinding(),
              child: InfluencerSubmitContentScreen(
                args: state.extra as SubmitContentArgs,
              ),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.influencerYourSubmissionScreen,
        path: RoutePath.influencerYourSubmissionScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: InfluencerBinding(),
              child: InfluencerYourSubmissionScreen(
                influencerSubmissionArgs:
                    state.extra as InfluencerSubmissionArgs,
              ),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.influencerPublishProofScreen,
        path: RoutePath.influencerPublishProofScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: InfluencerPublushProofBinding(),
              child: InfluencerPublishProofScreen(
                task: state.extra as InfluencerTaskModel,
              ),
            ),
          );
        },
      ),

      // =====================================================
      // COMMON SUCCESS ROUTE
      // =====================================================
      GoRoute(
        name: RoutePath.successScreen,
        path: RoutePath.successScreen.addBasePath,
        pageBuilder: (context, state) {
          final args = state.extra as SuccessScreenArgs;

          return _buildPageWithAnimation(
            state: state,
            child: SuccessScreen(
              title: args.title,
              subtitle: args.subtitle,
              buttonText: args.buttonText,
              onButtonTap: args.onButtonTap,
              autoNavigateAfter: args.autoNavigateAfter,
              onAutoNavigate: args.onAutoNavigate,
            ),
          );
        },
      ),

      /*
      GoRoute(
        name: RoutePath.contactAndSupportScreen,
        path: RoutePath.contactAndSupportScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const ContactAndSupportScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.navigationPages,
        path: RoutePath.navigationPages.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const NavigationPage(),
            state: state,
          );
        },
      ),

      //=================Profile ===================
      GoRoute(
        name: RoutePath.editProfileScreen,
        path: RoutePath.editProfileScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: EditProfileScreen(),
            state: state,
          );
        },
      ),

      //=============Setting==========
      GoRoute(
        name: RoutePath.settingScreen,
        path: RoutePath.settingScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const SettingScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.healthTrackingScreen,
        path: RoutePath.healthTrackingScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const HealthTrackingScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.bookingsScreen,
        path: RoutePath.bookingsScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(child: BookingsScreen(), state: state);
        },
      ),

      GoRoute(
        name: RoutePath.chooseGenderScreen,
        path: RoutePath.chooseGenderScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const ChooseGenderScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.chooseHeightWeightScreen,
        path: RoutePath.chooseHeightWeightScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const ChooseHeightWeightScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.dateOfBirthScreen,
        path: RoutePath.dateOfBirthScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const DateOfBirthScreen(),
            state: state,
          );
        },
      ),
      GoRoute(
        name: RoutePath.thankYouScreen,
        path: RoutePath.thankYouScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const ThankYouScreen(),
            state: state,
          );
        },
      ),

      */
      /*GoRoute(
        name: RoutePath.categoryEventsScreen,
        path: RoutePath.categoryEventsScreen.addBasePath,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final map = (extra is Map<String, dynamic>) ? extra : {};

          final id = map['id'] as String? ?? '';
          final title = map['title'] as String? ?? '';

          return _buildPageWithAnimation(
            child: CategoryEventsScreen(id: id, title: title),
            state: state,
          );
        },
      ),*/
    ],
  );

  static CustomTransitionPage _buildPageWithAnimation({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static GoRouter get route => initRoute;
}

// class BindingWrapper extends StatelessWidget {
//   final Bindings binding;
//   final Widget child;

//   const BindingWrapper({super.key, required this.binding, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     binding.dependencies();
//     return child;
//   }
// }
class BindingWrapper extends StatefulWidget {
  final Bindings binding;
  final Widget child;

  const BindingWrapper({super.key, required this.binding, required this.child});

  @override
  State<BindingWrapper> createState() => _BindingWrapperState();
}

class _BindingWrapperState extends State<BindingWrapper> {
  @override
  void initState() {
    super.initState();

    debugPrint("BindingWrapper init");
    widget.binding.dependencies();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BindingWrapper build");
    return widget.child;
  }
}

/*
1. Initial Routes
   └── Splash

2. Onboarding Routes
   ├── Choose Language
   ├── Choose Role
   ├── Onboarding
   └── Welcome

3. Authentication Routes
   ├── Login
   ├── Signup
   ├── Forgot Password
   ├── Reset Password
   ├── Active OTP
   └── Forgot OTP

4. Main Navigation
   └── Navigation Page

5. Profile Routes
   ├── Edit Profile
   ├── Completed Profile
   └── Completed Influencer Profile

6. Application Status
   ├── Submitted
   └── Under Review

7. Static Information
   ├── Claims
   ├── Help & Support
   ├── About
   ├── Privacy Policy
   └── Terms & Conditions

8. Account Settings
   ├── Subscription
   └── Change Password

9. Customer/Home Routes
   ├── Top Deals
   ├── Nearby
   ├── Category Merchants
   ├── Merchant Details
   ├── Offer Details
   └── Claimed Offer Details

10. Business Routes
   ├── Create Offer
   ├── Edit Offer
   ├── Business Info
   └── Alerts

11. Influencer Routes
   ├── Dashboard
   ├── Discover
   ├── Search
   ├── Tasks
   ├── Wallet
   ├── Campaign Details
   ├── Apply Campaign
   ├── My Campaigns
   ├── Submit Content
   ├── Your Submission
   └── Publish Proof

12. Common
   └── Success



*/
