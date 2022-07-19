import '../models/product_result_model.dart';

abstract class IProductDataSource {
  Future<ProductResultModel> getProduct(String id);
  Future<List<ProductResultModel>> getAllProducts();
  Future<ProductResultModel> createProduct(ProductResultModel product);
  Future<ProductResultModel> updateProduct(ProductResultModel product);
  Future<ProductResultModel> favoriteProduct(int id);
  Future<bool> deleteProduct(int id);
}
