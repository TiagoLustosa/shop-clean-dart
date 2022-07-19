import 'package:dartz/dartz.dart';

import '../../../infra/models/product_result_model.dart';
import '../../entities/product.dart';
import '../../exceptions/product_exceptions.dart';
import '../../repositories/product_repository.dart';
import '../base_usecase/base_usecase.dart';

class AddProductUseCase implements UseCase<Product, Product> {
  final IProductRepository _productRepository;

  AddProductUseCase(this._productRepository);

  @override
  Future<Either<IProductExceptions, ProductResultModel>> call(
      Product product) async {
    final productResult = await _productRepository.addProduct(product);
    return productResult.fold(
        (l) => Left(ProductDataSourceException(message: l.toString())),
        (r) => Right(r as ProductResultModel));
  }
}
