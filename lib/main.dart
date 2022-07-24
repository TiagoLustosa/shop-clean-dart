import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/pages/cart_page.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/components/product_detail_page.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/components/product_grid.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/components/product_grid_item.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/pages/products_page.dart';
import 'package:shop_clean_arch/app/shop/presenter/product/pages/products_overview_page.dart';
import 'package:shop_clean_arch/app/shop/utils/app_routes.dart';
import 'app/injector.dart';
import 'app/shop/presenter/auth/bloc/auth_bloc.dart';
import 'app/shop/presenter/auth/pages/auth_page.dart';
import 'app/shop/presenter/product/bloc/product_bloc.dart';
import 'app/shop/presenter/product/pages/product_form_page.dart';
import 'app/shop/presenter/products_list/bloc/bloc/products_list_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => injector<AuthBloc>(),
          child: const AuthPage(),
        ),
        BlocProvider<ProductsListBloc>(
            create: (_) => injector<ProductsListBloc>(),
            child: const ProductOverViewPage()),
        BlocProvider<ProductsListBloc>(
            create: (_) => injector<ProductsListBloc>(),
            child: const ProductGrid()),
        BlocProvider<ProductBloc>(
            create: (_) => injector<ProductBloc>(),
            child: const ProductFormPage()),
        BlocProvider<CartBloc>(
            create: (_) => injector<CartBloc>(),
            child: const ProductGridItem()),
        BlocProvider<CartBloc>(
          create: (_) => injector<CartBloc>(),
          child: const CartPage(),
        ),
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
        // home: ProductOverViewPage(),
        routes: {
          AppRoutes.authOrHome: (context) => const ProductOverViewPage(),
          AppRoutes.productDetail: (context) => const ProductDetailPage(),
          AppRoutes.products: (context) => const ProductsPage(),
          AppRoutes.productForm: (context) => const ProductFormPage(),
          AppRoutes.cart: (context) => const CartPage(),
        },
      ),
    );
  }
}
