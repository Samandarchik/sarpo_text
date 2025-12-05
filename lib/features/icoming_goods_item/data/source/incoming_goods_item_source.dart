 import 'package:dio/dio.dart';

import '../../../../core/app_constante/app_constante.dart';
import '../request/incoming_goods_items_get_all_request.dart';
import '../response/incoming_goods_items_get_all_response.dart';

abstract class IncomingGoodsItemSource {
   Future<IncomingGoodsResponse> getAllIncomingGoodsItemsGetAll(IncomingGoodsRequest date);


 }
class IncomingGoodsItemSourceImpl extends IncomingGoodsItemSource{
  final Dio _dio ;

  IncomingGoodsItemSourceImpl(this._dio);
  @override
  Future<IncomingGoodsResponse> getAllIncomingGoodsItemsGetAll(IncomingGoodsRequest date) async{
    try {
      final response = await _dio.get(
        AppConstants.GET_FACTRYS,
        queryParameters: date.toJson(),
      );
      final responseDate = IncomingGoodsResponse.fromJson(response.data);
      return responseDate;
    } catch (e) {
      rethrow;
    }
  }

}