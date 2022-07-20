import 'package:dartz/dartz.dart';

import '../../infra/models/product_result_model.dart';
import '../entities/product.dart';
import '../exceptions/product_exceptions.dart';

abstract class IProductRepository {
  Future<Either<IProductExceptions, ProductResultModel>> getProduct(String id);
  Future<Either<IProductExceptions, List<ProductResultModel>>> getAllProducts();
  Future<Either<IProductExceptions, Product>> addProduct(
      ProductResultModel product);
  Future<Either<IProductExceptions, Product>> updateProduct(Product product);
  Future<Either<IProductExceptions, Product>> favoriteProduct(int id);
  Future<Either<IProductExceptions, bool>> deleteProduct(int id);
}
