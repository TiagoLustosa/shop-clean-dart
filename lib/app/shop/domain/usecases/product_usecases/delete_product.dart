import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/contracts/delete_product_usecase_contract.dart';
import '../../exceptions/product_exceptions.dart';
import '../../repositories/product_repository.dart';

@Injectable(as: IDeleteProductUseCase)
class DeleteProductUseCase implements IDeleteProductUseCase {
  final IProductRepository _productRepository;

  DeleteProductUseCase(this._productRepository);

  @override
  Future<Either<IProductExceptions, bool>> call(String id) async {
    final productResult = await _productRepository.deleteProduct(id);
    return productResult.fold(
        (l) => Left(ProductDataSourceException(message: l.toString())),
        (r) => Right(r));
  }
}
