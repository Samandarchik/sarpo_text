import 'package:bloc/bloc.dart';
import 'package:untitled7/features/chaild_new_product/presintation/bloc/product_child_event.dart';
import 'package:untitled7/features/chaild_new_product/presintation/bloc/product_child_state.dart';


import '../../domain/product_repository/product_repository.dart';

class ChildProductsScreenBloc
    extends Bloc<ChildProductsScreenBlocEvent, ChildProductsScreenBlocState> {

  final ChildProductRepository childProductRepository;

  ChildProductsScreenBloc(this.childProductRepository)
      : super(const ChildProductsScreenBlocState()) {


    on<ChildGetAlProductsScreenBlocEvent>((event, emit) async {
      emit(state.copyWith(status: ChildProductsScreenStatus.loading));

      final result = await childProductRepository.getAllProduct(
          event.productGetAllRequest);

      result.fold(
            (error) {
          emit(state.copyWith(status: ChildProductsScreenStatus.failure));
        },
            (responseData) {
          emit(state.copyWith(
            productId: event.productGetAllRequest,
            response: responseData ?? [],
            status: ChildProductsScreenStatus.success,
          ));
        },
      );
    });


    on<ChildEditeProductsEvent>((event, emit) async {
      emit(state.copyWith(status: ChildProductsScreenStatus.loading));

      final editResult = await childProductRepository.editeProduct(
        event.newProductRequest,
        event.product_id,
      );

      await editResult.fold(
            (left) async {
          emit(state.copyWith(status: ChildProductsScreenStatus.failure));
        },
            (right) async {
          await _refreshProducts(emit);
        },
      );
    });


    on<ChildDeleteProductsScreenBlocEvent>((event, emit) async {
      emit(state.copyWith(status: ChildProductsScreenStatus.loading));

      final deleteResult = await childProductRepository.deleteProduct(event.id);

      await deleteResult.fold(
            (left) async {
          emit(state.copyWith(status: ChildProductsScreenStatus.failure));
        },
            (right) async {
          await _refreshProducts(emit);
        },
      );
    });



    on<ChildAddProductsEvent>((event, emit) async {
      emit(state.copyWith(status: ChildProductsScreenStatus.loading));

      final addResult =
      await childProductRepository.addChildProduct(event.newProductRequest);

      await addResult.fold(
            (left) async {
          emit(state.copyWith(status: ChildProductsScreenStatus.failure));
        },
            (right) async {
          await _refreshProducts(emit);
        },
      );
    });
  }


  Future<void> _refreshProducts(
      Emitter<ChildProductsScreenBlocState> emit) async {
    final products = await childProductRepository.getAllProduct(state.productId);

    products.fold(
          (error) {
        emit(state.copyWith(status: ChildProductsScreenStatus.failure));
      },
          (responseData) {
        emit(state.copyWith(
          response: responseData ?? [],
          status: ChildProductsScreenStatus.success,
        ));
      },
    );
  }
}
