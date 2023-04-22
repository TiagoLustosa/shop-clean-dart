import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';

class Cart {
  final List<CartItemResultModel>? cartItemList;
  final double? totaPrice;
  final int? totalItems;

  Cart({this.cartItemList, this.totaPrice, this.totalItems});

  static double calculatePrice(List<CartItemResultModel> cartItemList) {
    final double price = cartItemList.fold<double>(
        0,
        (previousValue, element) =>
            previousValue + (element.quantity * element.price));
    return double.parse(price.toStringAsFixed(2));
  }
}
