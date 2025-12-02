import 'package:untitled7/pesination/praduct/praduct/data/product_response/get_all_brend_request.dart';

import '../../data/product_request/product_response.dart';

enum ProductsScreenStatus { initial, loading, success, failure }

class ProductsScreenBlocState {
  final ProductsScreenStatus status;
  final List<Product> response;
  final List<Brand> brand;
  final String? errorMessage;

  const ProductsScreenBlocState({
    this.status = ProductsScreenStatus.initial,
    this.response = const [],
    this.brand = const [],
    this.errorMessage,
  });

  ProductsScreenBlocState copyWith({
    ProductsScreenStatus? status,
    List<Product>? response,
    List<Brand>? brand,
    String? errorMessage,
  }) {
    return ProductsScreenBlocState(
      status: status ?? this.status,
      response: response ?? this.response,
      brand: brand ?? this.brand,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
