import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';

abstract class IOrderRepository {
  Future<Either<Exception, List<OrderItem>>> getOrders(String userId);
  Future<Either<Exception, OrderItem>> createOrder(
      OrderItem orderItem, String userId);
}
