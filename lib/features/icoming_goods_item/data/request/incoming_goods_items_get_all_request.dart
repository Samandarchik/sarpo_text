class IncomingGoodsRequest {
  final int incomingGoodsId;

  final int limit;


  final String offset;


  IncomingGoodsRequest({
    required this.incomingGoodsId,
    required this.limit,
    required this.offset,
  });


  factory IncomingGoodsRequest.fromJson(Map<String, dynamic> json) {
    return IncomingGoodsRequest(
      
      incomingGoodsId: json['incoming_goods_id'] as int,
      limit: json['limit'] as int,
      offset: json['offset'] as String,
    );
  }

  // Dart obyektini JSONga aylantirish (Method for Serialization)
  Map<String, dynamic> toJson() {
    return {
      'incoming_goods_id': incomingGoodsId,
      'limit': limit,
      'offset': offset,
    };
  }
}