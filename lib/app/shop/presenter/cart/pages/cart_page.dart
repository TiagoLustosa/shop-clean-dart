import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/injector.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/user_data_local_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/order_item_result_model.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_event.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_state.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/components/cart_item_widget.dart';
import 'package:shop_clean_arch/app/shop/presenter/order/bloc/order_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartItemRemovedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Item removido com sucesso!'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          bloc: BlocProvider.of<CartBloc>(context)
            ..add(GetFromCart(injector<IUserDataLocalDataSource>()
                .getUserLocalData()
                .localId!)),
          builder: (context, state) => Column(
            children: [
              if (state is CartLoading)
                const Center(
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
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
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
                      const Spacer(),
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
                    itemCount: state.cart.cartItemList.length,
                    itemBuilder: (context, index) => CartItemWidget(
                      state.cart.cartItemList[index],
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
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : TextButton(
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: widget.cart.cartItemList.isEmpty
                ? null
                : () async {
                    setState(() => _isLoading = true);
                    // injector<CartBloc>().add(ClearCart(
                    //   injector<IUserDataLocalDataSource>()
                    //       .getUserLocalData()
                    //       .localId!,
                    // ));
                    injector<OrderBloc>().add(
                      CreateOrder(
                        OrderItemResultModel(
                            date: DateTime.now(),
                            cartItemList: widget.cart.cartItemList,
                            total: widget.cart.cartItemList.fold<double>(
                                0,
                                (previousValue, element) =>
                                    previousValue +
                                    (element.quantity * element.price))),
                        injector<IUserDataLocalDataSource>()
                            .getUserLocalData()
                            .localId!,
                      ),
                    );

                    // widget.cart.clear();
                    setState(() => _isLoading = false);
                  },
            child: const Text('COMPRAR'),
          );
  }
}
