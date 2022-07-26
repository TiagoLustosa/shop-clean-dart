import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';
import 'package:shop_clean_arch/app/shop/infra/models/order_item_result_model.dart';

abstract class ICreateOrderUseCase implements UseCase<OrderItem, OrderItem> {
  @override
  Future<Either<Exception, OrderItem>> call(OrderItem order, {String? userId});
}
