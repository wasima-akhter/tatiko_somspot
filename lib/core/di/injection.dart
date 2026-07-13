import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:som_spot/core/service/datasource/remote/api_client.dart';
import 'package:som_spot/core/service/network/network_checker.dart';

import '../../features/auth/repository/auth_repository.dart';
import '../../features/auth/service/auth_service.dart';

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
}
