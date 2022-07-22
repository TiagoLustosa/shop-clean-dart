import 'package:shop_clean_arch/app/shop/domain/entities/product.dart';
import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';

abstract class IGetProductsListUseCase
    implements UseCase<List<Product>, NoParams> {}
