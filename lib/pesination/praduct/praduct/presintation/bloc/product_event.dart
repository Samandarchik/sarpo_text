import '../../../chaild_new_product/data/product_request/child_product_delete.dart';
import '../../../chaild_new_product/data/product_request/child_product_request.dart';
import '../../../new_product/data/new_praduct_request/new_brands.dart';
import '../../../new_product/data/new_praduct_request/new_product_request.dart';
import '../../data/product_request/edite_product_request.dart';
import '../../data/product_request/get_all_brand_request.dart';
import '../../data/product_request/product_delete.dart';
import '../../data/product_response/product_request.dart';

enum ProductsScreenBlocEventType { loginPressed,success,filer }
abstract class ProductsScreenBlocEvent{

}
class GetAlProductsScreenBlocEvent extends ProductsScreenBlocEvent{
  final ProductGetAllRequest productGetAllRequest;

  GetAlProductsScreenBlocEvent({
    required this.productGetAllRequest,

  });
}

class DeleteProductsScreenBlocEvent extends ProductsScreenBlocEvent{
  final ProductDelete id;

  DeleteProductsScreenBlocEvent({
    required this.id,

  });
}

class EditeProductsEvent extends ProductsScreenBlocEvent {
  final EditeProductRequest newProductRequest;

  EditeProductsEvent({required this.newProductRequest});
}


class NewProductsEvent extends ProductsScreenBlocEvent {
  final NewProductRequest newProductRequest;

  NewProductsEvent({required this.newProductRequest});
}

class NewBranchEvent extends ProductsScreenBlocEvent {
  final NewCategoryAndBrandRequest newCategoryRequest;

  NewBranchEvent({required this.newCategoryRequest});
}

class BrandEvent extends ProductsScreenBlocEvent {
  final BrandGetAllRequest brandGetAllRequest;

  BrandEvent({required this.brandGetAllRequest});
}

