

import 'package:dio/dio.dart';

import '../../../../../core/app_constante/app_constante.dart';
import '../../../praduct/data/product_request/get_all_brand_request.dart';
import '../../../praduct/data/product_response/get_all_brend_request.dart';
import '../../../praduct/data/product_response/get_all_cetagory.dart';
import '../new_praduct_request/new_brands.dart';
import '../new_praduct_request/new_product_request.dart';

abstract class NewProductSource{
  Future<String> addProduct(NewProductRequest request);
  Future<String> addCategoryRequest(NewCategoryAndBrandRequest request);
  Future<String> addBrandRequest(NewCategoryAndBrandRequest request);
  Future<GetAllBrand> getAllBrand(BrandGetAllRequest request);
  Future<GetAllCategory> getCategories(BrandGetAllRequest request);


}
class NewProductSourceImpl extends NewProductSource{
  final Dio _dio;

  NewProductSourceImpl(this._dio);

  @override
  Future<String> addProduct(NewProductRequest request)async {
    try {

      final response = await _dio.post(
        AppConstants.ADD_PRODUCT,
        data: request.toJson(),
      );

      return response.statusCode.toString();
    } catch (e) {
      print("fetchBanners DioException: $e");
      rethrow;
    }
  }

  @override
  Future<String> addCategoryRequest(NewCategoryAndBrandRequest request) async{
    try {

      final response = await _dio.post(
        AppConstants.ADD_CATEGORIES,
        data: request.toJson(),
      );

      return response.statusCode.toString();
    } catch (e) {
      print("fetchBanners DioException: $e");
      rethrow;
    }
  }

  @override
  Future<GetAllBrand> getAllBrand(BrandGetAllRequest request) async{
    try {

      final response = await _dio.get(
        AppConstants.GET_BRAND,
        queryParameters: request.toJson(),
      );

      final result = GetAllBrand.fromJson(response.data);
      return result;
    } catch (e) {
      print("fetchBanners DioException: $e");
      rethrow;
    }
  }

  @override
  Future<GetAllCategory> getCategories(BrandGetAllRequest request) async{
    try {

      final response = await _dio.get(
        AppConstants.GET_CATEGORIES,
        queryParameters: request.toJson(),
      );

      final result = GetAllCategory.fromJson(response.data);
      return result;
    } catch (e) {
      print("fetchBanners DioException: $e");
      rethrow;
    }
  }

  @override
  Future<String> addBrandRequest(NewCategoryAndBrandRequest request) async{
    try {

      final response = await _dio.post(
        AppConstants.ADD_BRAND,
        data: request.toJson(),
      );

      return response.statusCode.toString();
    } catch (e) {
      print("fetchBanners DioException: $e");
      rethrow;
    }
  }


}