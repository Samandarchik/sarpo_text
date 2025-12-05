import 'package:dartz/dartz.dart';
import 'package:untitled7/features/icoming_goods_item/data/source/incoming_goods_item_source.dart';

import '../../../incoming_goods/data/response/factory_get_all_response.dart';
import '../../data/request/incoming_goods_items_get_all_request.dart';
import '../../data/response/incoming_goods_items_get_all_response.dart';

abstract class IncomingGoodsItemRepository {
  Future<Either<Future, IncomingGoodsResponse>> getAllIncomingGoodsItemsGetAll(
    IncomingGoodsRequest date,
  );
}

class IncomingGoodsItemRepositoryImpl extends IncomingGoodsItemRepository {
  final IncomingGoodsItemSource incomingGoodsItemSource;

  IncomingGoodsItemRepositoryImpl(this.incomingGoodsItemSource);

  @override
  Future<Either<Future<dynamic>, IncomingGoodsResponse>>
  getAllIncomingGoodsItemsGetAll(IncomingGoodsRequest date) async {
    final response = await incomingGoodsItemSource
        .getAllIncomingGoodsItemsGetAll(date);
    return Right(response);
  }
}
