import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/injector.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/user_data_local_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_event.dart';
import 'package:shop_clean_arch/app/shop/utils/app_routes.dart';
import '../../../infra/models/product_result_model.dart';

class ProductGridItem extends StatelessWidget {
  final ProductResultModel? product;

  AuthResultModel getUserId() {
    final prefs = injector.get<SharedPreferences>();
    final authResult = prefs.getString('userLogged');
    final json = jsonDecode(authResult!);
    AuthResultModel auth = AuthResultModel(
        localId: json['userId'], idToken: json['token'], email: json['email']);

    return auth;
  }

  const ProductGridItem({super.key, this.product});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: const Icon(Icons.favorite),
              color: Colors.pink,
              onPressed: () {
                getUserId();
              },
            ),
            title: Text(
              product!.name!,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).colorScheme.surface,
              onPressed: () => BlocProvider.of<CartBloc>(context).add(
                AddOrUpdateCart(
                    product!,
                    injector
                        .get<IUserDataLocalDataSource>()
                        .getUserLocalData()
                        .localId!),
              ),
              // onPressed: () {
              //   cart.addItem(product);
              //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text('Produto adicionado com sucesso!'),
              //       duration: Duration(seconds: 2),
              //       action: SnackBarAction(
              //         label: 'DESFAZER',
              //         onPressed: () {
              //           cart.removeSingleItem(state.product!.id);
              //         },
              //       ),
              //     ),
              //   );
              // },
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.productDetail,
                arguments: product,
              );
            },
            child: Image.network(
              product!.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
