class IncomingGoodsGetAllDateRequest {

  final int? limit;

  final int? offset;

  const IncomingGoodsGetAllDateRequest({this.limit, this.offset});

  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> params = {};


    if (limit != null) {
      params['limit'] = limit.toString();
    }
    if (offset != null) {
      params['offset'] = offset.toString();
    }

    return params;
  }

  Map<String, dynamic> toJson() {
    return {'limit': limit, 'offset': offset};
  }
}