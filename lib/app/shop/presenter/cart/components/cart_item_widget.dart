import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/injector.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart_item.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_event.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget(
    this.cartItem, {
    Key? key,
  }) : super(key: key);

  AuthResultModel getUserId() {
    final prefs = injector.get<SharedPreferences>();
    final authResult = prefs.getString('userLogged');
    final json = jsonDecode(authResult!);
    AuthResultModel auth = AuthResultModel(
        localId: json['userId'], idToken: json['token'], email: json['email']);

    return auth;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Tem Certeza?'),
            content: Text('Quer remover o item do carrinho?'),
            actions: [
              TextButton(
                child: Text('Não'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text('Sim'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        BlocProvider.of<CartBloc>(context).add(RemoveFromCart(
          cartItem.id,
          getUserId().userId.toString(),
        ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.name!),
            subtitle: Text(
                'Total: R\$ ${(cartItem.price! * cartItem.quantity!).toStringAsFixed(2)}'),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}
