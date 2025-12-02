import 'package:bloc/bloc.dart';
import 'package:untitled7/pesination/praduct/praduct/presintation/bloc/product_event.dart';
import 'package:untitled7/pesination/praduct/praduct/presintation/bloc/product_state.dart';

import '../../data/product_response/product_request.dart';
import '../../domain/product_repository/product_repository.dart';

class ProductsScreenBloc
    extends Bloc<ProductsScreenBlocEvent, ProductsScreenBlocState> {
  final ProductRepository newProductRepository;

  ProductsScreenBloc(this.newProductRepository)
    : super(const ProductsScreenBlocState()) {
    on<GetAlProductsScreenBlocEvent>((event, emit) async {
      emit(state.copyWith(status: ProductsScreenStatus.loading));

      final response = await newProductRepository.getAllProduct(
        event.productGetAllRequest,
      );

      response.fold(
        (ifLeft) {
          print("ProductSize${response.length}");
        },
        (response) {
          final productList = response.products;

          print("ProductSize${response.products.length}");
          emit(
            state.copyWith(
              response: productList,
              status: ProductsScreenStatus.success,
            ),
          );
        },
      );
    });
    on<EditeProductsEvent>((event, emit) async {
      print("ProductSizeEdite${"Edite"}");

      final response = await newProductRepository.editeProduct(
        event.newProductRequest,
      );
      final date = ProductGetAllRequest(
        limit: 0,
        offset: 0,
        search: "",
        categoryId: "",
        brandId: "",
        isActive: "",
      );
      final responseGetAll = await newProductRepository.getAllProduct(date);
      response.fold(
        (ifLeft) {
          print("ProductSizeEdite${response.length}");
        },
        (response) {
          responseGetAll.fold(
            (ifLeft) {
              print("ProductSize${response.length}");
            },
            (response) {
              final productList = response.products;

              print("ProductSize${response.products.length}");
              emit(
                state.copyWith(
                  response: productList,
                  status: ProductsScreenStatus.success,
                ),
              );
            },
          );
        },
      );
    });

    // Bloc
    on<DeleteProductsScreenBlocEvent>((event, emit) async {
      emit(state.copyWith(status: ProductsScreenStatus.loading));

      try {
        final success = await newProductRepository.deleteProduct(event.id);

        success.fold(
          (left) {
            emit(state.copyWith(status: ProductsScreenStatus.failure));
            print("sabina${success.length}");
          },
          (right) {
            final updatedList = state.response
                .where((p) => p.id != event.id.id)
                .toList();
            print("sabina${updatedList.length}");

            emit(
              state.copyWith(
                status: ProductsScreenStatus.success,
                response: updatedList,
              ),
            );
          },
        );
      } catch (e) {}
    });

    on<NewProductsEvent>((event, emit) async {
      emit(state.copyWith(status: ProductsScreenStatus.loading));

      final response = await newProductRepository.addProduct(
        event.newProductRequest,
      );

      response.fold(
        (ifLeft) {
          print("ProductSize${response.length}");
        },
        (response) {
          emit(state.copyWith(status: ProductsScreenStatus.success));

          // print("ProductSize${response.products.length}");
          // emit(state.copyWith(productList,status: ProductsScreenStatus.success));
        },
      );
    });
    on<NewBranchEvent>((event, emit) async {
      print("ProductSize${"newBranch funksiya chaqirdi"}");

      emit(state.copyWith(status: ProductsScreenStatus.loading));

      final response = await newProductRepository.addBranch(
        event.newCategoryRequest,
      );

      response.fold(
        (ifLeft) {
          print("ProductSize${response.length}");
        },
        (response) {
          emit(state.copyWith(status: ProductsScreenStatus.success));

          // print("ProductSize${response.products.length}");
          // emit(state.copyWith(productList,status: ProductsScreenStatus.success));
        },
      );
    });
  }
}
