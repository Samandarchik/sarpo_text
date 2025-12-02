import '../../../praduct/data/product_request/get_all_brand_request.dart';
import '../../data/new_praduct_request/new_brands.dart';
import '../../data/new_praduct_request/new_product_request.dart';

enum LoginEventType { loginPressed }

abstract class NewProductsScreenBlocEvent {}

class NewProductsEvent extends NewProductsScreenBlocEvent {
  final NewProductRequest newProductRequest;

  NewProductsEvent({required this.newProductRequest});
}

class NewBrandEvent extends NewProductsScreenBlocEvent {
  final NewCategoryAndBrandRequest newCategoryRequest;

  NewBrandEvent({required this.newCategoryRequest});
}

class NewCategoryEvent extends NewProductsScreenBlocEvent {
  final NewCategoryAndBrandRequest newCategoryRequest;

  NewCategoryEvent({required this.newCategoryRequest});
}
class BrandEvent extends NewProductsScreenBlocEvent {
  final BrandGetAllRequest brandGetAllRequest;

  BrandEvent({required this.brandGetAllRequest});
}
class CategoriesEvent extends NewProductsScreenBlocEvent {
  final BrandGetAllRequest brandGetAllRequest;

  CategoriesEvent({required this.brandGetAllRequest});
}
