import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/auth_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/product_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/auth_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/utils/constants.dart';

import '../../infra/datasources/auth_datasource.dart';

class FirebaseDataSource implements IAuthDataSource, IProductDataSource {
  final Dio dio;

  FirebaseDataSource(this.dio);
  @override
  Future<AuthResultModel> authWithEmail(AuthCredentials credentials) async {
    final response = await dio.post(firebaseURL, data: {
      'email': credentials.email,
      'password': credentials.password,
      'returnSecureToken': true
    });
    if (response.statusCode == 200) {
      return AuthResultModel.fromMap(response.data);
    } else {
      throw AuthDataSourceException(
          message:
              'Error while trying to authenticate with email and password');
    }
  }

  @override
  Future<ProductResultModel> getProduct(String id) async {
    final response = await dio.get('$productBaseURL/$id.json');
    if (response.statusCode == 200) {
      return ProductResultModel.fromJson(response.data);
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to get product with id $id');
    }
  }

  @override
  Future<List<ProductResultModel>> getAllProducts() async {
    final response = await dio.get('$productBaseURL.json');
    if (response.statusCode == 200) {
      return (response.data as Map<String, dynamic>)
          .map(
              (key, value) => MapEntry(key, ProductResultModel.fromJson(value)))
          .values
          .toList();
    } else {
      throw ProductDataSourceException(
          message: 'Error while trying to get all products');
    }
  }

  @override
  Future<ProductResultModel> createProduct(ProductResultModel product) {
    // TODO: implement createProduct
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteProduct(int id) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductResultModel> favoriteProduct(int id) {
    // TODO: implement favoriteProduct
    throw UnimplementedError();
  }

  @override
  Future<ProductResultModel> updateProduct(ProductResultModel product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
