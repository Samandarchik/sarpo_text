
import '../../data/product_request/add_child_product.dart';
import '../../data/product_request/child_product_delete.dart';
import '../../data/product_request/child_product_request.dart';

enum ChildProductsScreenBlocEventType { loginPressed,success,filer }
abstract class ChildProductsScreenBlocEvent{

}
class ChildGetAlProductsScreenBlocEvent extends ChildProductsScreenBlocEvent{
  final int productGetAllRequest;

  ChildGetAlProductsScreenBlocEvent({
    required this.productGetAllRequest,

  });
}

class ChildDeleteProductsScreenBlocEvent extends ChildProductsScreenBlocEvent{
  final ChildProductDelete id;

  ChildDeleteProductsScreenBlocEvent({
    required this.id,

  });
}

class ChildEditeProductsEvent extends ChildProductsScreenBlocEvent {
  final ChildProductAddRequest newProductRequest;
  final int product_id;

  ChildEditeProductsEvent({required this.newProductRequest,required this.product_id});
}

class ChildAddProductsEvent extends ChildProductsScreenBlocEvent {
  final ChildProductAddRequest newProductRequest;
  ChildAddProductsEvent({required this.newProductRequest});
}
