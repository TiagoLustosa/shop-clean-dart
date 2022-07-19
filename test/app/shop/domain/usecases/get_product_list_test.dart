import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/auth_credentials.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/product_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/product_usecases/get_product.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/product_usecases/get_products_list.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';

import '../../utils/firebase_response.dart';

class ProductRepositoryMock extends Mock implements IProductRepository {}

void main() {
  final productRepositoryMock = ProductRepositoryMock();
  final sut = GetProductsListUseCase(productRepositoryMock);
  setUp(() {
    registerFallbackValue(AuthCredentials());
  });

  test('should return a list of products', () async {
    when(() => productRepositoryMock.getAllProducts()).thenAnswer(
        (_) async => Right(<ProductResultModel>[ProductResultModel()]));

    final result = await sut(NoParams());
    final actual = result.fold(id, id);
    expect(actual, isA<List<ProductResultModel>>());
    verify(() => productRepositoryMock.getAllProducts()).called(1);
  });

  test('should return an exception when product is invalid', () async {
    when(() => productRepositoryMock.getAllProducts()).thenAnswer(
        (_) async => Left(ProductDataSourceException(message: 'Error')));

    var result = await sut(NoParams());
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<ProductDataSourceException>());
  });

  test('should return a list of products', () async {
    final resultListFromSource = jsonDecode(fireBaseResponseList) as List;
    final resultList = resultListFromSource
        .map((item) => ProductResultModel.fromJson(item))
        .toList();
    when(() => productRepositoryMock.getAllProducts())
        .thenAnswer((_) async => Right(resultList));
    final result = await sut(NoParams());
    final actual = result.fold(id, id);
    expect(result.isRight(), true);
    expect(actual, isA<List<ProductResultModel>>());
    verify(() => productRepositoryMock.getAllProducts()).called(1);
  });
}
