import 'package:shop_clean_arch/app/shop/domain/entities/cart_item.dart';

class CartItemResultModel extends CartItem {
  final String? id;
  final String? name;
  final int? quantity;
  final double? price;

  CartItemResultModel({
    this.id,
    this.name,
    this.quantity,
    this.price,
  });

  factory CartItemResultModel.fromJson(Map<String, dynamic> json) {
    return CartItemResultModel(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
