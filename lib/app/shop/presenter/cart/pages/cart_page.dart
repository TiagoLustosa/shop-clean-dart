import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/injector.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart_item.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/get_from_cart_usecase.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/models/order_item_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_event.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_state.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/components/cart_item_widget.dart';
import 'package:shop_clean_arch/app/shop/presenter/order/bloc/order_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  AuthResultModel getUserId() {
    final prefs = injector.get<SharedPreferences>();
    final authResult = prefs.getString('userLogged');
    final json = jsonDecode(authResult!);
    AuthResultModel auth = AuthResultModel(
        userId: json['userId'], token: json['token'], email: json['email']);

    return auth;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartItemRemovedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Item removido com sucesso!'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          bloc: BlocProvider.of<CartBloc>(context)
            ..add(GetFromCart(getUserId().userId.toString())),
          builder: (context, state) => Column(
            children: [
              if (state is CartLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
              Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 25,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Chip(
                        backgroundColor: Theme.of(context).primaryColor,
                        label: Text(
                          (state is CartSuccess)
                              ? 'R\$${state.cart.cartItemList.fold<double>(0, (previousValue, element) => previousValue + (element.quantity * element.price)).toStringAsFixed(2)}'
                              : 'R\$0,00',
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                ?.color,
                          ),
                        ),
                      ),
                      Spacer(),
                      (state is CartSuccess)
                          ? CartButton(cart: state.cart)
                          : Container(),
                    ],
                  ),
                ),
              ),
              if (state is CartSuccess)
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cart.cartItemList!.length,
                    itemBuilder: (context, index) => CartItemWidget(
                      state.cart.cartItemList![index],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;
  AuthResultModel getUserId() {
    final prefs = injector.get<SharedPreferences>();
    final authResult = prefs.getString('userLogged');
    final json = jsonDecode(authResult!);
    AuthResultModel auth = AuthResultModel(
        userId: json['userId'], token: json['token'], email: json['email']);

    return auth;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : TextButton(
            child: Text('COMPRAR'),
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: widget.cart.cartItemList!.isEmpty
                ? null
                : () async {
                    setState(() => _isLoading = true);

                    BlocProvider.of<OrderBloc>(
                      context,
                    ).add(
                      CreateOrder(
                        OrderItemResultModel(
                            date: DateTime.now(),
                            cartItemList: widget.cart.cartItemList,
                            total: widget.cart.cartItemList.fold<double>(
                                0,
                                (previousValue, element) =>
                                    previousValue +
                                    (element.quantity * element.price))),
                        getUserId().userId.toString(),
                      ),
                    );

                    // widget.cart.clear();
                    setState(() => _isLoading = false);
                  },
          );
  }
}
