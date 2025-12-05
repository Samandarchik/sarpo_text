import '../../data/request/add_incoming_good_date.dart';
import '../../data/request/factrys_add_request.dart';
import '../../data/request/get_all_request.dart';
import '../../data/request/incoming_goods_get_all_date_request.dart';

class IncomingGoodsEvent{

}
class FactorysGetAllDate extends IncomingGoodsEvent{
  final FactoryGetAllRequest factoryGetAllRequest;

  FactorysGetAllDate(this.factoryGetAllRequest);
}

class FactrysAddDate extends IncomingGoodsEvent{
  final FactriysAddRequest factriysAddRequest;

  FactrysAddDate(this.factriysAddRequest);
}

class IncomingGoodsGetAllDateEvent extends IncomingGoodsEvent{
  final IncomingGoodsGetAllDateRequest incomingGoodsGetAllDateRequest;

  IncomingGoodsGetAllDateEvent(this.incomingGoodsGetAllDateRequest);
}


class IncomingGoodsAddDateEvent extends IncomingGoodsEvent{
  final IncomingGoodsAddRequest incomingGoodsAddRequest;

  IncomingGoodsAddDateEvent(this.incomingGoodsAddRequest);
}