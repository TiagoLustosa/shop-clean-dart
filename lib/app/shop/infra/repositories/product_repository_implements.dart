import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/product_repository.dart';

import '../datasources/product_datasource.dart';
import '../models/product_result_model.dart';

@Injectable(as: IProductRepository)
class ProductRepositoryImplements implements IProductRepository {
  final IProductDataSource _productDataSource;

  ProductRepositoryImplements(this._productDataSource);
  @override
  Future<Either<IProductExceptions, ProductResultModel>> getProduct(
      String id) async {
    try {
      final result = await _productDataSource.getProduct(id);
      return Right(result);
    } on ProductDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ProductDataSourceException(message: e.toString()));
    }
  }

  @override
  Future<Either<IProductExceptions, List<ProductResultModel>>>
      getAllProducts() async {
    List<ProductResultModel> products;

    try {
      products = await _productDataSource.getAllProducts();
    } on ProductDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ProductDataSourceException(message: e.toString()));
    }
    return Right(products);
  }

  @override
  Future<Either<IProductExceptions, Product>> addProduct(
      Product product) async {
    try {
      await _productDataSource.addProduct(product as ProductResultModel);
    } on ProductDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ProductDataSourceException(message: e.toString()));
    }
    return Right(product);
  }

  @override
  Future<Either<IProductExceptions, Product>> updateProduct(
      Product product) async {
    try {
      await _productDataSource.updateProduct(product as ProductResultModel);
    } on ProductDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ProductDataSourceException(message: e.toString()));
    }
    return Right(product);
  }

  @override
  Future<Either<IProductExceptions, Product>> favoriteProduct(String id) {
    // TODO: implement favoriteProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<IProductExceptions, bool>> deleteProduct(String id) async {
    try {
      await _productDataSource.deleteProduct(id);
    } on ProductDataSourceException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ProductDataSourceException(message: e.toString()));
    }
    return Right(true);
  }
}
