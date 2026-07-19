import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:som_spot/core/service/datasource/remote/api_client.dart';
import 'package:som_spot/core/service/network/network_checker.dart';

import '../../features/auth/complete_business_profile/repository/complete_business_profile_repository.dart';
import '../../features/auth/complete_business_profile/service/complete_business_profile_service.dart';
import '../../features/auth/completed_profile_customer/repository/complete_profile_repository.dart';
import '../../features/auth/completed_profile_customer/service/complete_profile_service.dart';
import '../../features/auth/repository/auth_repository.dart';
import '../../features/auth/service/auth_service.dart';
import '../../features/core/business/repository/business-repository.dart';
import '../../features/core/business/service/business-service.dart';
import '../../features/core/category/repository/category_repository.dart';
import '../../features/core/category/service/category_service.dart';
import '../../features/dashboard/create_offer/repository/create_offer_repository.dart';
import '../../features/dashboard/create_offer/service/create_offer_service.dart';
import '../../features/dashboard/dashboard_merchant/repository/dashboard_merchant_repository.dart';
import '../../features/dashboard/dashboard_merchant/service/dashboard_merchant_service.dart';
import '../../features/other/repository/other_repository.dart';
import '../../features/other/service/other_service.dart';
import '../../features/profile/repository/profile_repository.dart';
import '../../features/profile/service/profile_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
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
  // Complete Business Profile
  // =====================

  sl.registerLazySingleton<CompleteBusinessProfileRepository>(
    () => CompleteBusinessProfileRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<CompleteBusinessProfileService>(
    () =>
        CompleteBusinessProfileService(sl<CompleteBusinessProfileRepository>()),
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
}
