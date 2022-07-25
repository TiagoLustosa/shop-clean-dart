import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/order_item.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/order_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/order_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/order_item_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';

@Injectable(as: IOrderDataSource)
class FirebaseOrderDataSource implements IOrderDataSource {
  final Dio _dio;
  final SharedPreferences _sharedPreferences;
  String _token() {
    final authResult = _sharedPreferences.getString('userLogged');
    final json = jsonDecode(authResult!);
    if (json['token'] != null) {
      return json['token'];
    }
    throw OrderDataSourceException(message: 'Auth Token not found');
  }

  FirebaseOrderDataSource(this._dio, this._sharedPreferences);
  @override
  Future<List<OrderItem>> getOrders(String userId) async {
    final result = await _dio
        .get('$orderBaseURL/$userId.json?auth=${_token().toString()}');
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
  Future<OrderItem> createOrder(OrderItem orderItem) {
    // TODO: implement createOrder
    throw UnimplementedError();
  }
}
