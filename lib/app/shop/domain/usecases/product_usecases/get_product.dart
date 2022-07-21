import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/contracts/get_product_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';
import '../../exceptions/product_exceptions.dart';
import '../../repositories/product_repository.dart';

@Injectable(as: IGetProductUseCase)
class GetProductUseCase implements IGetProductUseCase {
  final IProductRepository _productRepository;

  GetProductUseCase(this._productRepository);

  @override
  Future<Either<IProductExceptions, ProductResultModel>> call(id) async {
    if (id.isEmpty) {
      return Left(InvalidIdException());
    }
    return _productRepository.getProduct(id);
  }
}
