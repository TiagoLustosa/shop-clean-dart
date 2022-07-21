import '../../domain/entities/product.dart';
import '../models/product_result_model.dart';

abstract class IProductDataSource {
  Future<ProductResultModel> getProduct(String id);
  Future<List<ProductResultModel>> getAllProducts();
  Future<Product> addProduct(ProductResultModel product);
  Future<Product> updateProduct(ProductResultModel product);
  Future<ProductResultModel> favoriteProduct(int id);
  Future<bool> deleteProduct(String id);
}
