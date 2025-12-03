import 'package:bloc/bloc.dart';
import 'package:untitled7/features/praduct/presintation/bloc/product_event.dart';
import 'package:untitled7/features/praduct/presintation/bloc/product_state.dart';


import '../../data/product_response/product_request.dart';
import '../../domain/product_repository/product_repository.dart';

class ProductsScreenBloc
    extends Bloc<ProductsScreenBlocEvent, ProductsScreenBlocState> {
  final ProductRepository newProductRepository;

  ProductsScreenBloc(this.newProductRepository)
      : super(const ProductsScreenBlocState()) {
    on<GetAlProductsScreenBlocEvent>((event, emit) async {
      emit(state.copyWith(status: ProductsScreenStatus.loading));

      await _refreshProducts(emit, event.productGetAllRequest);
    });

    on<EditeProductsEvent>((event, emit) async {
      emit(state.copyWith(status: ProductsScreenStatus.loading));

      final response =
      await newProductRepository.editeProduct(event.newProductRequest);

      await response.fold(
            (l) async {
          emit(state.copyWith(status: ProductsScreenStatus.failure));
        },
            (r) async {
          await _refreshProducts(emit, _defaultGetAll());
        },
      );
    });

    on<DeleteProductsScreenBlocEvent>((event, emit) async {
      emit(state.copyWith(status: ProductsScreenStatus.loading));

      final response = await newProductRepository.deleteProduct(event.id);

      await response.fold(
            (l) async {
          emit(state.copyWith(status: ProductsScreenStatus.failure));
        },
            (r) async {
          await _refreshProducts(emit, _defaultGetAll());
        },
      );
    });

    on<NewProductsEvent>((event, emit) async {
      emit(state.copyWith(status: ProductsScreenStatus.loading));

      final response =
      await newProductRepository.addProduct(event.newProductRequest);

      await response.fold(
            (l) async {
          emit(state.copyWith(status: ProductsScreenStatus.failure));
        },
            (r) async {
          await _refreshProducts(emit, _defaultGetAll());
        },
      );
    });

    on<NewBranchEvent>((event, emit) async {
      emit(state.copyWith(status: ProductsScreenStatus.loading));

      final response =
      await newProductRepository.addBranch(event.newCategoryRequest);

      await response.fold(
            (l) async {
          emit(state.copyWith(status: ProductsScreenStatus.failure));
        },
            (r) async {
          await _refreshProducts(emit, _defaultGetAll());
        },
      );
    });
  }

  Future<void> _refreshProducts(
      Emitter<ProductsScreenBlocState> emit,
      ProductGetAllRequest request,
      ) async {
    final response = await newProductRepository.getAllProduct(request);

    response.fold(
          (l) {
        emit(state.copyWith(status: ProductsScreenStatus.failure));
      },
          (r) {
        emit(state.copyWith(
          response: r.products,
          status: ProductsScreenStatus.success,
        ));
      },
    );
  }

  ProductGetAllRequest _defaultGetAll() {
    return ProductGetAllRequest(
      limit: 0,
      offset: 0,
      search: "",
      categoryId: "",
      brandId: "",
      isActive: "",
    );
  }
}
