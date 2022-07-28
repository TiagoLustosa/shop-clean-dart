import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/product_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';
import '../../domain/entities/product.dart';

@Injectable(as: IProductDataSource)
class FirebaseProductDataSource implements IProductDataSource {
  final Dio _dio;

  FirebaseProductDataSource(this._dio);
  @override
  Future<ProductResultModel> getProduct(String id) async {
    final response = await _dio.get('$productBaseURL/$id.json');
    if (response.statusCode == 200) {
      return ProductResultModel.fromJson(response.data);
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to get product with id $id');
    }
  }

  @override
  Future<List<ProductResultModel>> getAllProducts() async {
    final response = await _dio.get('$productBaseURL.json');
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
    final response = await _dio.post('$productBaseURL.json',
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
    final response = await _dio.put('$productBaseURL/${product.id}.json',
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
    final response = await _dio.delete(
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
