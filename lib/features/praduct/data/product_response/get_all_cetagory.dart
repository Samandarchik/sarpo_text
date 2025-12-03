import 'get_all_brend_request.dart';

class GetAllCategory {
  final List<Brand> categories;
  final int count;

  GetAllCategory({
    required this.categories,
    required this.count,
  });

  factory GetAllCategory.fromJson(Map<String, dynamic> json) {
    final List<dynamic> brandsJson = json['categories'] as List<dynamic>;
    final List<Brand> brandsList = brandsJson
        .map((brandJson) => Brand.fromJson(brandJson as Map<String, dynamic>))
        .toList();

    return GetAllCategory(
      categories: brandsList,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((brand) => brand.toJson()).toList(),
      'count': count,
    };
  }
}