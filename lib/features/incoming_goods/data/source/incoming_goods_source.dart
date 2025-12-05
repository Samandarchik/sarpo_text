import 'package:dio/dio.dart';
import 'package:untitled7/core/app_constante/app_constante.dart';

import '../request/add_incoming_good_date.dart';
import '../request/factrys_add_request.dart';
import '../request/get_all_request.dart';
import '../request/incoming_goods_get_all_date_request.dart';
import '../response/factory_get_all_response.dart';
import '../response/incoming_goods_get_all_date.dart';

abstract class IncomingGoodsSource {
  Future<FactoryGetAllResponse> getAllFactrys(FactoryGetAllRequest date);

  Future<IncomingGoodsGetAllDateResponse> getAllIncomingGood(
    IncomingGoodsGetAllDateRequest date,
  );

  Future<String> addFactrys(FactriysAddRequest date);

  Future<String> addIncomingDate(IncomingGoodsAddRequest date);
}

class IncomingGoodsSourceImpl extends IncomingGoodsSource {
  final Dio _dio;

  IncomingGoodsSourceImpl(this._dio);

  @override
  Future<FactoryGetAllResponse> getAllFactrys(FactoryGetAllRequest date) async {
    try {
      final response = await _dio.get(
        AppConstants.GET_FACTRYS,
        queryParameters: date.toJson(),
      );
      final responseDate = FactoryGetAllResponse.fromJson(response.data);
      return responseDate;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> addFactrys(FactriysAddRequest date) async {
    try {
      final response = await _dio.post(
        AppConstants.Add_factory_create,
        data: date.toJson(),
      );

      return response.statusCode.toString();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<IncomingGoodsGetAllDateResponse> getAllIncomingGood(
    IncomingGoodsGetAllDateRequest date,
  ) async {
    try {
      final response = await _dio.get(
        AppConstants.GET_INCOMING_GOOD,
        queryParameters: date.toJson(),
      );
      final responseDate = IncomingGoodsGetAllDateResponse.fromJson(
        response.data,
      );
      return responseDate;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> addIncomingDate(IncomingGoodsAddRequest date) async{
    try {
      final response = await _dio.post(
        AppConstants.Add_incoming_goods_create,
        data: date.toJson(),
      );

      return response.statusCode.toString();
    } catch (e) {
      rethrow;
    }
  }
}
