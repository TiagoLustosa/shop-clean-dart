import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/infra/datasources/product_datasource.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import 'package:shop_clean_arch/app/shop/infra/repositories/product_repository_implements.dart';

class ProductDataSourceMock extends Mock implements IProductDataSource {}

main() {
  final productDataSourceMock = ProductDataSourceMock();
  final productRepository = ProductRepositoryImplements(productDataSourceMock);

  setUp(() {
    registerFallbackValue(ProductResultModel());
  });
  test('should return a product result model', () async {
    when(() => productDataSourceMock.getProduct(any()))
        .thenAnswer((_) async => ProductResultModel());
    final result = await productRepository.getProduct('id');
    final actual = result.fold(id, id);
    expect(result.isRight(), true);
    expect(actual, isA<ProductResultModel>());
  });

  test('should return a exception', () async {
    when(() => productRepository.getProduct(any()))
        .thenAnswer((_) async => Right(ProductResultModel()));
    final result = await productRepository.getProduct('');
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<ProductDataSourceException>());
  });

  test('should return an list of productresultmodel ', () async {
    when(() => productDataSourceMock.getAllProducts())
        .thenAnswer((_) async => <ProductResultModel>[ProductResultModel()]);
    final result = await productRepository.getAllProducts();
    final actual = result.fold(id, id);
    expect(result.isRight(), true);
    expect(actual, isA<List<ProductResultModel>>());
  });

  test('should return a error ', () async {
    when(() => productDataSourceMock.getAllProducts())
        .thenThrow(ProductDataSourceException(message: 'Error'));
    final result = await productRepository.getAllProducts();
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<ProductDataSourceException>());
    //expect(actual, 'No products found');
  });

  test('should return an error when addProduct', () async {
    when(() => productDataSourceMock.addProduct(any())).thenThrow((_) async =>
        ProductDataSourceException(message: 'Error while adding product'));
    final result = await productRepository.addProduct(ProductResultModel());
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<ProductDataSourceException>());
  });

  test('should return a product when addProduct', () async {
    when(() => productDataSourceMock.addProduct(any()))
        .thenAnswer((_) async => Product());
    final result = await productRepository.addProduct(ProductResultModel());
    final actual = result.fold(id, id);
    expect(result.isRight(), true);
    expect(actual, isA<Product>());
  });

  test('should return a product when UpdateProduct', () async {
    when(() => productDataSourceMock.updateProduct(any()))
        .thenAnswer((_) async => Product());
    final result = await productRepository.updateProduct(ProductResultModel());
    final actual = result.fold(id, id);
    expect(result.isRight(), true);
    expect(actual, isA<Product>());
  });

  test('should return an error when UpdateProduct', () async {
    when(() => productDataSourceMock.updateProduct(any())).thenThrow(
        (_) async => ProductDataSourceException(
            message: 'Error while updating product'));
    final result = await productRepository.updateProduct(ProductResultModel());
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<ProductDataSourceException>());
  });

  test('should return true when product deleted success', () async {
    when(() => productDataSourceMock.deleteProduct(any()))
        .thenAnswer((_) async => true);
    final result = await productRepository.deleteProduct('id');
    final actual = result.fold(id, id);
    expect(result.isRight(), true);
    expect(actual, isA<bool>());
  });

  test('should return an erro when product deleted', () async {
    when(() => productDataSourceMock.deleteProduct(any()))
        .thenThrow(ProductDataSourceException(message: 'Error'));
    final result = await productRepository.deleteProduct('id');
    final actual = result.fold(id, id);
    expect(result.isLeft(), true);
    expect(actual, isA<ProductDataSourceException>());
  });
}
