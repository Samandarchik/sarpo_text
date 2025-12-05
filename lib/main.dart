import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'features/chaild_new_product/domain/product_repository/product_repository.dart';
import 'features/chaild_new_product/presintation/bloc/child_bloc.dart';

import 'features/home.dart';
import 'features/incoming_goods/domain/repository/repository_incoming_goods.dart';
import 'features/incoming_goods/presentation/bloc/IncomingGoods_bloc.dart';
import 'features/new_product/domain/repositery/new_product_repository.dart';
import 'features/new_product/presintation/bloc/new_product_bolc.dart';
import 'features/praduct/domain/product_repository/product_repository.dart';
import 'features/praduct/presintation/bloc/product_bloc.dart';



import 'features/servis_locator_sarpo.dart';

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

        BlocProvider(
          create: (_) => IncomingGoodsScreenBloc(
            getIt<IncomingGoodsRepository>(),
          ),

        ),


      ], child: HomeScreen())
    );
  }
}