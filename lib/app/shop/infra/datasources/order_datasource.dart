import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:shop_clean_arch/app/shop/infra/models/order_item_result_model.dart';

abstract class IOrderDataSource {
  Future<List<OrderItem>> getOrders(String userId);
  Future<OrderItem> createOrder(OrderItem orderItem, String userId);
}
