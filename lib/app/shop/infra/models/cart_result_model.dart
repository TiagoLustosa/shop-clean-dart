import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';

class CartResultModel extends Cart {
  final String userId;
  final List<CartItemResultModel> cartItemList;
  final double? totalPrice;
  final int? totalItems;

  CartResultModel({
    required this.userId,
    required this.cartItemList,
    required this.totalPrice,
    required this.totalItems,
  });

  get totalPriceValue => cartItemList.fold<double>(
        0.0,
        (previousValue, element) =>
            previousValue + (element.price! * element.quantity!),
      );

  factory CartResultModel.fromJson(Map<String, dynamic> json) {
    return CartResultModel(
      userId: 'userIdAqui',
      cartItemList: (json['name'] as List)
          .map((e) => CartItemResultModel.fromJson(e))
          .toList(),
      totalPrice: json['totalPrice'] ?? 0,
      totalItems: json['totalItems'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'cartItemList': cartItemList.map((i) => i.toJson()).toList(),
      'totalPrice': totalPrice,
      'totalItems': totalItems,
    };
  }
}
