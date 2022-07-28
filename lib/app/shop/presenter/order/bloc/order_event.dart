part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class GetOrders extends OrderEvent {
  final String userId;

  const GetOrders(this.userId);

  @override
  List<Object> get props => [userId];
}

class CreateOrder extends OrderEvent {
  final OrderItemResultModel orderItem;
  final String userId;

  const CreateOrder(this.orderItem, this.userId);

  @override
  List<Object> get props => [orderItem];
}
