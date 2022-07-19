import 'package:dartz/dartz.dart';
import '../../../infra/models/product_result_model.dart';
import '../../exceptions/product_exceptions.dart';
import '../../repositories/product_repository.dart';
import '../base_usecase/base_usecase.dart';

class GetProductsListUseCase
    implements UseCase<List<ProductResultModel>, NoParams> {
  final IProductRepository _productRepository;

  GetProductsListUseCase(this._productRepository);

  @override
  Future<Either<IProductExceptions, List<ProductResultModel>>> call(
      NoParams params) async {
    final products = await _productRepository.getAllProducts();
    return products.fold(
        (l) => Left(ProductDataSourceException(message: l.toString())),
        (r) => products.where((r) => r.isNotEmpty, () => EmptyList()));
  }
}
