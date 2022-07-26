import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/order_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/order_repository.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/order_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/order_item_result_model.dart';

@Injectable(as: IOrderRepository)
class OrderRepository implements IOrderRepository {
  final IOrderDataSource _orderDataSource;

  OrderRepository(this._orderDataSource);
  @override
  Future<Either<Exception, List<OrderItem>>> getOrders(String userId) async {
    try {
      final result = await _orderDataSource.getOrders(userId);
      return Right(result);
    } on IOrderExceptions catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderDataSourceException(message: e.toString()));
    }
  }

  @override
  Future<Either<Exception, OrderItemResultModel>> createOrder(
      OrderItem orderItem, String userId) async {
    try {
      final result = await _orderDataSource.createOrder(orderItem, userId);
      return Right(result as OrderItemResultModel);
    } on IOrderExceptions catch (e) {
      return Left(e);
    } catch (e) {
      return Left(OrderDataSourceException(message: e.toString()));
    }
  }
}
