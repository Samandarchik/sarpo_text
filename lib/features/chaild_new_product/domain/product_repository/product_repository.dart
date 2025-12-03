
import 'package:dartz/dartz.dart';

import 'package:untitled7/core/exception/exception.dart';

import '../../data/product_request/add_child_product.dart';
import '../../data/product_request/child_product_delete.dart';
import '../../data/product_request/child_product_request.dart';
import '../../data/product_request/get_all.dart';
import '../../data/product_response/product_response.dart';
import '../../data/product_source/child_product_source.dart';

abstract class ChildProductRepository{
  Future<Either<Failure, List<ChildProductGetAllRequest>>> getAllProduct(int request);
  Future<Either<Failure, ProductAndChildGetAllDate>> getAllChild(int request);
  Future<Either<Failure, String>> deleteProduct(ChildProductDelete request);
  Future<Either<Failure, String>> editeProduct(ChildProductAddRequest request,int id);
  Future<Either<Failure, String>> addChildProduct(ChildProductAddRequest request);

}
class ChildProductRepositoryImpl extends ChildProductRepository{
  final ChildProductSource productSource;

  ChildProductRepositoryImpl(this.productSource);

  @override
  Future<Either<Failure, List<ChildProductGetAllRequest>>> getAllProduct(request)async {
    final resul = await productSource.getAllProduct(request);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct(ChildProductDelete request) async{
    final resul = await productSource.deleteProductRequest(request);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> editeProduct(ChildProductAddRequest request,int id)async {
    final resul = await productSource.editeProduct(request,id);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> addChildProduct(ChildProductAddRequest request) async {
    final resul = await productSource.addChildProduct(request);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

  @override
  Future<Either<Failure, ProductAndChildGetAllDate>> getAllChild(int request)async {
    final resul = await productSource.getAllChild(request);
    try{
      return Right(resul);
    }catch(e){

      rethrow;
    }
  }

}