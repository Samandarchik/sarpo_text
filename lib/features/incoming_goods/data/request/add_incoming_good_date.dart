class IncomingGoodsAddRequest {
  final int date;
  final int factoryId;
  final String warehouse;

  IncomingGoodsAddRequest({
    required this.date,
    required this.factoryId,
    required this.warehouse,
  });

  factory IncomingGoodsAddRequest.fromJson(Map<String, dynamic> json) {
    return IncomingGoodsAddRequest(
      date: json['date'] ?? 0,
      factoryId: json['factory_id'] ?? 0,
      warehouse: json['warehouse'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'date': date, 'factory_id': factoryId, 'warehouse': warehouse};
  }
}
