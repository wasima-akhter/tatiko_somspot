import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import '../../../../../share/export/service_export.dart';
import '../../../../../share/model/pagination_meta_model.dart';
import '../../../../../share/widgets/paginator/paginator.dart';
import '../../../../utils/app_strings/app_strings.dart';
import '../repository/review_repository.dart';
import '../response/review_response.dart';

class ReviewService {
  final ReviewRepository _repository;

  ReviewService(this._repository);

  /// Get reviews for a business.
  Future<ApiResponse<PaginatedResult<BusinessReviewModel>>> getBusinessReviews({
    required String businessId,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _repository.getBusinessReviews(
        businessId: businessId,
        page: page,
        limit: limit,
      );

      final responseData = response.data;

      final data = responseData is Map ? responseData['data'] : null;

      final dataMap = data is Map
          ? Map<String, dynamic>.from(data)
          : <String, dynamic>{};

      final result = dataMap['result'];

      final reviews = result is List
          ? result
                .whereType<Map>()
                .map(
                  (e) => BusinessReviewModel.fromJson(
                    Map<String, dynamic>.from(e),
                  ),
                )
                .toList()
          : <BusinessReviewModel>[];

      final metaJson = dataMap['meta'];

      final meta = metaJson is Map
          ? PaginationMeta.fromJson(Map<String, dynamic>.from(metaJson))
          : PaginationMeta(
              page: page,
              limit: limit,
              total: reviews.length,
              totalPage: reviews.isEmpty ? 0 : 1,
            );

      return ApiResponse.success(
        data: PaginatedResult<BusinessReviewModel>(data: reviews, meta: meta),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Get Business Reviews Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  /// Submit a customer review.
  Future<ApiResponse<Response>> postReview({
    required String businessId,
    required num rating,
    required String review,
  }) async {
    try {
      final response = await _repository.postReview(
        businessId: businessId,
        rating: rating,
        review: review,
      );

      return ApiResponse.success(data: response);
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Post Review Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  /// Get reviews posted by the currently authenticated customer.
  Future<ApiResponse<PaginatedResult<MyReviewModel>>> getMyReviews({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _repository.getMyReviews(page: page, limit: limit);

      final responseData = response.data;

      final data = responseData is Map ? responseData['data'] : null;

      final dataMap = data is Map
          ? Map<String, dynamic>.from(data)
          : <String, dynamic>{};

      final result = dataMap['result'];

      final reviews = result is List
          ? result
                .whereType<Map>()
                .map(
                  (e) => MyReviewModel.fromJson(Map<String, dynamic>.from(e)),
                )
                .toList()
          : <MyReviewModel>[];

      final metaJson = dataMap['meta'];

      final meta = metaJson is Map
          ? PaginationMeta.fromJson(Map<String, dynamic>.from(metaJson))
          : PaginationMeta(
              page: page,
              limit: limit,
              total: reviews.length,
              totalPage: reviews.isEmpty ? 0 : 1,
            );

      return ApiResponse.success(
        data: PaginatedResult<MyReviewModel>(data: reviews, meta: meta),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Get My Reviews Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }

  //
  /// Toggle user's helpful vote on a review.
  Future<ApiResponse<ReviewHelpfulModel>> toggleReviewHelpful({
    required String reviewId,
  }) async {
    try {
      final response = await _repository.toggleReviewHelpful(
        reviewId: reviewId,
      );

      final responseData = response.data;

      final data = responseData is Map ? responseData['data'] : null;

      if (data is! Map) {
        return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
      }

      return ApiResponse.success(
        data: ReviewHelpfulModel.fromJson(Map<String, dynamic>.from(data)),
      );
    } on ApiException catch (e) {
      return ApiResponse.failure(message: e.message, statusCode: e.statusCode);
    } catch (e, s) {
      print("Toggle Review Helpful Error: $e");
      debugPrintStack(stackTrace: s);

      return ApiResponse.failure(message: AppStrings.somethingWentWrong.tr);
    }
  }
}
