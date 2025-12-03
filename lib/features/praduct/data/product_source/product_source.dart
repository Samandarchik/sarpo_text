import 'package:dio/dio.dart';
import 'package:untitled7/core/app_constante/app_constante.dart';

import '../../../new_product/data/new_praduct_request/new_brands.dart';
import '../../../new_product/data/new_praduct_request/new_product_request.dart';
import '../product_request/edite_product_request.dart';
import '../product_request/get_all_brand_request.dart';
import '../product_response/get_all_brend_request.dart';
import '../product_request/product_delete.dart';
import '../product_response/product_request.dart';
import '../product_request/product_response.dart';

abstract class ProductSource {
  Future<String> addProduct(NewProductRequest request);
  Future<String> addCategoryRequest(NewCategoryAndBrandRequest request);

  Future<ProductsResponse> getAllProduct(ProductGetAllRequest request);
  Future<String> deleteProductRequest(ProductDelete request);
  Future<String> editeProduct(EditeProductRequest request);
  Future<GetAllBrand> getAllBrand(BrandGetAllRequest request);


}

class ProductSourceImpl extends ProductSource {
  final Dio _dio;

  ProductSourceImpl(this._dio);

  @override
  Future<ProductsResponse> getAllProduct(
      ProductGetAllRequest request,
      ) async {
    try {

      final response = await _dio.get(
        AppConstants.GET_PRODUCT,
        queryParameters: request.toQueryParameters(),
      );

      final result = ProductsResponse.fromJson(response.data);
      return result;
    } catch (e) {
      print("fetchBanners DioException: $e");
      rethrow;
    }
  }

  @override
  Future<String> deleteProductRequest(ProductDelete request) async{
    try {
      final response = await _dio.delete(AppConstants.DELETE_PRODUCT,
      queryParameters: {'id':request.id});


      return response.statusCode.toString();
    } catch (e) {
      print("fetchBanners DioException: $e");
      rethrow;
    }
  }



  @override
  Future<String> editeProduct(EditeProductRequest request) async {
    try {
      final Map<String, dynamic> requestBody = request.toJson();
      print("1. editeProduct boshlandi");
      final int productId = request.id;
      requestBody.remove('id');
      final response = await _dio.put(
        AppConstants.UPDATE_PRODUCT,
        queryParameters: {
          'id': productId,
        },
        data: requestBody,
      );
      print("2. Server javobi: ${response.statusCode}");

      return response.statusCode.toString();

    } catch (e) {


      rethrow;
    }
  }

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
        AppConstants.GET_PRODUCT,
        queryParameters: request.toJson(),
      );

      final result = GetAllBrand.fromJson(response.data);
      return result;
    } catch (e) {
      print("fetchBanners DioException: $e");
      rethrow;
    }
  }


}
