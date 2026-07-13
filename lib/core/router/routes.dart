import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/features/alerts/view/alerts_screen.dart';
import 'package:som_spot/features/auth/active/active_otp_screen.dart';
import 'package:som_spot/features/auth/completed_profile/view/application_submitted_screen.dart';
import 'package:som_spot/features/auth/completed_profile/view/application_under_review_screen.dart';
import 'package:som_spot/features/auth/completed_profile/view/completed_profile_screen.dart';
import 'package:som_spot/features/auth/forget/forget_password_screen.dart';
import 'package:som_spot/features/auth/forget_otp/forgetotp_screen.dart';
import 'package:som_spot/features/auth/login/login_screen.dart';
import 'package:som_spot/features/auth/reset/reset_password_screen.dart';
import 'package:som_spot/features/auth/sign_up/sign_up_screen.dart';
import 'package:som_spot/features/business_info/view/business_info_screen.dart';
import 'package:som_spot/features/choose_language/view/choose_language_screen.dart';
import 'package:som_spot/features/claims/view/claims_screen.dart';
import 'package:som_spot/features/dashboard/view/create_offer_screen.dart';
import 'package:som_spot/features/home/model/deal_model.dart';
import 'package:som_spot/features/home/model/merchant_model.dart';
import 'package:som_spot/features/home/view/category_merchants_screen.dart';
import 'package:som_spot/features/home/view/merchant_details_screen.dart';
import 'package:som_spot/features/home/view/nearby_you_screen.dart';
import 'package:som_spot/features/home/view/offer_details_screen.dart';
import 'package:som_spot/features/home/view/top_deals_screen.dart';
import 'package:som_spot/features/influencer_all/influencer_dashboard/view/influencer_dashboard_screen.dart';
import 'package:som_spot/features/influencer_all/influencer_discover/view/influencer_discover_screen.dart';
import 'package:som_spot/features/influencer_all/influencer_task_screen/view/influencer_task_screen.dart';
import 'package:som_spot/features/nav/navigation_page.dart';
import 'package:som_spot/features/offers/view/edit_offer_screen.dart';
import 'package:som_spot/features/offers/view/offer_details_screen.dart';
import 'package:som_spot/features/onboarding/view/onboarding_screen.dart';
import 'package:som_spot/features/other/view/about_somsport_screen.dart';
import 'package:som_spot/features/other/view/change_password_screen.dart';
import 'package:som_spot/features/other/view/help_and_support_screen.dart';
import 'package:som_spot/features/other/view/privacy_policy_screen.dart';
import 'package:som_spot/features/other/view/terms_and_conditions_screen.dart';
// Feature screens imports
import 'package:som_spot/features/profile/edit_profile/view/edit_profile_screen.dart';
import 'package:som_spot/features/splash/splash_screen.dart';
import 'package:som_spot/features/subscription/subscription_screen.dart';
import 'package:som_spot/features/wellcome/view/welcome_screen.dart';
import 'package:som_spot/utils/extension/base_extension.dart';

import '../../features/auth/binding/auth_binding.dart';
import '../../features/auth/completed_profile_influencer/view/completed_profile_influencer_screen.dart';
import '../../features/choose_role/view/choose_role_screen.dart';
import '../../features/home/binding/home_binding.dart';
import '../../features/influencer_all/binding/influencer_binding.dart';
import '../../features/influencer_all/influencer_apply_campaign/view/influencer_apply_campaign_screen.dart';
import '../../features/influencer_all/influencer_campaign_details/view/influencer_campaign_details_screen.dart';
import '../../features/influencer_all/influencer_my_campaigns/view/influencer_my_campaigns_screen.dart';
import '../../features/influencer_all/influencer_publish_proof/view/influencer_publish_proof_screen.dart';
import '../../features/influencer_all/influencer_search/view/influencer_search_screen.dart';
import '../../features/influencer_all/influencer_submit_content/view/influencer_submit_content_screen.dart';
import '../../features/influencer_all/influencer_wallet/view/influencer_wallet_screen.dart';
import '../../features/influencer_all/influencer_your_submission/view/influencer_your_submission_screen.dart';
import '../../features/onboarding/binding/onboard_binding.dart';
import '../../features/profile/binding/profile_binding.dart';
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
              child: const ResetPasswordScreen(),
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
              binding: HomeBinding(),
              child: const NavigationPage(),
            ),
            state: state,
          );
        },
      ), // =====================================================
      // PROFILE ROUTES
      // =====================================================
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
        name: RoutePath.completedProfileScreen,
        path: RoutePath.completedProfileScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const CompletedProfileScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.completedProfileInfluencerScreen,
        path: RoutePath.completedProfileInfluencerScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const CompletedProfileInfluencerScreen(),
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
            child: const HelpAndSupportScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.aboutSomSpotScreen,
        path: RoutePath.aboutSomSpotScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const AboutSomSpotScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.privacyPolicyScreen,
        path: RoutePath.privacyPolicyScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const PrivacyPolicyScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.termsAndConditionsScreen,
        path: RoutePath.termsAndConditionsScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const TermsAndConditionsScreen(),
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
            child: const SubscriptionScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.changePasswordScreen,
        path: RoutePath.changePasswordScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const ChangePasswordScreen(),
            state: state,
          );
        },
      ),

      // =====================================================
      // CUSTOMER DEALS & DISCOVERY ROUTES
      // =====================================================
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
        name: RoutePath.nearbyYouScreen,
        path: RoutePath.nearbyYouScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: HomeBinding(),
              child: const NearbyYouScreen(),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.categoryMerchantsScreen,
        path: RoutePath.categoryMerchantsScreen.addBasePath,
        pageBuilder: (context, state) {
          final categoryName = (state.extra as String?) ?? 'Category';

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: HomeBinding(),
              child: CategoryMerchantsScreen(categoryName: categoryName),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.merchantDetailsScreen,
        path: RoutePath.merchantDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          final merchant = state.extra as MerchantModel;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: HomeBinding(),
              child: MerchantDetailsScreen(merchant: merchant),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.offerDetailsScreen,
        path: RoutePath.offerDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          final deal = state.extra as DealModel;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: HomeBinding(),
              child: OfferDetailsScreen(deal: deal),
            ),
          );
        },
      ),

      GoRoute(
        name: RoutePath.claimedOfferDetailsScreen,
        path: RoutePath.claimedOfferDetailsScreen.addBasePath,
        pageBuilder: (context, state) {
          final deal = state.extra as DealModel;

          return _buildPageWithAnimation(
            state: state,
            child: BindingWrapper(
              binding: HomeBinding(),
              child: ClaimedOfferDetailsScreen(deal: deal),
            ),
          );
        },
      ),

      // =====================================================
      // BUSINESS ROUTES
      // =====================================================
      GoRoute(
        name: RoutePath.createOfferScreen,
        path: RoutePath.createOfferScreen.addBasePath,
        pageBuilder: (context, state) {
          return _buildPageWithAnimation(
            child: const CreateOfferScreen(),
            state: state,
          );
        },
      ),

      GoRoute(
        name: RoutePath.editOfferScreen,
        path: RoutePath.editOfferScreen.addBasePath,
        pageBuilder: (context, state) {
          final deal = state.extra as DealModel;

          return _buildPageWithAnimation(
            child: EditOfferScreen(deal: deal),
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
              binding: InfluencerBinding(),
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
              binding: InfluencerBinding(),
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
              binding: InfluencerBinding(),
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
              binding: InfluencerBinding(),
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
              child: const InfluencerSubmitContentScreen(),
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
              child: const InfluencerYourSubmissionScreen(),
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
              binding: InfluencerBinding(),
              child: const InfluencerPublishProofScreen(),
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

class BindingWrapper extends StatelessWidget {
  final Bindings binding;
  final Widget child;

  const BindingWrapper({super.key, required this.binding, required this.child});

  @override
  Widget build(BuildContext context) {
    binding.dependencies();
    return child;
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
