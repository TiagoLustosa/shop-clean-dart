import 'cart_item.dart';

class Cart {
  final String? userId;
  final List<CartItem>? cartItemList;
  final double? totalPrice;
  final int? totalItems;

  Cart({
    this.userId,
    this.cartItemList,
    this.totalPrice,
    this.totalItems,
  });
}
