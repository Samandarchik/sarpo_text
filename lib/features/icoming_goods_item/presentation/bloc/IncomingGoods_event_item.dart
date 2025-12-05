
import '../../data/request/incoming_goods_items_get_all_request.dart';

class IncomingGoodsItemEvent{

}

class IncomingGoodsItemGetAllEvent extends IncomingGoodsItemEvent{
  final IncomingGoodsRequest incomingGoodsRequest;


  IncomingGoodsItemGetAllEvent(this.incomingGoodsRequest);}

// class IncomingGoodsAddDateEvent extends IncomingGoodsEvent{
//   final IncomingGoodsAddRequest incomingGoodsAddRequest;
//
//   IncomingGoodsAddDateEvent(this.incomingGoodsAddRequest);
// }