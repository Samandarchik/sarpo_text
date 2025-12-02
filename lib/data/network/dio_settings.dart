import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class DioSettings {
  Dio createDio({required String baseUrl, String? lang}) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(milliseconds: 35000),
      receiveTimeout: const Duration(milliseconds: 33000),
      followRedirects: false,
      validateStatus: (status) => status != null && status <= 500,
    );

    final dio = Dio(options);

    dio.interceptors.add(LogInterceptor(request: true, requestHeader: true, requestBody: true, responseBody: true,));
    return dio;
  }
}


class DioNetwork {
  static late Dio dio;
  final FlutterSecureStorage _secureStorage;

  DioNetwork(this._secureStorage);

  static void init(FlutterSecureStorage secureStorage) {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://45.92.173.46:5000/api/",
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        responseType: ResponseType.json,
      ),
    );

    final network = DioNetwork(secureStorage);
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: network._onRequest,
        onError: network._onError,
      ),
    );
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<void> _onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    if (options.path.contains('/login')) {
      return handler.next(options);
    }

    final token = await _secureStorage.read(key: 'accessToken');

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  void _onError(DioException error, ErrorInterceptorHandler handler) {
    if (error.response?.statusCode == 401) {
      () async {
        await _secureStorage.delete(key: 'accessToken');

        // navigatorKey.currentState?.pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (_) => const AuthScreen()),
        //       (route) => false,
        // );
      }();
    }

    final errorMessage = _getErrorMessage(error);

    debugPrint(errorMessage);

    handler.next(error.copyWith(message: errorMessage));
  }

  String _getErrorMessage(DioException error) {
    try {
      return error.response?.data['error'] ?? "Something went wrong";
    } catch (e) {
      return "Something went wrong";
    }
  }
}
final navigatorKey = GlobalKey<NavigatorState>();
