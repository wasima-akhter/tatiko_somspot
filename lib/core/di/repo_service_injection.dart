import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:som_spot/core/service/datasource/remote/api_client.dart';
import 'package:som_spot/core/service/network/network_checker.dart';
import 'package:som_spot/features/auth/completed_profile_influencer/service/influencer_complete_profile_service.dart';
import 'package:som_spot/features/customer/customer_home/repository/customer_home_repository.dart';
import 'package:som_spot/features/customer/customer_home/service/home_content_service.dart';
import 'package:som_spot/features/customer/search/repository/customer_search_repository.dart';
import 'package:som_spot/features/customer/search/service/customer_search_service.dart';
import 'package:som_spot/features/influencer_all/core/influencer_tasks/repository/influencer_tasks_repository.dart';
import 'package:som_spot/features/influencer_all/influencer_dashboard/repository/influencer_dashboard_repository.dart';
import 'package:som_spot/features/influencer_all/influencer_dashboard/service/influencer_dashboard_service.dart';
import 'package:som_spot/features/influencer_all/influencer_wallet/repository/influencer_wallet_repository.dart';
import 'package:som_spot/features/influencer_all/influencer_wallet/service/influencer_wallet_service.dart';
import 'package:som_spot/features/merchant/listings/repository/manage_business_repository.dart';
import 'package:som_spot/features/merchant/listings/service/manage_listing_service.dart';
import 'package:som_spot/features/merchant/merchant_new_campaign/shared/repository/merchant_campaign_repository.dart';
import 'package:som_spot/features/merchant/stats/repository/stats_repository.dart';
import 'package:som_spot/features/merchant/stats/service/stats_service.dart';

import '../../features/auth/complete_business_profile/repository/complete_business_profile_repository.dart';
import '../../features/auth/complete_business_profile/service/complete_business_profile_service.dart';
import '../../features/auth/completed_profile_customer_merchandiser/repository/complete_profile_repository.dart';
import '../../features/auth/completed_profile_customer_merchandiser/service/complete_profile_service.dart';
import '../../features/auth/completed_profile_influencer/repository/influencer_complete_profile_repository.dart';
import '../../features/auth/core/repository/auth_repository.dart';
import '../../features/auth/core/service/auth_service.dart';
import '../../features/core/business/repository/business-repository.dart';
import '../../features/core/business/service/business-service.dart';
import '../../features/core/category/repository/category_repository.dart';
import '../../features/core/category/service/category_service.dart';
import '../../features/influencer_all/core/influencer_tasks/service/influencer_tasks_service.dart';
import '../../features/merchant/dashboard_merchant/repository/dashboard_merchant_repository.dart';
import '../../features/merchant/dashboard_merchant/service/dashboard_merchant_service.dart';
import '../../features/merchant/merchant_new_campaign/shared/service/merchant_campaign_service.dart';
import '../../features/offers/shared/repository/offers_repository.dart';
import '../../features/offers/shared/service/offers_service.dart';
import '../../features/other/repository/other_repository.dart';
import '../../features/other/service/other_service.dart';
import '../../features/profile/repository/influencer_profile_repository.dart';
import '../../features/profile/repository/profile_repository.dart';
import '../../features/profile/service/influencer_profile_service.dart';
import '../../features/profile/service/profile_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  //
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    ),
  );

  sl.registerLazySingleton<ApiClient>(() => ApiClient(dio: sl<Dio>()));

  sl.registerLazySingleton<NetworkChecker>(() => NetworkChecker());

  //

  // Auth data layer
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(sl<ApiClient>()),
  );

  // Auth business layer
  sl.registerLazySingleton<AuthService>(
    () => AuthService(sl<AuthRepository>()),
  );

  // =====================
  // Profile
  // =====================

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<ProfileService>(
    () => ProfileService(sl<ProfileRepository>()),
  );

  // =====================
  // Complete Profile
  // =====================
  sl.registerLazySingleton<CompleteProfileRepository>(
    () => CompleteProfileRepository(sl()),
  );

  sl.registerLazySingleton<CompleteProfileService>(
    () => CompleteProfileService(sl()),
  );

  // =====================
  // Complete Business Profile --> merchant
  // =====================

  sl.registerLazySingleton<CompleteBusinessProfileRepository>(
    () => CompleteBusinessProfileRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<CompleteBusinessProfileService>(
    () =>
        CompleteBusinessProfileService(sl<CompleteBusinessProfileRepository>()),
  );

  // =====================
  // Complete info Profile --> INFLUENCER
  // =====================

  sl.registerLazySingleton<InfluencerCompleteProfileRepository>(
    () => InfluencerCompleteProfileRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<InfluencerCompleteProfileService>(
    () => InfluencerCompleteProfileService(
      sl<InfluencerCompleteProfileRepository>(),
    ),
  );

  // =====================
  // Category
  // =====================

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<CategoryService>(
    () => CategoryService(sl<CategoryRepository>()),
  );

  // =====================
  // Other
  // =====================

  sl.registerLazySingleton<OtherRepository>(
    () => OtherRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<OtherService>(
    () => OtherService(sl<OtherRepository>()),
  );

  // =====================
  // Business
  // =====================

  sl.registerLazySingleton<BusinessRepository>(
    () => BusinessRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<BusinessService>(
    () => BusinessService(sl<BusinessRepository>()),
  );

  // =====================
  // Offer
  // =====================

  sl.registerLazySingleton<OfferRepository>(
    () => OfferRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<OfferService>(
    () => OfferService(sl<OfferRepository>()),
  );

  // =====================
  // Merchant Dashboard
  // =====================

  sl.registerLazySingleton<DashboardMerchantRepository>(
    () => DashboardMerchantRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<DashboardMerchantService>(
    () => DashboardMerchantService(sl<DashboardMerchantRepository>()),
  );

  sl.registerLazySingleton<StatsRepository>(
    () => StatsRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<StatsService>(
    () => StatsService(sl<StatsRepository>()),
  );
  // =====================
  // Merchant Business Profile Update
  // =====================

  sl.registerLazySingleton<ManageBusinessRepository>(
    () => ManageBusinessRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<ManageBusinessService>(
    () => ManageBusinessService(sl<ManageBusinessRepository>()),
  );

  // =====================
  // Merchant New Campaign
  // =====================

  sl.registerLazySingleton<MerchantCampaignRepository>(
    () => MerchantCampaignRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<MerchantCampaignService>(
    () => MerchantCampaignService(sl<MerchantCampaignRepository>()),
  );
  // =====================
  // INFLUENCER Task
  // =====================

  sl.registerLazySingleton<InfluencerTasksRepository>(
    () => InfluencerTasksRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<InfluencerTasksService>(
    () => InfluencerTasksService(sl<InfluencerTasksRepository>()),
  );

  // =====================
  // Influencer Dashboard
  // =====================

  sl.registerLazySingleton<InfluencerDashboardRepository>(
    () => InfluencerDashboardRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<InfluencerDashboardService>(
    () => InfluencerDashboardService(sl<InfluencerDashboardRepository>()),
  );
  // =====================
  // Influencer Wallet
  // =====================

  sl.registerLazySingleton<InfluencerWalletRepository>(
    () => InfluencerWalletRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<InfluencerWalletService>(
    () => InfluencerWalletService(sl<InfluencerWalletRepository>()),
  );
  // =====================
  // Influencer Info edit
  // =====================

  sl.registerLazySingleton<InfluencerProfileRepository>(
    () => InfluencerProfileRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<InfluencerProfileService>(
    () => InfluencerProfileService(sl<InfluencerProfileRepository>()),
  );

  // =====================
  // Customer Home
  // =====================

  sl.registerLazySingleton<HomeContentRepository>(
    () => HomeContentRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<HomeContentService>(
    () => HomeContentService(sl<HomeContentRepository>()),
  );

  // =====================
  // Customer Search
  // =====================

  sl.registerLazySingleton<CustomerSearchRepository>(
    () => CustomerSearchRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<CustomerSearchService>(
    () => CustomerSearchService(sl<CustomerSearchRepository>()),
  );
}
