class NewProductRequest {
  final List<String> barCode;
  final int brandId;
  final int categoryId;
  final String description;
  final bool isActive;
  final String name;
  final int vatRate;

  NewProductRequest({
    required this.barCode,
    required this.brandId,
    required this.categoryId,
    required this.description,
    required this.isActive,
    required this.name,
    required this.vatRate,
  });

  Map<String, dynamic> toJson() {
    return {
      "bar_code": barCode,
      "brand_id": brandId,
      "category_id": categoryId,
      "description": description,
      "is_active": isActive,
      "name": name,
      "vat_rate": vatRate,
    };
  }
}
