import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';

abstract class IOrderDataSource {
  Future<List<OrderItem>> getOrders(String userId);
  Future<OrderItem> createOrder(OrderItem orderItem);
}
