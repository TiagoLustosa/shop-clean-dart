import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/order_usecase/contracts/create_order_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/order_usecase/contracts/get_order_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/infra/models/order_item_result_model.dart';
part 'order_event.dart';
part 'order_state.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IGetOrderUseCase _getOrdersUseCase;
  final ICreateOrderUseCase _createOrderUseCase;
  OrderBloc(this._getOrdersUseCase, this._createOrderUseCase)
      : super(OrderInitial()) {
    on<GetOrders>(getOrders);
    on<CreateOrder>(createOrder);
  }
  FutureOr<void> getOrders(GetOrders event, Emitter emit) async {
    emit(OrderLoading());
    final result = await _getOrdersUseCase(event.userId);
    return emit(result.fold(
      (l) => OrderError(l),
      (r) => OrderSuccess(r),
    ));
  }

  FutureOr<void> createOrder(CreateOrder event, Emitter emit) async {
    emit(OrderLoading());
    final result =
        await _createOrderUseCase(event.orderItem, userId: event.userId);
    return emit(result.fold(
      (l) => OrderError(l),
      (r) => OrderCreatedSuccess(r),
    ));
  }
}
