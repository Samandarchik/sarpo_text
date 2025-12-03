import 'package:dartz/dartz.dart';

import '../../../../../../core/exception/exception.dart';
import '../../../praduct/data/product_request/get_all_brand_request.dart';
import '../../../praduct/data/product_request/product_response.dart';
import '../../../praduct/data/product_response/get_all_brend_request.dart';
import '../../../praduct/data/product_response/get_all_cetagory.dart';
import '../../data/data_source/new_product_source.dart';
import '../../data/new_praduct_request/new_brands.dart';
import '../../data/new_praduct_request/new_product_request.dart';

abstract class NewProductRepository {
  Future<Either<Failure, String>> addProduct(NewProductRequest request);

  Future<Either<Failure, String>> addCategoryBranch(
    NewCategoryAndBrandRequest request,
  );

  Future<Either<Failure, String>> addBranch(NewCategoryAndBrandRequest request);

  Future<Either<Failure, GetAllBrand>> getAllBrand(BrandGetAllRequest request);

  Future<Either<Failure, GetAllCategory>> getAllCategories(
    BrandGetAllRequest request,
  );
}

class NewProductRepositoryImpl extends NewProductRepository {
  final NewProductSource newProductSource;

  NewProductRepositoryImpl(this.newProductSource);

  @override
  Future<Either<Failure, String>> addProduct(NewProductRequest request) async {
    final resul = await newProductSource.addProduct(request);
    try {
      return Right(resul);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> addCategoryBranch(
    NewCategoryAndBrandRequest request,
  ) async {
    final resul = await newProductSource.addCategoryRequest(request);
    try {
      return Right(resul);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, GetAllBrand>> getAllBrand(
    BrandGetAllRequest request,
  ) async {
    final resul = await newProductSource.getAllBrand(request);
    try {
      return Right(resul);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, GetAllCategory>> getAllCategories(
    BrandGetAllRequest request,
  ) async {
    final resul = await newProductSource.getCategories(request);
    try {
      return Right(resul);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> addBranch(
    NewCategoryAndBrandRequest request,
  ) async {
    final resul = await newProductSource.addBrandRequest(request);
    try {
      return Right(resul);
    } catch (e) {
      rethrow;
    }
  }
}
