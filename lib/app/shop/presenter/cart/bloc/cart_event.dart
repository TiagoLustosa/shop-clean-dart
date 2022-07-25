import 'package:equatable/equatable.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddOrUpdateCart extends CartEvent {
  final ProductResultModel product;
  final String userId;

  AddOrUpdateCart(this.product, this.userId);

  @override
  List<Object> get props => [product];
}

class GetFromCart extends CartEvent {
  final String userId;

  GetFromCart(this.userId);

  @override
  List<Object> get props => [userId];
}

class RemoveFromCart extends CartEvent {
  final String userId;
  final String productId;

  RemoveFromCart(this.userId, this.productId);

  @override
  List<Object> get props => [userId, productId];
}
