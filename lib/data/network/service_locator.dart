import 'package:get_it/get_it.dart';
import 'package:untitled7/data/network/dio_settings.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  serviceLocator.registerLazySingleton(() => DioSettings());
}
