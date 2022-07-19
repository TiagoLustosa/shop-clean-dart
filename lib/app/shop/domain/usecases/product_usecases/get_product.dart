import 'package:dartz/dartz.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import '../../entities/product.dart';
import '../../exceptions/product_exceptions.dart';
import '../../repositories/product_repository.dart';
import '../base_usecase/base_usecase.dart';

class GetProduct implements UseCase<Product, String> {
  final IProductRepository _productRepository;

  GetProduct(this._productRepository);

  @override
  Future<Either<IProductExceptions, ProductResultModel>> call(id) async {
    if (id.isEmpty) {
      return Left(InvalidIdException());
    }
    return _productRepository.getProduct(id);
  }
}
