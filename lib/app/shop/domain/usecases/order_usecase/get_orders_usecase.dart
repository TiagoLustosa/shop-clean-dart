import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/order_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/order_usecase/contracts/get_order_usecase_contract.dart';

@Injectable(as: IGetOrderUseCase)
class GetOrdersUseCase implements IGetOrderUseCase {
  final IOrderRepository _orderRepository;

  GetOrdersUseCase(this._orderRepository);
  @override
  Future<Either<Exception, List<OrderItem>>> call(String userId) async {
    final result = await _orderRepository.getOrders(userId);
    return result.fold(
      (l) => Left(l),
      (r) => Right(r),
    );
  }
}
