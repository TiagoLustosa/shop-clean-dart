import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/cart.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/cart_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/cart_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_item_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/models/cart_result_model.dart';
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
      return CartResultModel(
          userId: userId,
          cartItemList: cartItemList,
          totalItems: cartItemList.length,
          totalPrice: 0);
    } else {
      throw CartDataSourceException(message: 'Error while trying to get cart');
    }
  }

  @override
  Future<Cart> addToCart(CartItemResultModel cartItem, String userId) async {
    final result = await _dio.put('$cartBaseURL/$userId/${cartItem.id}.json',
        data: jsonEncode(cartItem));
    if (result.statusCode == 200) {
      return CartResultModel(
        userId: userId,
        cartItemList: [cartItem],
        totalItems: 1,
        totalPrice: cartItem.price,
      );
    } else {
      throw CartDataSourceException(
          message: 'Error while trying to add to cart');
    }
  }

  @override
  Future<bool> removeFromCart(String userId, String productId) async {
    final result = await _dio.delete('$cartBaseURL/$userId/$productId.json');
    if (result.statusCode == 200) {
      return true;
    } else {
      throw CartDataSourceException(
          message: 'Error while trying to remove from cart');
    }
  }

  @override
  Future<bool> clearCart(String userId) async {
    final result = await _dio.delete('$cartBaseURL/$userId.json');
    if (result.statusCode == 200) {
      return true;
    } else {
      throw CartDataSourceException(
          message: 'Error while trying to clear cart');
    }
  }
}
