import '../../data/product_request/child_product_request.dart';
import '../../data/product_response/product_response.dart';

enum ChildProductsScreenStatus { initial, loading, success, failure }



class ChildProductsScreenBlocState {
  final ChildProductsScreenStatus status;
  final List<ChildProductGetAllRequest>? response;
  final String? errorMessage;
  final int productId;

  const ChildProductsScreenBlocState({
    this.status = ChildProductsScreenStatus.initial,
    this.response = const [],
    this.errorMessage,
    this.productId=0,
  });

  ChildProductsScreenBlocState copyWith({
    ChildProductsScreenStatus? status,
    List<ChildProductGetAllRequest>? response,
    String? errorMessage,
    int? productId
  }) {
    return ChildProductsScreenBlocState(
      status: status ?? this.status,
      response: response ?? this.response,
      errorMessage: errorMessage ?? this.errorMessage,
      productId: productId?? this.productId
    );
  }
}
