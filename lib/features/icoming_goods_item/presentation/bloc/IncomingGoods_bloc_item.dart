import 'package:bloc/bloc.dart';


import '../../data/response/incoming_goods_items_get_all_response.dart';
import '../../domin/repository/incoming_goods_item_repository.dart';
import 'IncomingGoods_event_item.dart';
import 'IncomingGoods_state_item.dart';

class IncomingGoodsItemScreenBloc extends Bloc<IncomingGoodsItemEvent, IncomingGoodsItemState> {
  final IncomingGoodsItemRepository repository;

  IncomingGoodsItemScreenBloc(this.repository)
    : super(
        IncomingGoodsItemState(incomingGoodsResponse: IncomingGoodsResponse(count: 10, items: []
          
        )),
      ) {
    //   on<FactorysGetAllDate>((event, emit) async {
    //     final response = await repository.getAllFactrys(
    //       event.factoryGetAllRequest,
    //     );
    //     response.fold(
    //       (l) {
    //         emit(
    //           state.copyWith(
    //             factorysStateScreenStatus: IncomingGoodsStatus.failure,
    //           ),
    //         );
    //       },
    //       (i) {
    //         emit(state.copyWith(factoryStates: i.factories));
    //         print("myProduct${i.factories.length}");
    //       },
    //     );
    //   });
    //   on<FactrysAddDate>((event, emit) async {
    //     final response = await repository.addFactrys(event.factriysAddRequest);
    //    await response.fold(
    //       (l) async{
    //         emit(
    //           state.copyWith(
    //             factorysStateScreenStatus: IncomingGoodsStatus.failure,
    //           ),
    //         );
    //       },
    //       (i) async{
    //         emit(
    //           state.copyWith(
    //             factorysStateScreenStatus: IncomingGoodsStatus.success,
    //           ),
    //         );
    //
    //         await _refreshProducts(emit);
    //       },
    //     );
    //   });
    //
    //   on<IncomingGoodsGetAllDateEvent>((event, emit) async {
    //     final response = await repository.getAllIncomingGood(
    //       event.incomingGoodsGetAllDateRequest,
    //     );
    //     response.fold(
    //           (l) {
    //         emit(
    //           state.copyWith(
    //             factorysStateScreenStatus: IncomingGoodsStatus.failure,
    //           ),
    //         );
    //       },
    //           (i) {
    //         emit(state.copyWith(incomingGood: i.items));
    //         // print("myProduct${i.factories.length}");
    //       },
    //     );
    //   });
    //
    //
    //   on<IncomingGoodsAddDateEvent>((event, emit) async {
    //     final response = await repository.addIncomingDate(event.incomingGoodsAddRequest);
    //     await response.fold(
    //           (l) async{
    //         emit(
    //           state.copyWith(
    //             factorysStateScreenStatus: IncomingGoodsStatus.failure,
    //           ),
    //         );
    //       },
    //           (i) async{
    //         emit(
    //           state.copyWith(
    //             factorysStateScreenStatus: IncomingGoodsStatus.success,
    //           ),
    //         );
    //
    //         // await _refreshProducts(emit);
    //       },
    //     );
    //   });
    //
    //
    // }
    //
    //
    //
    // Future<void> _refreshProducts(Emitter<IncomingGoodsState> emit) async {
    //   final date = FactoryGetAllRequest(search: "", offset: 100, limit: 100);
    //   final products = await repository.getAllFactrys(date);
    //
    //   products.fold(
    //         (error) {
    //       state.copyWith(
    //         factorysStateScreenStatus: IncomingGoodsStatus.failure,
    //       );
    //     },
    //         (responseData) {
    //       emit(state.copyWith(factoryStates: responseData.factories));
    //     },
    //   );
    // }
    //
  }

}
