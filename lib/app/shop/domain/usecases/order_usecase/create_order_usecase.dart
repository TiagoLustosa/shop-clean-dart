import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/order_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/order_usecase/contracts/create_order_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/infra/models/order_item_result_model.dart';

@Injectable(as: ICreateOrderUseCase)
class CreateOrderUseCase implements ICreateOrderUseCase {
  final IOrderRepository _orderRepository;

  CreateOrderUseCase(this._orderRepository);
  @override
  Future<Either<Exception, OrderItem>> call(OrderItem order,
      {String? userId}) async {
    final result = await _orderRepository.createOrder(order, userId!);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
