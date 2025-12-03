
class GetAllBrand {
  final List<Brand> brands;
  final int count;

  GetAllBrand({
    required this.brands,
    required this.count,
  });

  factory GetAllBrand.fromJson(Map<String, dynamic> json) {
    final List<dynamic> brandsJson = json['brands'] as List<dynamic>;
    final List<Brand> brandsList = brandsJson
        .map((brandJson) => Brand.fromJson(brandJson as Map<String, dynamic>))
        .toList();

    return GetAllBrand(
      brands: brandsList,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brands': brands.map((brand) => brand.toJson()).toList(),
      'count': count,
    };
  }
}

class Brand {
  final String createdAt;
  final int id;
  final String image;
  final bool isActive;
  final String name;

  Brand({
    required this.createdAt,
    required this.id,
    required this.image,
    required this.isActive,
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      createdAt: json['created_at'] as String,
      id: json['id'] as int,
      image: json['image'] as String,
      isActive: json['is_active'] as bool,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'id': id,
      'image': image,
      'is_active': isActive,
      'name': name,
    };
  }
}