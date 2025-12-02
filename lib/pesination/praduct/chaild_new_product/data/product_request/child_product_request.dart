class ChildProductGetAllRequest {
  final String color;
  final String colorName;
  final String createdAt;
  final String fakturaName;
  final int id;
  final List<String> image;
  final String name;
  final int price;
  final String qrCode;
  final String size;
  final int stock;

  ChildProductGetAllRequest({
    required this.color,
    required this.colorName,
    required this.createdAt,
    required this.fakturaName,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.qrCode,
    required this.size,
    required this.stock,
  });

  /// FROM JSON
  factory ChildProductGetAllRequest.fromJson(Map<String, dynamic> json) {
    return ChildProductGetAllRequest(
      color: json["color"] ?? "",
      colorName: json["colorName"] ?? "",
      createdAt: json["created_at"] ?? "",
      fakturaName: json["fakturaName"] ?? "",
      id: json["id"] ?? 0,
      image: List<String>.from(json["image"].map((x) => x.toString())),
      name: json["name"] ?? "",
      price: json["price"] ?? 0,
      qrCode: json["qrCode"] ?? "",
      size: json["size"] ?? "",
      stock: json["stock"] ?? 0,
    );
  }

  /// TO JSON — agar backendga qaytarish kerak bo‘lsa
  Map<String, dynamic> toJson() => {
    "color": color,
    "colorName": colorName,
    "created_at": createdAt,
    "fakturaName": fakturaName,
    "id": id,
    "image": image,
    "name": name,
    "price": price,
    "qrCode": qrCode,
    "size": size,
    "stock": stock,
  };
}
