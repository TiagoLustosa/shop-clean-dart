import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../exceptions/product_exceptions.dart';

abstract class IProductRepository {
  Future<Either<IProductExceptions, Product>> getProduct(String id);
  Future<Either<IProductExceptions, List<Product>>> getAllProducts();
  Future<Either<IProductExceptions, Product>> addProduct(Product product);
  Future<Either<IProductExceptions, Product>> updateProduct(Product product);
  Future<Either<IProductExceptions, Product>> favoriteProduct(String id);
  Future<Either<IProductExceptions, bool>> deleteProduct(String id);
}
