class FactoryGetAllRequest {
  final String? search;
  final int? limit;

  final int? offset;

  const FactoryGetAllRequest({this.search, this.limit, this.offset});

  Map<String, dynamic> toQueryParams() {
    final Map<String, dynamic> params = {};

    if (search != null && search!.isNotEmpty) {
      params['search'] = search;
    }

    if (limit != null) {
      params['limit'] = limit.toString();
    }
    if (offset != null) {
      params['offset'] = offset.toString();
    }

    return params;
  }

  Map<String, dynamic> toJson() {
    return {'search': search, 'limit': limit, 'offset': offset};
  }
}
