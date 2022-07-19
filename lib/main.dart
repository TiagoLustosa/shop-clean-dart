import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/shop/infra/dependency_injection/dependency_injection_config.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/components/product_detail_page.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/components/product_grid.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/pages/products_overview_page.dart';
import 'app/shop/presenter/auth/bloc/auth_bloc.dart';
import 'app/shop/presenter/auth/pages/auth_page.dart';
import 'app/shop/presenter/products_list/bloc/bloc/products_list_bloc.dart';

void main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>(),
          child: const AuthPage(),
        ),
        BlocProvider<AuthBloc>(
            create: (_) => getIt<AuthBloc>(),
            child: const ProductOverViewPage()),
        BlocProvider<ProductsListBloc>(
            create: (_) => getIt<ProductsListBloc>(),
            child: const ProductOverViewPage()),
        BlocProvider<ProductsListBloc>(
            create: (_) => getIt<ProductsListBloc>(),
            child: const ProductGrid()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            background: Colors.black,
            onBackground: Colors.white,
            primary: Colors.indigo[900]!,
            onPrimary: Colors.white,
            secondary: Colors.black87,
            onSecondary: Colors.white,
            error: Colors.red[900]!,
            onError: Colors.white70,
            surface: Colors.orange,
            onSurface: Colors.indigo[900]!,
          ),
          textTheme: const TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: AuthPage(),
        routes: {
          '/detail': (context) => const ProductDetailPage(),
          '/products': (context) => const ProductOverViewPage(),
        },
      ),
    );
  }
}
