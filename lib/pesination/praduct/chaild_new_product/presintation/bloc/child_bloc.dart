import 'package:bloc/bloc.dart';
import 'package:untitled7/pesination/praduct/chaild_new_product/presintation/bloc/product_child_event.dart';
import 'package:untitled7/pesination/praduct/chaild_new_product/presintation/bloc/product_child_state.dart';

import '../../data/product_request/child_product_request.dart';
import '../../domain/product_repository/product_repository.dart';

class ChildProductsScreenBloc
    extends Bloc<ChildProductsScreenBlocEvent, ChildProductsScreenBlocState> {

  final ChildProductRepository childProductRepository;

  ChildProductsScreenBloc(this.childProductRepository)
      : super(const ChildProductsScreenBlocState()) {


    /// ---------------------- GET ALL ----------------------
    on<ChildGetAlProductsScreenBlocEvent>((event, emit) async {
      emit(state.copyWith(status: ChildProductsScreenStatus.loading));

      final result =
      await childProductRepository.getAllProduct(event.productGetAllRequest);

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


      final products = await childProductRepository.getAllProduct(
        state.productId,
      );

      editResult.fold(
            (left) {
          emit(state.copyWith(status: ChildProductsScreenStatus.failure));
        },
            (right) {
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
        },
      );
    });


    on<ChildDeleteProductsScreenBlocEvent>((event, emit) async {
      emit(state.copyWith(status: ChildProductsScreenStatus.loading));

      try {
        final deleteResult =
        await childProductRepository.deleteProduct(event.id);

        final products = await childProductRepository.getAllProduct(
          state.productId,
        );

        deleteResult.fold(
              (left) {
            emit(state.copyWith(status: ChildProductsScreenStatus.failure));
          },
              (right) {
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
          },
        );
      } catch (e) {
        emit(state.copyWith(status: ChildProductsScreenStatus.failure));
      }
    });


    on<ChildAddProductsEvent>((event, emit) async {
      emit(state.copyWith(status: ChildProductsScreenStatus.loading));

      try {
        final addResult = await childProductRepository.addChildProduct(
          event.newProductRequest,
        );

        final products = await childProductRepository.getAllProduct(
          state.productId,
        );

        addResult.fold(
              (left) {
            emit(state.copyWith(status: ChildProductsScreenStatus.failure));
          },
              (right) {
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
          },
        );
      } catch (e) {
        emit(state.copyWith(status: ChildProductsScreenStatus.failure));
      }
    });
  }
}
