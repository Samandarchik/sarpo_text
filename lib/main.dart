import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/data/network/service_locator.dart' hide setupLocator;
import 'package:untitled7/pesination/praduct/chaild_new_product/domain/product_repository/product_repository.dart';
import 'package:untitled7/pesination/praduct/chaild_new_product/presintation/bloc/child_bloc.dart';
import 'package:untitled7/pesination/praduct/home.dart';
import 'package:untitled7/pesination/praduct/new_product/domain/repositery/new_product_repository.dart';
import 'package:untitled7/pesination/praduct/new_product/presintation/bloc/new_product_bolc.dart';
import 'package:untitled7/pesination/praduct/praduct/domain/product_repository/product_repository.dart';
import 'package:untitled7/pesination/praduct/praduct/presintation/bloc/product_bloc.dart';

import 'package:untitled7/pesination/praduct/servis_locator_sarpo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await setupLocator();

    print("✅ Dependencies muvaffaqiyatli yuklandi");

    runApp(const MyApp());
  } catch (e, s) {

  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => NewProductsScreenBloc(
            getIt<NewProductRepository>(),
          ),

        ),
        BlocProvider(
          create: (_) => ProductsScreenBloc(
            getIt<ProductRepository>(),
          ),

        ),
        BlocProvider(
          create: (_) => ChildProductsScreenBloc(
            getIt<ChildProductRepository>(),
          ),

        ),


      ], child: HomeScreen())
    );
  }
}