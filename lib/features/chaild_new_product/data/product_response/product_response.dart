class ChildProductsResponse {
  final List<Product> products;
  final int count;

  ChildProductsResponse({
    required this.products,
    required this.count,
  });

  factory ChildProductsResponse.fromJson(Map<String, dynamic> json) {
    return ChildProductsResponse(
      products: (json['Products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Products": products.map((e) => e.toJson()).toList(),
      "count": count,
    };
  }
}

class Product {
  final List<String> barCode;
  final int? brandId;
  final int? categoryId;
  final String? createdAt;
  final String? description;
  final int? id;
  final bool? isActive;
  final String? name;
  final int? vatRate;

  Product({
    required this.barCode,
    this.brandId,
    this.categoryId,
    this.createdAt,
    this.description,
    this.id,
    this.isActive,
    this.name,
    this.vatRate,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      barCode: List<String>.from(json["bar_code"] ?? []),
      brandId: json["brand_id"],
      categoryId: json["category_id"],
      createdAt: json["created_at"],
      description: json["description"],
      id: json["id"],
      isActive: json["is_active"],
      name: json["name"],
      vatRate: json["vat_rate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "bar_code": barCode,
      "brand_id": brandId,
      "category_id": categoryId,
      "created_at": createdAt,
      "description": description,
      "id": id,
      "is_active": isActive,
      "name": name,
      "vat_rate": vatRate,
    };
  }
}
