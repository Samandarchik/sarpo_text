class IncomingGoodsResponse {
  final int count;
  final List<IncomingGoodsGetAllItem> items;

  IncomingGoodsResponse({
    required this.count,
    required this.items,
  });

  factory IncomingGoodsResponse.fromJson(Map<String, dynamic> json) {
    return IncomingGoodsResponse(
      count: json['count'] ?? 0,
      items: (json['items'] as List<dynamic>)
          .map((e) => IncomingGoodsGetAllItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}
class IncomingGoodsGetAllItem {
  final String createdAt;
  final int id;
  final String productName;
  final int purchasePrice;
  final int quantity;
  final int sellingPrice;
  final int total;

  IncomingGoodsGetAllItem({
    required this.createdAt,
    required this.id,
    required this.productName,
    required this.purchasePrice,
    required this.quantity,
    required this.sellingPrice,
    required this.total,
  });

  factory IncomingGoodsGetAllItem.fromJson(Map<String, dynamic> json) {
    return IncomingGoodsGetAllItem(
      createdAt: json['created_at'] ?? '',
      id: json['id'] ?? 0,
      productName: json['product_name'] ?? '',
      purchasePrice: json['purchase_price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      sellingPrice: json['selling_price'] ?? 0,
      total: json['total'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'id': id,
      'product_name': productName,
      'purchase_price': purchasePrice,
      'quantity': quantity,
      'selling_price': sellingPrice,
      'total': total,
    };
  }
}
