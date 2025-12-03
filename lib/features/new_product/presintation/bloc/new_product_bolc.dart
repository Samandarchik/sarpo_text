import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../praduct/data/product_request/get_all_brand_request.dart';
import '../../data/new_praduct_request/new_brands.dart';
import '../../domain/repositery/new_product_repository.dart';
import 'new_product_event.dart';
import 'new_product_state.dart';

class NewProductsScreenBloc extends Bloc<NewProductsScreenBlocEvent, NewProductsScreenBlocState> {
  final NewProductRepository newProductRepository;

  NewProductsScreenBloc(this.newProductRepository) : super(NewProductsScreenBlocState()) {
    on<NewProductsEvent>((event, emit) async{
      emit(state.copyWith(status: NewProductsScreenStatus.loading));

      final response = await newProductRepository.addProduct(event.newProductRequest);


      response.fold(
            (ifLeft) {
          print("ProductSize${response.length}");

        },
            (response) {
              emit(state.copyWith(status: NewProductsScreenStatus.success));



        },
      );
    });
    on<NewBrandEvent>((event, emit) async {

      final response = await newProductRepository.addBranch(event.newCategoryRequest);

      await response.fold(
            (ifLeft) {
          print("Error during addBranch: ${ifLeft.toString()}");
          emit(state.copyWith(status: NewProductsScreenStatus.failure));
          return;
        },
            (successResponse) async {


              final data= BrandGetAllRequest(
                limit:0,
                offset: 0,
              );
          final getAllCategoriesResponse = await newProductRepository.getAllBrand(data);

          getAllCategoriesResponse.fold(
                (ifLeft) {
              print("Error during getAllCategories: ${ifLeft.toString()}");

            },
                (response) {

              emit(state.copyWith(
                status: NewProductsScreenStatus.success,
                brand: response.brands,
              ));
            },
          );
        },
      );
    });
    on<NewCategoryEvent>((event, emit) async {

      final response = await newProductRepository.addCategoryBranch(event.newCategoryRequest);

      await response.fold(
            (ifLeft) {
          print("Error during addBranch: ${ifLeft.toString()}");
          emit(state.copyWith(status: NewProductsScreenStatus.failure));
          return;
        },
            (successResponse) async {
          final data= BrandGetAllRequest(
            limit:0,
            offset: 0,
          );
          final getAllCategoriesResponse = await newProductRepository.getAllCategories(data);

          getAllCategoriesResponse.fold(
                (ifLeft) {
              print("Error during getAllCategories: ${ifLeft.toString()}");

            },
                (response) {
              emit(state.copyWith(
                status: NewProductsScreenStatus.success,
                categoriesEvent: response.categories,
              ));
            },
          );
        },
      );
    });

    on<BrandEvent>((event, emit) async{
      print("ProductSize${"newBranch funksiya chaqirdi"}");

      emit(state.copyWith(status: NewProductsScreenStatus.loading));

      final response = await newProductRepository.getAllBrand(event.brandGetAllRequest);


      response.fold(
            (ifLeft) {
          print("ProductSize${response.length}");

        },
            (response) {
          emit(state.copyWith(status: NewProductsScreenStatus.success,brand: response.brands));


          // print("ProductSize${response.products.length}");
          // emit(state.copyWith(productList,status: ProductsScreenStatus.success));
        },
      );
    });
    on<CategoriesEvent>((event, emit) async{
      print("ProductSize${"newBranch funksiya chaqirdi"}");

      emit(state.copyWith(status: NewProductsScreenStatus.loading));

      final response = await newProductRepository.getAllCategories(event.brandGetAllRequest);


      response.fold(
            (ifLeft) {
          print("ProductSize${response.length}");

        },
            (response) {
          emit(state.copyWith(status: NewProductsScreenStatus.success,categoriesEvent: response.categories));


          // print("ProductSize${response.products.length}");
          // emit(state.copyWith(productList,status: ProductsScreenStatus.success));
        },
      );
    });

  }
}