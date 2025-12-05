
import '../../data/response/factory_get_all_response.dart';
import '../../data/response/incoming_goods_get_all_date.dart';

enum IncomingGoodsStatus { initial, loading, success, failure }


class IncomingGoodsState {
  final IncomingGoodsStatus factorysStateScreenStatus;
  final List<Factory> factoryStates;
  final List<IncomingGoodsItem> incomingGood;

  const IncomingGoodsState({
    required this.factoryStates,
    required this.factorysStateScreenStatus, required this.incomingGood
  });

  IncomingGoodsState copyWith({
    List<Factory>? factoryStates,
    List<IncomingGoodsItem>? incomingGood,
    final IncomingGoodsStatus? factorysStateScreenStatus
  }) {
    return IncomingGoodsState(
      factoryStates: factoryStates ?? this.factoryStates,
        incomingGood: incomingGood ?? this.incomingGood,
      factorysStateScreenStatus: factorysStateScreenStatus?? this.factorysStateScreenStatus
    );
  }
}


