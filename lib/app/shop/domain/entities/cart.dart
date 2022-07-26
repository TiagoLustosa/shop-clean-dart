import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';

import 'cart_item.dart';

class Cart {
  final String userId;
  final List<CartItemResultModel> cartItemList;
  final double totalPrice;
  final int totalItems;

  Cart({
    required this.userId,
    required this.cartItemList,
    required this.totalPrice,
    required this.totalItems,
  });
}
