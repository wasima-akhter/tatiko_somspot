import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:mime/mime.dart';
import 'package:som_spot/core/router/route_path.dart';
import 'package:som_spot/core/router/routes.dart';
import 'package:som_spot/core/service/datasource/local/app_storage.dart';
import 'package:som_spot/utils/multipart/multipart_body.dart';

import '../../network/network_checker.dart';
import '../local/token_manager.dart';
import 'api_exception.dart';
import 'api_logger.dart';

class ApiClient {
  final Dio dio;

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
      throw ApiException(message: "No internet connection", statusCode: 0);
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
      final response = await dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: await headers(token: token, skipAuth: skipAuth),
          extra: {"skipAuth": skipAuth},
        ),
      );

      log(url, response, queryParams: queryParams, showResponse: showResponse);

      return response;
    } catch (e) {
      throw handleError(e);
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
      debugPrint("POST URL: $url");
      debugPrint("POST BODY: $body");

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
      debugPrint("POST ERROR: $e");
      debugPrintStack(stackTrace: stack);

      throw handleError(e);
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
    } catch (e) {
      throw handleError(e);
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
    } catch (e) {
      throw handleError(e);
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
    } catch (e) {
      throw handleError(e);
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

      final response = await dio.request(
        url,
        data: FormData.fromMap(form),
        options: Options(method: method, headers: multipartHeaders),
      );

      log(url, response, showResponse: showResponse);

      return response;
    } catch (e) {
      throw handleError(e);
    }

    //
  }

  Exception handleError(dynamic error) {
    if (error is ApiException) {
      return error;
    }

    if (error is DioException) {
      final response = error.response;

      final statusCode = response?.statusCode ?? 500;

      final body = response?.data;

      String message = "Something went wrong";

      if (body is Map) {
        message = body["message"]?.toString() ?? message;
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        message = "Connection timeout";
      }

      if (error.error is SocketException) {
        message = "No internet connection";
      }

      return ApiException(message: message, statusCode: statusCode, data: body);
    }

    return ApiException(message: error.toString(), statusCode: 500);
  }

  void log(
    String url,
    Response response, {
    Map<String, dynamic>? queryParams,
    dynamic request,
    dynamic parsedData,
    bool showResponse = true,
  }) {
    ApiLogger.showResponse(
      url: url,
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
