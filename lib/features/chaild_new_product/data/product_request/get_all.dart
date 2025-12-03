import 'child_product_request.dart';

class ProductAndChildGetAllDate {
  final List<ProductAndChildGetAll> products;
  final int count;

  ProductAndChildGetAllDate({
    required this.products,
    required this.count,
  });

  factory ProductAndChildGetAllDate.fromJson(Map<String, dynamic> json) {
    return ProductAndChildGetAllDate(
      products: (json['Products'] as List)
          .map((e) => ProductAndChildGetAll.fromJson(e))
          .toList(),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Products': products.map((e) => e.toJson()).toList(),
      'count': count,
    };
  }
}

class ProductAndChildGetAll {
  final List<String> barCode;
  final int brandId;
  final String brandName;
  final String category;
  final List<ChildProductGetAllRequest> childProduct; // 🔥 ALMASHTIRILDI
  final String createdAt;
  final String description;
  final int id;
  final bool isActive;
  final String name;
  final int vatRate;

  ProductAndChildGetAll({
    required this.barCode,
    required this.brandId,
    required this.brandName,
    required this.category,
    required this.childProduct, // 🔥
    required this.createdAt,
    required this.description,
    required this.id,
    required this.isActive,
    required this.name,
    required this.vatRate,
  });

  factory ProductAndChildGetAll.fromJson(Map<String, dynamic> json) {
    return ProductAndChildGetAll(
      barCode: List<String>.from(json['bar_code'] ?? []),
      brandId: json['brand_id'] ?? 0,
      brandName: json['brand_name'] ?? "",
      category: json['category'] ?? "",
      childProduct: (json['child'] as List) // 🔥 "child" ni o‘qiydi, ammo model sizniki
          .map((e) => ChildProductGetAllRequest.fromJson(e))
          .toList(),
      createdAt: json['created_at'] ?? "",
      description: json['description'] ?? "",
      id: json['id'] ?? 0,
      isActive: json['is_active'] ?? false,
      name: json['name'] ?? "",
      vatRate: json['vat_rate'] ?? 0,
    );
}

  Map<String, dynamic> toJson() {
    return {
      'bar_code': barCode,
      'brand_id': brandId,
      'brand_name': brandName,
      'category': category,
      'child': childProduct.map((e) => e.toJson()).toList(), // 🔥 backendga mos
      'created_at': createdAt,
      'description': description,
      'id': id,
      'is_active': isActive,
      'name': name,
      'vat_rate': vatRate,
    };
  }
}
