import 'package:equatable/equatable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  final Exception error;

  const CartError(this.error);
}

class CartSuccess extends CartState {
  final Cart cart;

  const CartSuccess(this.cart);

  @override
  List<Object> get props => [cart];
}

class CartItemRemovedSuccess extends CartState {
  final bool isSuccess;
  const CartItemRemovedSuccess(this.isSuccess);

  @override
  List<Object> get props => [isSuccess];
}
