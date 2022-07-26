import 'package:equatable/equatable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_result_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  final Exception error;

  CartError(this.error);
}

class CartSuccess extends CartState {
  final Cart cart;

  CartSuccess(this.cart);

  @override
  List<Object> get props => [cart];
}

class CartItemRemovedSuccess extends CartState {
  final bool isSuccess;
  CartItemRemovedSuccess(this.isSuccess);

  @override
  List<Object> get props => [isSuccess];
}
