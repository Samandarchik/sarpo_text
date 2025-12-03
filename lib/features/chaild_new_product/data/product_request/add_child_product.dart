

class ChildProductAddRequest {
  final String color;
  final String colorName;
  final String fakturaName;
  final List<String> image;
  final String name;
  final int productId;
  final String qrCode;
  final String size;
  final int price;

  ChildProductAddRequest({
    required this.color,
    required this.colorName,
    required this.fakturaName,
    required this.image,
    required this.name,
    required this.productId,
    required this.qrCode,
    required this.size,
    required this.price
  });

  ChildProductAddRequest copyWith({
    String? color,
    String? colorName,
    String? fakturaName,
    List<String>? image,
    String? name,
    int? productId,
    String? qrCode,
    String? size,
    int?price
  }) {
    return ChildProductAddRequest(
      color: color ?? this.color,
      colorName: colorName ?? this.colorName,
      fakturaName: fakturaName ?? this.fakturaName,
      image: image ?? this.image,
      name: name ?? this.name,
      productId: productId ?? this.productId,
      qrCode: qrCode ?? this.qrCode,
      size: size ?? this.size,
      price: price?? this.price
    );
  }

  factory ChildProductAddRequest.fromJson(Map<String, dynamic> json) {
    return ChildProductAddRequest(
      color: json['color'] as String? ?? '',
      colorName: json['colorName'] as String? ?? '',
      fakturaName: json['fakturaName'] as String? ?? '',
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => e?.toString() ?? '')
          .toList() ??
          <String>[],
      name: json['name'] as String? ?? '',
      productId: (json['product_id'] is int)
          ? json['product_id'] as int
          : int.tryParse(json['product_id']?.toString() ?? '') ?? 0,
      qrCode: json['qrCode'] as String? ?? '',
      size: json['size'] as String? ?? '',
      price: json['price'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'colorName': colorName,
      'fakturaName': fakturaName,
      'image': image,
      'name': name,
      'product_id': productId,
      'qrCode': qrCode,
      'size': size,
      'price':price
    };
  }

  @override
  String toString() {
    return 'ProductRequest(name: $name, productId: $productId, imageCount: ${image.length})';
  }
}
