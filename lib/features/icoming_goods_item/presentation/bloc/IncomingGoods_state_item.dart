

import '../../data/response/incoming_goods_items_get_all_response.dart';

enum IncomingGoodsItemStatus { initial, loading, success, failure }


class IncomingGoodsItemState {
  final IncomingGoodsResponse incomingGoodsResponse;
  // final IncomingGoodsStatus factorysStateScreenStatus;
  // final List<Factory> factoryStates;
  // final List<IncomingGoodsItem> incomingGood;

  const IncomingGoodsItemState({required this.incomingGoodsResponse});

  IncomingGoodsItemState copyWith({
    IncomingGoodsResponse? incomingGoodsResponse
  }) {
    return IncomingGoodsItemState(
      incomingGoodsResponse: incomingGoodsResponse?? this.incomingGoodsResponse,
    );
  }
}


