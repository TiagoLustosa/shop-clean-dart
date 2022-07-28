import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/order_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/order_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/order_item_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';

@Injectable(as: IOrderDataSource)
class FirebaseOrderDataSource implements IOrderDataSource {
  final Dio _dio;

  FirebaseOrderDataSource(this._dio);
  @override
  Future<List<OrderItem>> getOrders(String userId) async {
    final result = await _dio.get('$orderBaseURL/$userId.json');
    if (result.statusCode == 200) {
      return (result.data as Map<String, dynamic>)
          .map((key, value) {
            value['id'] = key;
            return MapEntry(key, OrderItemResultModel.fromJson(value));
          })
          .values
          .toList();
    } else {
      throw OrderDataSourceException(
          message: 'Error while trying to get orders');
    }
  }

  @override
  Future<OrderItem> createOrder(OrderItem orderItem, String userId) async {
    orderItem as OrderItemResultModel;
    final result =
        await _dio.post('$orderBaseURL/$userId.json', data: orderItem.toJson());
    if (result.statusCode == 200) {
      return orderItem;
    } else {
      throw OrderDataSourceException(
          message: 'Error while trying to create order');
    }
  }
}
