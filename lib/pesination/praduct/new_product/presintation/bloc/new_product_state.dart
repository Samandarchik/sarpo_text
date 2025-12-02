import '../../../praduct/data/product_response/get_all_brend_request.dart';

enum NewProductsScreenStatus { initial, loading, success, failure }

class NewProductsScreenBlocState {
  final NewProductsScreenStatus status;
  final List<Brand> brand;
  final List<Brand> categoriesEvent;

  const NewProductsScreenBlocState({
    this.status = NewProductsScreenStatus.initial,
    this.brand = const [],
    this.categoriesEvent = const [],
  });

  NewProductsScreenBlocState copyWith({
    NewProductsScreenStatus? status,
    List<Brand>? brand,
    List<Brand>? categoriesEvent,
  }) {
    return NewProductsScreenBlocState(
      status: status ?? this.status,
      brand: brand ?? this.brand,
      categoriesEvent: categoriesEvent ?? this.categoriesEvent,
    );
  }
}
