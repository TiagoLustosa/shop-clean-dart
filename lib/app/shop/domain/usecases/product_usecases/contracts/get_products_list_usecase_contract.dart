import 'package:shop_clean_arch/app/shop/domain/usecases/base_usecase/base_usecase.dart';
import 'package:shop_clean_arch/app/shop/infra/models/product_result_model.dart';

abstract class IGetProductsListUseCase
    implements UseCase<List<ProductResultModel>, NoParams> {}
