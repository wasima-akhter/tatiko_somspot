import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mime/mime.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/core/service/datasource/local/app_storage.dart';
import 'package:som_spot/utils/app_strings/app_strings.dart';

import '../../../../utils/multipart/multipart_body.dart';
import '../../network/network_checker.dart';
import '../local/token_manager.dart';
import 'api_exception.dart';
import 'api_logger.dart';

class ApiClient {
  final Dio dio;

  /*
  ApiClient({required this.dio}) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final skipAuth = options.extra["skipAuth"] == true;

          if (skipAuth) {
            return handler.next(options); // no token check at all
          }

          if (TokenManager.isAccessTokenExpired) {
            if (TokenManager.isRefreshTokenExpired) {
              await AppStorage.to.logout();
              AppRouter.route.goNamed(RoutePath.loginScreen);

              return handler.reject(
                DioException(
                  requestOptions: options,
                  error: "Session expired",
                  type: DioExceptionType.cancel,
                ),
              );
            }

            final refreshToken = AppStorage.to.refreshToken;
            await AppStorage.to.setAccessToken(refreshToken);
          }

          final accessToken = AppStorage.to.accessToken;
          if (accessToken.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }

          handler.next(options);
        },
      ),
    );
  }
*/

  bool _isRedirectingToLogin = false;

  ApiClient({required this.dio}) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final skipAuth = options.extra["skipAuth"] == true;

          if (skipAuth) {
            return handler.next(options);
          }

          if (TokenManager.isAccessTokenExpired) {
            if (TokenManager.isRefreshTokenExpired) {
              await _redirectToLogin();

              return handler.reject(
                DioException(
                  requestOptions: options,
                  error: "Session expired",
                  type: DioExceptionType.cancel,
                ),
              );
            }

            final refreshToken = AppStorage.to.refreshToken;

            // Keep your existing behavior here for now.
            await AppStorage.to.setAccessToken(refreshToken);
          }

          final accessToken = AppStorage.to.accessToken;

          if (accessToken.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }

          handler.next(options);
        },

        onError: (error, handler) async {
          await _handleAuthError(error);

          handler.next(error);
        },
      ),
    );
  }

  Future<void> _handleAuthError(DioException error) async {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    String? message;

    if (responseData is Map) {
      message = responseData["message"]?.toString();
    }

    final isUnauthorized = statusCode == 401;

    final isForbidden = statusCode == 403;

    // Your backend currently returns 500 for:
    // "Access Forbidden: You do not have permission to perform this action"
    final isBackendAccessForbidden =
        statusCode == 500 &&
        message != null &&
        message.toLowerCase().contains("access forbidden");

    if (isUnauthorized || isForbidden || isBackendAccessForbidden) {
      await _redirectToLogin();
    }
  }

  Future<void> _redirectToLogin() async {
    if (_isRedirectingToLogin) {
      return;
    }

    _isRedirectingToLogin = true;

    try {
      await AppStorage.to.logout();

      AppRouter.route.goNamed(RoutePath.loginScreen);
    } finally {
      _isRedirectingToLogin = false;
    }
  }

  Future<Map<String, String>> headers({
    String? token,
    bool isJson = true,
    bool skipAuth = false,
  }) async {
    final headers = <String, String>{};

    if (!skipAuth) {
      final authToken = token ?? AppStorage.to.accessToken;

      if (authToken.isNotEmpty) {
        headers["Authorization"] = "Bearer $authToken";
      }
    }

    if (isJson) {
      headers["Content-Type"] = "application/json";
    }

    return headers;
  }

  Future<void> checkConnection() async {
    final connected = await NetworkChecker().hasConnection();

    if (!connected) {
      throw ApiException(
        message: AppStrings.noInternetConnection.tr,
        statusCode: 0,
      );
    }
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
    String? token,
    bool skipAuth = false,
    bool showResponse = false,
  }) async {
    await checkConnection();

    try {
      print("DIO GET START --> $url");
      print("QUERY --> $queryParams");

      final response = await dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: await headers(token: token, skipAuth: skipAuth),
          extra: {"skipAuth": skipAuth},
        ),
      );

      print("DIO GET SUCCESS --> ${response.statusCode}");

      print("DIO DATA --> ${response.data}");

      log(
        url,
        response,
        token: token ?? AppStorage.to.accessToken,
        queryParams: queryParams,
        showResponse: showResponse,
      );

      return response;
    } catch (e, s) {
      print("DIO GET ERROR --> $e");
      debugPrintStack(stackTrace: s);
      throw handleError(
        e,
        method: "GET",
        url: url,
        queryParams: queryParams,
        stackTrace: s,
      );
    }
  }

  Future<Response> post({
    required String url,
    required Map<String, dynamic> body,
    String? token,
    bool skipAuth = false,
    bool showResponse = false,
  }) async {
    await checkConnection();

    try {
      print("POST URL: $url");
      print("POST BODY: $body");

      final response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: await headers(token: token, skipAuth: skipAuth),
          extra: {"skipAuth": skipAuth}, // 👈 interceptor reads this
        ),
      );

      log(url, response, showResponse: showResponse);

      return response;
    } catch (e, stack) {
      print("POST ERROR: $e");
      debugPrintStack(stackTrace: stack);

      throw handleError(
        e,
        method: "POST",
        url: url,
        body: body,
        stackTrace: stack,
      );
    }
  }

  Future<Response> put({
    required String url,
    Map<String, dynamic>? body,
    String? token,
    bool showResponse = false,
  }) async {
    await checkConnection();

    try {
      final response = await dio.put(
        url,
        data: body,
        options: Options(headers: await headers(token: token)),
      );

      log(url, response, showResponse: showResponse);

      return response;
    } catch (e, s) {
      throw handleError(e, method: "PUT", url: url, body: body, stackTrace: s);
    }
  }

  Future<Response> patch({
    required String url,
    Map<String, dynamic>? body,
    String? token,
    bool showResponse = false,
  }) async {
    await checkConnection();

    try {
      final response = await dio.patch(
        url,
        data: body,
        options: Options(headers: await headers(token: token)),
      );

      log(url, response, showResponse: showResponse);

      return response;
    } on DioException catch (e, stackTrace) {
      print("❌ DIO PATCH ERROR");
      print("URL: $url");
      print("METHOD: PATCH");
      print("BODY: $body");

      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE DATA: ${e.response?.data}");
      print("RESPONSE HEADERS: ${e.response?.headers}");

      print("DIO MESSAGE: ${e.message}");
      print("TYPE: ${e.type}");

      print("STACK TRACE:");
      print(stackTrace.toString());

      throw handleError(
        e,
        method: "PATCH",
        url: url,
        body: body,
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      print("❌ UNKNOWN PATCH ERROR");
      print("ERROR: $e");
      print("STACK TRACE:");
      print(stackTrace.toString());

      throw handleError(
        e,
        method: "PATCH",
        url: url,
        body: body,
        stackTrace: stackTrace,
      );
    }
  }

  Future<Response> delete({
    required String url,
    Map<String, dynamic>? body,
    String? token,
    bool showResponse = false,
  }) async {
    await checkConnection();

    try {
      final response = await dio.delete(
        url,
        data: body,
        options: Options(headers: await headers(token: token, isJson: false)),
      );

      log(url, response, showResponse: showResponse);

      return response;
    } catch (e, s) {
      throw handleError(
        e,
        method: "DELETE",
        url: url,
        body: body,
        stackTrace: s,
      );
    }
  }

  Future<Response> uploadMultipart({
    required String url,
    required List<MultipartBody> files,
    required String method,
    String? token,
    Map<String, String>? fields,
    bool showResponse = false,
  }) async {
    await checkConnection();

    try {
      final multipartHeaders = await headers(token: token, isJson: false);

      final form = <String, dynamic>{};

      fields?.forEach((key, value) {
        form[key] = value;
      });

      for (final file in files) {
        final mime =
            lookupMimeType(file.file.path) ?? "application/octet-stream";

        final split = mime.split("/");

        form[file.fieldKey] = await MultipartFile.fromFile(
          file.file.path,
          filename: file.file.uri.pathSegments.last,
          contentType: MediaType(split[0], split[1]),
        );
      }

      // ─────────────────────────────────────────────
      // REQUEST LOG
      // ─────────────────────────────────────────────
      print("");
      print("━━━━━━━━━━ MULTIPART REQUEST ━━━━━━━━━━");
      print("URL     : $url");
      print("METHOD  : $method");

      print("FIELDS:");
      if (fields == null || fields.isEmpty) {
        print("  (none)");
      } else {
        fields.forEach((key, value) {
          print("  • $key : $value");
        });
      }

      print("FILES:");
      if (files.isEmpty) {
        print("  (none)");
      } else {
        for (final file in files) {
          final length = await file.file.length();

          print('''
  • field    : ${file.fieldKey}
    name     : ${file.file.uri.pathSegments.last}
    path     : ${file.file.path}
    size     : ${(length / 1024).toStringAsFixed(2)} KB
''');
        }
      }

      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

      final response = await dio.request(
        url,
        data: FormData.fromMap(form),
        options: Options(method: method, headers: multipartHeaders),
      );

      // ─────────────────────────────────────────────
      // RESPONSE LOG
      // ─────────────────────────────────────────────
      print("");
      print("━━━━━━━━━━ MULTIPART RESPONSE ━━━━━━━━━━");
      print(
        response.statusCode.toString().startsWith("2")
            ? "✅ SUCCESS"
            : "❌ FAILED",
      );
      print("STATUS : ${response.statusCode}");
      print("URL    : $url");
      print("BODY:");
      print(response.data.toString());
      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

      log(url, response, showResponse: showResponse);

      return response;
    } on DioException catch (e, s) {
      print("");
      print("━━━━━━━━━━ MULTIPART ERROR ━━━━━━━━━━");
      print("URL : $url");

      if (e.response != null) {
        print("STATUS : ${e.response?.statusCode}");
        print("BODY:");
        print(jsonEncode(e.response?.data));
      }

      print("MESSAGE : ${e.message}");
      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
      throw handleError(
        e,
        method: method,
        url: url,
        body: fields,
        stackTrace: s,
      );
    } catch (e, s) {
      print("");
      print("━━━━━━━━━━ MULTIPART ERROR ━━━━━━━━━━");
      print("URL : $url");
      print("ERROR : $e");
      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

      throw handleError(
        e,
        method: method,
        url: url,
        body: fields,
        stackTrace: s,
      );
    }
  }

  Exception handleError(
    dynamic error, {
    required String method,
    required String url,
    dynamic body,
    Map<String, dynamic>? queryParams,
    StackTrace? stackTrace,
  }) {
    if (error is ApiException) {
      return error;
    }

    if (error is DioException) {
      print("");
      print("━━━━━━━━━━━━ API ERROR ━━━━━━━━━━━━");
      print("❌ DIO $method ERROR");
      print("URL: $url");

      if (queryParams != null && queryParams.isNotEmpty) {
        print("QUERY: $queryParams");
      }

      if (body != null) {
        print("BODY: $body");
      }

      print("STATUS CODE: ${error.response?.statusCode}");
      print("RESPONSE DATA: ${error.response?.data}");
      print("RESPONSE HEADERS: ${error.response?.headers}");

      print("DIO MESSAGE: ${error.message}");
      print("TYPE: ${error.type}");

      if (stackTrace != null) {
        print("STACK TRACE:");
        print(stackTrace.toString());
      }

      print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

      final response = error.response;

      final statusCode = response?.statusCode ?? 500;

      final responseBody = response?.data;

      String message = "Something went wrong";

      if (responseBody is Map) {
        message = responseBody["message"]?.toString() ?? message;
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        message = "Connection timeout";
      }

      if (error.error is SocketException) {
        message = "No internet connection";
      }

      return ApiException(
        message: message,
        statusCode: statusCode,
        data: responseBody,
      );
    }

    print("");
    print("━━━━━━━━━━━━ API ERROR ━━━━━━━━━━━━");
    print("❌ UNKNOWN $method ERROR");
    print("URL: $url");

    if (queryParams != null && queryParams.isNotEmpty) {
      print("QUERY: $queryParams");
    }

    if (body != null) {
      print("BODY: $body");
    }

    print("ERROR: $error");

    if (stackTrace != null) {
      print("STACK TRACE:");
      print(stackTrace.toString());
    }

    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

    return ApiException(message: error.toString(), statusCode: 500);
  }

  void log(
    String url,

    Response response, {
    String? token,
    Map<String, dynamic>? queryParams,
    dynamic request,
    dynamic parsedData,
    bool showResponse = true,
  }) {
    ApiLogger.showResponse(
      url: url,
      token: token,
      response: response,
      request: request,
      parsedData: parsedData,
      queryParams: queryParams,
      enabled: showResponse,
    );
  }

  Future<void> _refreshToken() async {
    final refreshToken = AppStorage.to.refreshToken;

    if (refreshToken.isEmpty) {
      return;
    }

    try {
      final response = await dio.post(
        "/auth/refresh",
        data: {"refreshToken": refreshToken},
      );

      final newAccessToken = response.data["data"]["accessToken"];

      final payload = Jwt.parseJwt(newAccessToken);

      await AppStorage.to.setAccessToken(newAccessToken);

      await AppStorage.to.setTokenExpiry(int.parse(payload["exp"].toString()));
    } catch (e) {
      await AppStorage.to.logout();
    }
  }

  //
}

// 401 --> add separately.
// You are not authorized
