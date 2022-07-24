import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/cart_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';

@Injectable(as: ICartDataSource)
class FirebaseCartDatasource implements ICartDataSource {
  final Dio _dio;

  FirebaseCartDatasource(this._dio);
  @override
  Future<Cart?> getCart(String userId) async {
    final result = await _dio.get('$cartBaseURL/$userId.json');
    if (result.statusCode == 200) {
      final cartItemList = (result.data as Map<String, dynamic>)
          .map((key, value) {
            value['id'] = key;
            return MapEntry(key, CartItemResultModel.fromJson(value));
          })
          .values
          .toList();
      return Cart(userId: userId, cartItemList: cartItemList);
    } else {
      throw CartDataSourceException(message: 'Error while trying to get cart');
    }
  }

  @override
  Future<Cart> addToCart(CartItemResultModel cartItem, String userId) async {
    final result = await _dio.put('$cartBaseURL/$userId/${cartItem.id}.json',
        data: jsonEncode(cartItem));
    if (result.statusCode == 200) {
      return Cart(
        userId: userId,
        cartItemList: [cartItem],
      );
    } else {
      throw CartDataSourceException(
          message: 'Error while trying to add to cart');
    }
  }

  @override
  Future<bool> removeFromCart(Product product) {
    // TODO: implement removeFromCart
    throw UnimplementedError();
  }

  @override
  Future<bool> clearCart() {
    // TODO: implement clearCart
    throw UnimplementedError();
  }
}
