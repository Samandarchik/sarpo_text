
import 'package:dartz/dartz.dart';

import 'package:untitled7/core/exception/exception.dart';

import '../../../new_product/data/new_praduct_request/new_brands.dart';
import '../../../new_product/data/new_praduct_request/new_product_request.dart';
import '../../data/product_request/edite_product_request.dart';
import '../../data/product_request/get_all_brand_request.dart';
import '../../data/product_request/product_delete.dart';
import '../../data/product_response/get_all_brend_request.dart';
import '../../data/product_response/product_request.dart';
import '../../data/product_request/product_response.dart';
import '../../data/product_source/product_source.dart';

abstract class ProductRepository{
  Future<Either<Failure, ProductsResponse>> getAllProduct(ProductGetAllRequest request);
  Future<Either<Failure, GetAllBrand>> getAllBrand(BrandGetAllRequest request);
  Future<Either<Failure, String>> deleteProduct(ProductDelete request);
  Future<Either<Failure, String>> editeProduct(EditeProductRequest request);
  Future<Either<Failure, String>> addProduct(NewProductRequest request);
  Future<Either<Failure, String>> addBranch(NewCategoryAndBrandRequest request);

}
class ProductRepositoryImpl extends ProductRepository{
  final ProductSource productSource;

  ProductRepositoryImpl(this.productSource);

  @override
  Future<Either<Failure, ProductsResponse>> getAllProduct(request)async {
    final resul = await productSource.getAllProduct(request);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(ProductDelete request) async{
    final resul = await productSource.deleteProductRequest(request);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> editeProduct(EditeProductRequest request)async {
    final resul = await productSource.editeProduct(request);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> addProduct(NewProductRequest request)async {
    final resul = await productSource.addProduct(request);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> addBranch(NewCategoryAndBrandRequest request) async{
    final resul = await productSource.addCategoryRequest(request);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

  @override
  Future<Either<Failure, GetAllBrand>> getAllBrand(BrandGetAllRequest request) async{
    final resul = await productSource.getAllBrand(request);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

}