class BrandGetAllRequest {
  final int limit;

  final int offset;

  BrandGetAllRequest({
    required this.limit,
    required this.offset,
  });

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'offset': offset,
    };
  }
}