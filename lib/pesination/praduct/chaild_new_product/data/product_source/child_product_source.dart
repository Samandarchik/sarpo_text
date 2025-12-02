import 'package:dio/dio.dart';
import 'package:untitled7/core/app_constante/app_constante.dart';

import '../product_request/add_child_product.dart';
import '../product_request/child_product_delete.dart';
import '../product_request/child_product_request.dart';
import '../product_request/get_all.dart';
import '../product_response/product_response.dart';

abstract class ChildProductSource {
  Future<List<ChildProductGetAllRequest>> getAllProduct(int request);
  Future<ProductAndChildGetAllDate> getAllChild(int request);
  Future<String> deleteProductRequest(ChildProductDelete request);
  Future<String> editeProduct(ChildProductAddRequest request,int id);
  Future<String> addChildProduct(ChildProductAddRequest request);


}

class ChildProductSourceImpl extends ChildProductSource {
  final Dio _dio;

  ChildProductSourceImpl(this._dio);

  @override
  Future<List<ChildProductGetAllRequest>> getAllProduct(
      int request,
      ) async {
    try {
      final response = await _dio.get(
        AppConstants.GET_PRODUCT_CHILD,
        queryParameters: {
          "product_id":request
        },
      );


      if (response.statusCode == 200) {
        final List<dynamic>? responseData = response.data;

        if (responseData is List) {
          final List<ChildProductGetAllRequest> productList = responseData
              .map((jsonItem) => ChildProductGetAllRequest.fromJson(jsonItem))
              .toList();

          return productList;
        } else {

          return [];
        }
      } else {
        throw Exception("Mahsulotlarni yuklashda xatolik yuz berdi. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("fetchProducts DioException: $e");
      rethrow;
    }
  }

  @override
  Future<String> deleteProductRequest(ChildProductDelete request) async{
    try {
      final response = await _dio.delete(AppConstants.CHILD_DELETE_PRODUCT,
      queryParameters: {'id':request.id});


      return response.statusCode.toString();
    } catch (e) {
      print("fetchBanners DioException: $e");
      rethrow;
    }
  }



  @override
  Future<String> editeProduct(ChildProductAddRequest request,int id) async {
    try {


      final response = await _dio.put(
        AppConstants.CHILD_UPDATE_PRODUCT,
        queryParameters: {
          'id': id,
        },
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print("2. Server javobi: ${response.statusCode}");

      return response.statusCode.toString();

    } catch (e) {


      rethrow;
    }
  }

  @override
  Future<String> addChildProduct(ChildProductAddRequest request)async {
   try{
     final response = await _dio.post(
       AppConstants.CHILD_ADD_PRODUCT,
       data: request.toJson()
     );
     return response.statusCode.toString();
   }catch(e){
     rethrow;
   }
  }

  @override
  Future<ProductAndChildGetAllDate> getAllChild(int request) async {
    try {
      final response = await _dio.get(
        AppConstants.GET_PRODUCT_All,
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;

        final ProductAndChildGetAllDate data =
        ProductAndChildGetAllDate.fromJson(responseData);

        return data;
      } else {
        throw Exception(
            "Mahsulotlarni yuklashda xatolik yuz berdi. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("fetchProducts DioException: $e");
      rethrow;
    }
  }


}
