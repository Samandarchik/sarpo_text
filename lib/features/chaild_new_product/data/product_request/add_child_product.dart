class ChildProductAddRequest {
  final String color;
  final String colorName;
  final int dollarExchangeRate;
  final String fakturaName;
  final List<String> image;
  final int minLimit;
  final String name;
  final int price;
  final int productId;
  final String qrCode;
  final String size;
  final int stock;

  ChildProductAddRequest({
    required this.color,
    required this.colorName,
    required this.dollarExchangeRate,
    required this.fakturaName,
    required this.image,
    required this.minLimit,
    required this.name,
    required this.price,
    required this.productId,
    required this.qrCode,
    required this.size,
    required this.stock,
  });

  ChildProductAddRequest copyWith({
    String? color,
    String? colorName,
    int? dollarExchangeRate,
    String? fakturaName,
    List<String>? image,
    int? minLimit,
    String? name,
    int? price,
    int? productId,
    String? qrCode,
    String? size,
    int? stock,
  }) {
    return ChildProductAddRequest(
      color: color ?? this.color,
      colorName: colorName ?? this.colorName,
      dollarExchangeRate: dollarExchangeRate ?? this.dollarExchangeRate,
      fakturaName: fakturaName ?? this.fakturaName,
      image: image ?? this.image,
      minLimit: minLimit ?? this.minLimit,
      name: name ?? this.name,
      price: price ?? this.price,
      productId: productId ?? this.productId,
      qrCode: qrCode ?? this.qrCode,
      size: size ?? this.size,
      stock: stock ?? this.stock,
    );
  }

  factory ChildProductAddRequest.fromJson(Map<String, dynamic> json) {
    return ChildProductAddRequest(
      color: json['color'] as String? ?? '',
      colorName: json['colorName'] as String? ?? '',
      dollarExchangeRate: json['dollar_exchange_rate'] as int? ?? 0,
      fakturaName: json['fakturaName'] as String? ?? '',
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => e?.toString() ?? '')
          .toList() ??
          <String>[],
      minLimit: json['min_limit'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      price: json['price'] as int? ?? 0,
      productId: (json['product_id'] is int)
          ? json['product_id'] as int
          : int.tryParse(json['product_id']?.toString() ?? '') ?? 0,
      qrCode: json['qrCode'] as String? ?? '',
      size: json['size'] as String? ?? '',
      stock: json['stock'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'colorName': colorName,
      'dollar_exchange_rate': dollarExchangeRate,
      'fakturaName': fakturaName,
      'image': image,
      'min_limit': minLimit,
      'name': name,
      'price': price,
      'product_id': productId,
      'qrCode': qrCode,
      'size': size,
      'stock': stock,
    };
  }

  @override
  String toString() {
    return 'ProductRequest(name: $name, productId: $productId, stock: $stock, price: $price)';
  }
}