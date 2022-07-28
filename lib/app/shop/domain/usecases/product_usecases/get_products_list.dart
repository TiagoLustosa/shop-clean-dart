import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/product_usecases/contracts/get_products_list_usecase_contract.dart';
import '../../exceptions/product_exceptions.dart';
import '../../repositories/product_repository.dart';
import '../base_usecase/base_usecase.dart';

@Injectable(as: IGetProductsListUseCase)
class GetProductsListUseCase implements IGetProductsListUseCase {
  final IProductRepository _productRepository;

  GetProductsListUseCase(this._productRepository);

  @override
  Future<Either<IProductExceptions, List<Product>>> call(
      NoParams params) async {
    final products = await _productRepository.getAllProducts();
    return products.fold(
        (l) => Left(ProductDataSourceException(message: l.toString())),
        (r) => products.where((r) => r.isNotEmpty, () => EmptyList()));
  }
}
