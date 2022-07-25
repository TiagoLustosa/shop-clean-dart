import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/product_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';
import '../../domain/entities/product.dart';

@Injectable(as: IProductDataSource)
class FirebaseProductDataSource implements IProductDataSource {
  final Dio dio;
  final SharedPreferences _sharedPreferences;
  FirebaseProductDataSource(this.dio, this._sharedPreferences);

  String _token() {
    final authResult = _sharedPreferences.getString('userLogged');
    final json = jsonDecode(authResult!);
    if (json['token'] != null) {
      return json['token'];
    }
    throw ProductDataSourceException(message: 'Auth Token not found');
  }

  @override
  Future<ProductResultModel> getProduct(String id) async {
    final response =
        await dio.get('$productBaseURL/$id.json?auth=${_token().toString()}');
    if (response.statusCode == 200) {
      return ProductResultModel.fromJson(response.data);
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to get product with id $id');
    }
  }

  @override
  Future<List<ProductResultModel>> getAllProducts() async {
    final response =
        await dio.get('$productBaseURL.json?auth=${_token().toString()}');
    if (response.statusCode == 200) {
      return (response.data as Map<String, dynamic>)
          .map((key, value) {
            value['id'] = key;
            return MapEntry(key, ProductResultModel.fromJson(value));
          })
          .values
          .toList();
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to get all products');
    }
  }

  @override
  Future<Product> addProduct(ProductResultModel product) async {
    final response = await dio.post(
        '$productBaseURL.json?auth${_token().toString()}',
        data: jsonEncode(product.toJson()));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to add product');
    }
  }

  @override
  Future<ProductResultModel> updateProduct(ProductResultModel product) async {
    final response = await dio.put(
        '$productBaseURL/${product.id}.json?auth$_token',
        data: jsonEncode(product.toJson()));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to update product');
    }
  }

  @override
  Future<ProductResultModel> favoriteProduct(int id) {
    // TODO: implement favoriteProduct
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteProduct(String id) async {
    final response =
        await dio.delete('$productBaseURL/$id.json?auth${_token().toString()}');
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to delete product with id $id');
    }
  }
}
