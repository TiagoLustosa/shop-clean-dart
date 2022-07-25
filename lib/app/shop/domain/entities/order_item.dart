import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';

class OrderItem {
  final String? id;
  final double? total;
  final List<CartItemResultModel>? cartItemList;
  final DateTime? date;

  OrderItem({
    this.id,
    this.total,
    this.cartItemList,
    this.date,
  });
}
