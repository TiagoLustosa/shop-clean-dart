import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/exceptions/product_exceptions.dart';
import 'package:shop_clean_arch/app/shop/domain/repositories/product_repository.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/contracts/update_product_usecase_contract.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';

@Injectable(as: IUpdateProductUseCase)
class UpdateProductUseCase implements IUpdateProductUseCase {
  final IProductRepository _productRepository;

  UpdateProductUseCase(this._productRepository);

  @override
  Future<Either<IProductExceptions, ProductResultModel>> call(
      ProductResultModel product) async {
    final productResult = await _productRepository.updateProduct(product);
    return productResult.fold(
        (l) => Left(ProductDataSourceException(message: l.toString())),
        (r) => Right(r as ProductResultModel));
  }
}
