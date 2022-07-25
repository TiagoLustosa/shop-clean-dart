import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';

class OrderItemResultModel extends OrderItem {
  final String? id;
  final double? total;
  final List<CartItemResultModel>? cartItemList;
  final DateTime? date;

  OrderItemResultModel({
    required this.id,
    required this.total,
    required this.cartItemList,
    required this.date,
  });

// create from json
  factory OrderItemResultModel.fromJson(Map<String, dynamic> json) {
    return OrderItemResultModel(
      id: json['id'],
      total: json['total'],
      cartItemList: (json['cartItemList'] as List)
          .map((e) => CartItemResultModel.fromJson(e))
          .toList(),
      date: DateTime.parse(json['date']),
    );
  }

//create to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'total': total,
      'cartItemList': cartItemList!.map((i) => i.toJson()).toList(),
      'date': date!.toIso8601String(),
    };
  }
}
