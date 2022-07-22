import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/product_usecases/contracts/add_product_usecase_contract.dart';
import '../../../infra/models/product_result_model.dart';
import '../../exceptions/product_exceptions.dart';
import '../../repositories/product_repository.dart';

@Injectable(as: IAddProductUseCase)
class AddProductUseCase implements IAddProductUseCase {
  final IProductRepository _productRepository;

  AddProductUseCase(this._productRepository);

  @override
  Future<Either<IProductExceptions, Product>> call(Product product) async {
    final productResult = await _productRepository.addProduct(product);
    return productResult.fold(
        (l) => Left(ProductDataSourceException(message: l.toString())),
        (r) => Right(r));
  }
}
