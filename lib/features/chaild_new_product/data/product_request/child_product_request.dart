class ChildProductGetAllRequest {
  final String color;
  final String colorName;
  final String createdAt;
  final int dollarExchangeRate;
  final String fakturaName;
  final int id;
  final List<String> image;
  final int minLimit;
  final String name;
  final int price;
  final String qrCode;
  final String size;
  final int stock;

  ChildProductGetAllRequest({
    required this.color,
    required this.colorName,
    required this.createdAt,
    required this.dollarExchangeRate,
    required this.fakturaName,
    required this.id,
    required this.image,
    required this.minLimit,
    required this.name,
    required this.price,
    required this.qrCode,
    required this.size,
    required this.stock,
  });


  factory ChildProductGetAllRequest.fromJson(Map<String, dynamic> json) {
    return ChildProductGetAllRequest(
      color: json["color"] as String? ?? "",
      colorName: json["colorName"] as String? ?? "",
      createdAt: json["created_at"] as String? ?? "",
      dollarExchangeRate: json["dollar_exchange_rate"] as int? ?? 0,
      fakturaName: json["fakturaName"] as String? ?? "",
      id: json["id"] as int? ?? 0,
      image: (json["image"] is List)
          ? List<String>.from(json["image"].map((x) => x?.toString() ?? ''))
          : <String>[],
      minLimit: json["min_limit"] as int? ?? 0,
      name: json["name"] as String? ?? "",
      price: json["price"] as int? ?? 0,
      qrCode: json["qrCode"] as String? ?? "",
      size: json["size"] as String? ?? "",
      stock: json["stock"] as int? ?? 0,
    );
  }


  Map<String, dynamic> toJson() => {
    "color": color,
    "colorName": colorName,
    "created_at": createdAt,
    "dollar_exchange_rate": dollarExchangeRate,
    "fakturaName": fakturaName,
    "id": id,
    "image": image,
    "min_limit": minLimit,
    "name": name,
    "price": price,
    "qrCode": qrCode,
    "size": size,
    "stock": stock,
  };
}