class CustomerSearchResultModel {
  final String id;
  final String name;
  final SearchCategoryModel? category;
  final String logo;
  final String address;
  final double ratingAvg;
  final int ratingCount;

  CustomerSearchResultModel({
    required this.id,
    required this.name,
    this.category,
    required this.logo,
    required this.address,
    required this.ratingAvg,
    required this.ratingCount,
  });

  factory CustomerSearchResultModel.fromJson(Map<String, dynamic> json) {
    return CustomerSearchResultModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      category: json['category'] != null
          ? SearchCategoryModel.fromJson(json['category'])
          : null,
      logo: json['logo']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      ratingAvg: (json['ratingAvg'] as num?)?.toDouble() ?? 0,
      ratingCount: (json['ratingCount'] as num?)?.toInt() ?? 0,
    );
  }
}

class SearchCategoryModel {
  final String name;
  final String slug;

  SearchCategoryModel({required this.name, required this.slug});

  factory SearchCategoryModel.fromJson(Map<String, dynamic> json) {
    return SearchCategoryModel(
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
    );
  }
}

class CustomerSearchResponseModel {
  final String term;
  final List<CustomerSearchResultModel> results;

  CustomerSearchResponseModel({required this.term, required this.results});

  factory CustomerSearchResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerSearchResponseModel(
      term: json['term']?.toString() ?? '',
      results: List<CustomerSearchResultModel>.from(
        (json['result'] ?? []).map(
          (e) => CustomerSearchResultModel.fromJson(e),
        ),
      ),
    );
  }
}

class RecentSearchModel {
  final String id;
  final String term;

  RecentSearchModel({required this.id, required this.term});

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) {
    return RecentSearchModel(
      id: json['_id']?.toString() ?? '',
      term: json['term']?.toString() ?? '',
    );
  }
}

class TrendingSearchModel {
  final String term;
  final int count;

  TrendingSearchModel({required this.term, required this.count});

  factory TrendingSearchModel.fromJson(Map<String, dynamic> json) {
    return TrendingSearchModel(
      term: json['term']?.toString() ?? '',
      count: (json['count'] as num?)?.toInt() ?? 0,
    );
  }
}
