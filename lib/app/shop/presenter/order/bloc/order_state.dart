part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderError extends OrderState {
  final Exception message;

  OrderError(this.message);

  @override
  List<Object> get props => [message];
}

class OrderSuccess extends OrderState {
  final List<OrderItem> orderList;

  OrderSuccess(this.orderList);

  @override
  List<Object> get props => [orderList];
}

class OrderCreatedSuccess extends OrderState {
  final OrderItem orderItem;
  OrderCreatedSuccess(this.orderItem);
}
