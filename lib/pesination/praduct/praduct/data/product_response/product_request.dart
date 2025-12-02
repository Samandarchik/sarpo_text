
import 'package:dio/dio.dart';
class ProductGetAllRequest {
  final int? limit;
  final int? offset;
  final String? search;
  final String? categoryId;
  final String? brandId;
  final String? isActive;

  ProductGetAllRequest({
    this.limit,
    this.offset,
    this.search,
    this.categoryId,
    this.brandId,
    this.isActive,
  });

  Map<String, dynamic> toQueryParameters() {
    final Map<String, dynamic> params = {};

    if (limit != null) params['limit'] = limit;
    if (offset != null) params['offset'] = offset;
    if (search != null && search!.isNotEmpty) params['search'] = search;
    if (categoryId != null && categoryId!.isNotEmpty) {
      params['category_id'] = categoryId;
    }
    if (brandId != null && brandId!.isNotEmpty) {
      params['brand_id'] = brandId;
    }
    if (isActive != null && isActive!.isNotEmpty) {
      params['is_active'] = isActive;
    }

    return params;
  }

  ProductGetAllRequest copyWith({
    int? limit,
    int? offset,
    String? search,
    String? categoryId,
    String? brandId,
    String? isActive,
  }) {
    return ProductGetAllRequest(
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      search: search ?? this.search,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      isActive: isActive ?? this.isActive,
    );
  }
}









