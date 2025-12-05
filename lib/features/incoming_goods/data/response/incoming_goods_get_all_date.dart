class IncomingGoodsGetAllDateResponse {
  final int count;
  final List<IncomingGoodsItem> items;

  IncomingGoodsGetAllDateResponse({
    required this.count,
    required this.items,
  });

  factory IncomingGoodsGetAllDateResponse.fromJson(Map<String, dynamic> json) {
    return IncomingGoodsGetAllDateResponse(
      count: json['count'] ?? 0,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => IncomingGoodsItem.fromJson(e))
          .toList()
          ?? [],
    );
  }
}

class IncomingGoodsItem {
  final String createdAt;
  final int date;
  final String factory;
  final int id;
  final String warehouse;

  IncomingGoodsItem({
    required this.createdAt,
    required this.date,
    required this.factory,
    required this.id,
    required this.warehouse,
  });

  factory IncomingGoodsItem.fromJson(Map<String, dynamic> json) {
    return IncomingGoodsItem(
      createdAt: json['created_at'] ?? "",
      date: json['date'] ?? 0,
      factory: json['factory'] ?? "",
      id: json['id'] ?? 0,
      warehouse: json['warehouse'] ?? "",
    );
  }
}
