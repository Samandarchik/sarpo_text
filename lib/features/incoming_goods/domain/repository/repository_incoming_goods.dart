import 'package:dartz/dartz.dart';

import '../../data/request/add_incoming_good_date.dart';
import '../../data/request/factrys_add_request.dart';
import '../../data/request/get_all_request.dart';
import '../../data/request/incoming_goods_get_all_date_request.dart';
import '../../data/response/factory_get_all_response.dart';
import '../../data/response/incoming_goods_get_all_date.dart';
import '../../data/source/incoming_goods_source.dart';

abstract class IncomingGoodsRepository {
  Future<Either<Future, FactoryGetAllResponse>> getAllFactrys(
    FactoryGetAllRequest date,
  );

  Future<Either<Future, IncomingGoodsGetAllDateResponse>> getAllIncomingGood(
    IncomingGoodsGetAllDateRequest date,
  );

  Future<Either<Future, String>> addFactrys(FactriysAddRequest date);

  Future<Either<Future, String>> addIncomingDate(IncomingGoodsAddRequest date);
}

class IncomingGoodsRepositoryImpl extends IncomingGoodsRepository {
  final IncomingGoodsSource factrysSource;

  IncomingGoodsRepositoryImpl(this.factrysSource);

  @override
  Future<Either<Future, FactoryGetAllResponse>> getAllFactrys(
    FactoryGetAllRequest date,
  ) async {
    final response = await factrysSource.getAllFactrys(date);
    return Right(response);
  }

  @override
  Future<Either<Future<dynamic>, String>> addFactrys(
    FactriysAddRequest date,
  ) async {
    final response = await factrysSource.addFactrys(date);
    return Right(response);
  }

  @override
  Future<Either<Future<dynamic>, IncomingGoodsGetAllDateResponse>>
  getAllIncomingGood(IncomingGoodsGetAllDateRequest date) async {
    final response = await factrysSource.getAllIncomingGood(date);
    return Right(response);
  }

  @override
  Future<Either<Future<dynamic>, String>> addIncomingDate(
    IncomingGoodsAddRequest date,
  ) async {
    final response = await factrysSource.addIncomingDate(date);
    return Right(response);
  }
}
