import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/cart_usecases/get_from_cart_usecase.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_bloc.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_event.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/bloc/cart_state.dart';
import 'package:shop_clean_arch/app/shop/presenter/cart/components/cart_item_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        bloc: BlocProvider.of<CartBloc>(context)
          ..add(GetFromCart('userIdAqui')),
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
                        // 'R\$${cart.totalAmount.toStringAsFixed(2)}'
                        "aaa",
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              ?.color,
                        ),
                      ),
                    ),
                    Spacer(),
                    // CartButton(cart: cart),
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
    );
  }
}

// class CartButton extends StatefulWidget {
//   const CartButton({
//     Key? key,
//     required this.cart,
//   }) : super(key: key);

//   final Cart cart;

//   @override
//   _CartButtonState createState() => _CartButtonState();
// }

// class _CartButtonState extends State<CartButton> {
//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return _isLoading
//         ? CircularProgressIndicator()
//         : TextButton(
//             child: Text('COMPRAR'),
//             style: TextButton.styleFrom(
//               textStyle: TextStyle(
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//             onPressed: widget.cart.itemsCount == 0
//                 ? null
//                 : () async {
//                     setState(() => _isLoading = true);

//                     await Provider.of<OrderList>(
//                       context,
//                       listen: false,
//                     ).addOrder(widget.cart);

//                     widget.cart.clear();
//                     setState(() => _isLoading = false);
//                   },
//           );
//   }
// }
