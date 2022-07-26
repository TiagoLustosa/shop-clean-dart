import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/product_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/rest_client/rest_client.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';
import '../../domain/entities/product.dart';

@Injectable(as: IProductDataSource)
class FirebaseProductDataSource implements IProductDataSource {
  final IRestClient _restClient;

  FirebaseProductDataSource(this._restClient);
  @override
  Future<ProductResultModel> getProduct(String id) async {
    final response =
        await _restClient.instance().get('$productBaseURL/$id.json');
    if (response.statusCode == 200) {
      return ProductResultModel.fromJson(response.data);
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to get product with id $id');
    }
  }

  @override
  Future<List<ProductResultModel>> getAllProducts() async {
    final response = await _restClient.instance().get('$productBaseURL.json');
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
    final response = await _restClient
        .instance()
        .post('$productBaseURL.json', data: jsonEncode(product.toJson()));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to add product');
    }
  }

  @override
  Future<ProductResultModel> updateProduct(ProductResultModel product) async {
    final response = await _restClient.instance().put(
        '$productBaseURL/${product.id}.json',
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
    final response = await _restClient.instance().delete(
          '$productBaseURL/$id.json',
        );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to delete product with id $id');
    }
  }
}
