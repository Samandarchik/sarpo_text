import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled7/core/app_constante/app_constante.dart';
import 'package:untitled7/features/praduct/data/product_source/product_source.dart';
import 'package:untitled7/features/praduct/domain/product_repository/product_repository.dart';

import '../core/network/dio_settings.dart';
import 'chaild_new_product/data/product_source/child_product_source.dart';
import 'chaild_new_product/domain/product_repository/product_repository.dart';
import 'new_product/data/data_source/new_product_source.dart';
import 'new_product/domain/repositery/new_product_repository.dart';


final getIt = GetIt.instance;

Future<void> setupLocator() async {
  if (getIt.isRegistered<Dio>()) {
    await getIt.reset();
  }

  getIt.registerLazySingleton<DioSettings>(() => DioSettings());

  getIt.registerLazySingleton<Dio>(
        () => getIt<DioSettings>().createDio(
      baseUrl: AppConstants.BASE_URL,
    ),
  );

  getIt.registerLazySingleton<NewProductSource>(
        () => NewProductSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<NewProductRepository>(
        () => NewProductRepositoryImpl(getIt<NewProductSource>()),
  );

  getIt.registerLazySingleton<ProductSource>(
        () => ProductSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(getIt<ProductSource>()),
  );

  getIt.registerLazySingleton<ChildProductSource>(
        () => ChildProductSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ChildProductRepository>(
        () => ChildProductRepositoryImpl(getIt<ChildProductSource>()),
  );



}